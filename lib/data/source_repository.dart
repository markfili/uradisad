import 'dart:convert';

import 'package:aktivizam/data/activism_api.dart';
import 'package:aktivizam/data/activism_source.dart';
import 'package:aktivizam/data/activitsm_categories.dart';
import 'package:aktivizam/data/data_manifest.dart';
import 'package:aktivizam/data/data_result.dart';
import 'package:flutter/services.dart';

class SourceRepository {
  final ActivismApi _api;

  SourceRepository(this._api);

  Future<DataResult<DataManifest>> getManifest() async {
    try {
      final manifest = await _api.getManifest();
      return DataResult(manifest, DataSource.remote, generatedAt: manifest.generatedAt);
    } catch (_) {
      final raw = await rootBundle.loadString('assets/manifest.json');
      final manifest = DataManifest.fromJson(jsonDecode(raw) as Map<String, dynamic>);
      return DataResult(manifest, DataSource.asset, generatedAt: manifest.generatedAt);
    }
  }

  Future<DataResult<List<ActivismCategory>>> getCategories() async {
    try {
      final data = await _api.getCategories();
      return DataResult(data, DataSource.remote);
    } catch (_) {
      final raw = await rootBundle.loadString('assets/categories.json');
      final data = (jsonDecode(raw) as List)
          .map((e) => ActivismCategory.fromJson(e as Map<String, dynamic>))
          .toList();
      return DataResult(data, DataSource.asset);
    }
  }

  Future<DataResult<List<ActivismSource>>> getSources() async {
    try {
      final data = await _api.getSources();
      return DataResult(data, DataSource.remote);
    } catch (_) {
      final raw = await rootBundle.loadString('assets/sources.json');
      final data = (jsonDecode(raw) as List)
          .map((e) => ActivismSource.fromJson(e as Map<String, dynamic>))
          .toList();
      return DataResult(data, DataSource.asset);
    }
  }
}
