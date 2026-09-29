import 'dart:convert';

import 'package:aktivizam/data/activism_api.dart';
import 'package:aktivizam/data/data_result.dart';
import 'package:aktivizam/data/source_repository.dart';
import 'package:aktivizam/providers/sources_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

class FakeApi implements ActivismApi {
  String? manifest;
  String? categories;
  String? sources;

  FakeApi({this.manifest, this.categories, this.sources});

  Future<String> _respond(String? body) =>
      body == null ? Future.error(Exception('offline')) : Future.value(body);

  @override
  Future<String> getManifest() => _respond(manifest);

  @override
  Future<String> getCategories() => _respond(categories);

  @override
  Future<String> getSources() => _respond(sources);
}

String manifestAt(DateTime dt) => jsonEncode({'generated_at': dt.toUtc().toIso8601String()});

const categoriesJson = '[{"id":"remote_cat","nameEn":"Remote","nameHr":"Udaljeno","description":""}]';

String sourcesJson(String title) => jsonEncode([
      {
        'url': 'https://example.org/',
        'title': title,
        'description': 'd',
        'categories': ['remote_cat'],
      }
    ]);

FakeApi onlineApi({String title = 'Remote', DateTime? at}) => FakeApi(
      manifest: manifestAt(at ?? DateTime.utc(2100)),
      categories: categoriesJson,
      sources: sourcesJson(title),
    );

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferencesAsyncPlatform.instance = InMemorySharedPreferencesAsync.empty();
  });

  group('SourceRepository', () {
    test('loadLocal falls back to bundled assets when nothing is cached', () async {
      final local = await SourceRepository(FakeApi()).loadLocal();

      expect(local.source, DataSource.asset);
      expect(local.sources, isNotEmpty);
      expect(local.categories, isNotEmpty);
    });

    test('fetchRemote saves data that loadLocal returns on the next launch', () async {
      final remote = await SourceRepository(onlineApi()).fetchRemote();
      expect(remote.source, DataSource.remote);

      final local = await SourceRepository(FakeApi()).loadLocal();
      expect(local.source, DataSource.cache);
      expect(local.sources.single.title, 'Remote');
      expect(local.categories.single.id, 'remote_cat');
    });

    test('a broken download throws and keeps the previous cache', () async {
      await SourceRepository(onlineApi(title: 'Good')).fetchRemote();

      final broken = FakeApi(
        manifest: manifestAt(DateTime.utc(2100)),
        categories: categoriesJson,
        sources: '{not json',
      );
      await expectLater(SourceRepository(broken).fetchRemote(), throwsA(anything));

      final local = await SourceRepository(FakeApi()).loadLocal();
      expect(local.sources.single.title, 'Good');
    });

    test('fetchRemote throws when offline', () async {
      await expectLater(SourceRepository(FakeApi()).fetchRemote(), throwsA(anything));
    });

    test('a missing remote manifest does not block the refresh', () async {
      final api = onlineApi()..manifest = null;
      final remote = await SourceRepository(api).fetchRemote();

      expect(remote.source, DataSource.remote);
      expect(remote.generatedAt, isNull);
    });

    test('bundled assets win over an older cache (e.g. after an app update)', () async {
      await SourceRepository(onlineApi(at: DateTime.utc(2000))).fetchRemote();

      final local = await SourceRepository(FakeApi()).loadLocal();
      expect(local.source, DataSource.asset);
    });

    test('a corrupt cache falls back to bundled assets', () async {
      final prefs = SharedPreferencesAsync();
      await prefs.setString('catalog.categories', '{bad');
      await prefs.setString('catalog.sources', '{bad');

      final local = await SourceRepository(FakeApi()).loadLocal();
      expect(local.source, DataSource.asset);
    });
  });

  group('catalogProvider', () {
    Future<List<Catalog>> collect(FakeApi api) async {
      final container = ProviderContainer(overrides: [
        activismApiProvider.overrideWithValue(api),
      ]);
      addTearDown(container.dispose);

      final emitted = <Catalog>[];
      container.listen<AsyncValue<Catalog>>(catalogProvider, (_, next) {
        if (next.hasValue) emitted.add(next.requireValue);
      });
      // Wait for the stream to finish both steps.
      for (var i = 0; i < 100 && (emitted.isEmpty || emitted.last.isRefreshing); i++) {
        await Future<void>.delayed(const Duration(milliseconds: 10));
      }
      return emitted;
    }

    test('shows local data immediately, then remote data', () async {
      final emitted = await collect(onlineApi());

      expect(emitted.first.source, DataSource.asset);
      expect(emitted.first.isRefreshing, isTrue);
      expect(emitted.first.isStale, isFalse);
      expect(emitted.last.source, DataSource.remote);
      expect(emitted.last.isStale, isFalse);
    });

    test('marks local data as stale once the refresh fails', () async {
      final emitted = await collect(FakeApi());

      expect(emitted.last.source, DataSource.asset);
      expect(emitted.last.isRefreshing, isFalse);
      expect(emitted.last.isStale, isTrue);
    });
  });
}
