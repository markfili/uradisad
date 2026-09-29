import 'dart:convert';

import 'package:aktivizam/data/activism_api.dart';
import 'package:aktivizam/data/activism_source.dart';
import 'package:aktivizam/data/activitsm_categories.dart';
import 'package:aktivizam/data/data_manifest.dart';
import 'package:aktivizam/data/data_result.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Raw JSON for the three data files, as received from GitHub or the bundle.
class _RawCatalog {
  final String? manifest;
  final String categories;
  final String sources;

  const _RawCatalog({this.manifest, required this.categories, required this.sources});
}

class SourceRepository {
  static const _manifestKey = 'catalog.manifest';
  static const _categoriesKey = 'catalog.categories';
  static const _sourcesKey = 'catalog.sources';
  static const _remoteTimeout = Duration(seconds: 10);

  final ActivismApi _api;
  final SharedPreferencesAsync _prefs;

  SourceRepository(this._api, [SharedPreferencesAsync? prefs])
      : _prefs = prefs ?? SharedPreferencesAsync();

  /// Fastest data available on the device: the last saved download, or the
  /// bundled assets when nothing was saved yet or the bundle is newer
  /// (e.g. right after an app update).
  Future<Catalog> loadLocal() async {
    final bundled = _parse(await _loadBundled(), DataSource.asset);
    try {
      final cached = await _loadCached();
      if (cached == null) return bundled;
      final parsed = _parse(cached, DataSource.cache);
      final cachedAt = parsed.generatedAt;
      final bundledAt = bundled.generatedAt;
      if (cachedAt != null && bundledAt != null && bundledAt.isAfter(cachedAt)) {
        return bundled;
      }
      return parsed;
    } catch (_) {
      // Corrupt or unreadable cache — the bundle is always valid.
      return bundled;
    }
  }

  /// Downloads fresh data and saves it for the next launch.
  /// Throws if any required file can't be fetched or parsed.
  Future<Catalog> fetchRemote() async {
    final results = await Future.wait([
      _api.getManifest().then<String?>((v) => v).catchError((_) => null),
      _api.getCategories(),
      _api.getSources(),
    ]).timeout(_remoteTimeout);

    final raw = _RawCatalog(manifest: results[0], categories: results[1]!, sources: results[2]!);
    // Parse before saving so a broken download never replaces a good cache.
    final catalog = _parse(raw, DataSource.remote);
    await _save(raw);
    return catalog;
  }

  Future<_RawCatalog> _loadBundled() async {
    final results = await Future.wait([
      rootBundle.loadString('assets/manifest.json'),
      rootBundle.loadString('assets/categories.json'),
      rootBundle.loadString('assets/sources.json'),
    ]);
    return _RawCatalog(manifest: results[0], categories: results[1], sources: results[2]);
  }

  Future<_RawCatalog?> _loadCached() async {
    final categories = await _prefs.getString(_categoriesKey);
    final sources = await _prefs.getString(_sourcesKey);
    if (categories == null || sources == null) return null;
    return _RawCatalog(
      manifest: await _prefs.getString(_manifestKey),
      categories: categories,
      sources: sources,
    );
  }

  Future<void> _save(_RawCatalog raw) async {
    try {
      await Future.wait([
        _prefs.setString(_categoriesKey, raw.categories),
        _prefs.setString(_sourcesKey, raw.sources),
        if (raw.manifest != null) _prefs.setString(_manifestKey, raw.manifest!) else _prefs.remove(_manifestKey),
      ]);
    } catch (_) {
      // Saving is best-effort; the fresh data is still shown.
    }
  }

  Catalog _parse(_RawCatalog raw, DataSource source) {
    DateTime? generatedAt;
    if (raw.manifest != null) {
      try {
        generatedAt = DataManifest.fromJson(jsonDecode(raw.manifest!) as Map<String, dynamic>).generatedAt;
      } catch (_) {}
    }
    return Catalog(
      categories: (jsonDecode(raw.categories) as List)
          .map((e) => ActivismCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
      sources: (jsonDecode(raw.sources) as List)
          .map((e) => ActivismSource.fromJson(e as Map<String, dynamic>))
          .toList(),
      generatedAt: generatedAt,
      source: source,
    );
  }
}
