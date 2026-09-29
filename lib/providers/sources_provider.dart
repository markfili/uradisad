import 'package:aktivizam/config.dart';
import 'package:aktivizam/data/activism_api.dart';
import 'package:aktivizam/data/activism_source.dart';
import 'package:aktivizam/data/activitsm_categories.dart';
import 'package:aktivizam/data/data_result.dart';
import 'package:aktivizam/data/source_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(
    baseUrl: kGithubRawBase,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 10),
  ));
});

final activismApiProvider = Provider<ActivismApi>((ref) {
  return ActivismApi(ref.watch(dioProvider));
});

final repositoryProvider = Provider<SourceRepository>((ref) {
  return SourceRepository(ref.watch(activismApiProvider));
});

/// Stale-while-revalidate: emits local data (cache or bundle) immediately,
/// then fresh data from GitHub once it arrives.
final catalogProvider = StreamProvider<Catalog>((ref) async* {
  final repo = ref.watch(repositoryProvider);

  final local = await repo.loadLocal();
  ActivismCategories.setCategories(local.categories);
  yield local.copyWith(isRefreshing: true);

  try {
    final remote = await repo.fetchRemote();
    ActivismCategories.setCategories(remote.categories);
    yield remote;
  } catch (_) {
    yield local;
  }
});

final sourcesProvider = Provider<AsyncValue<List<ActivismSource>>>((ref) {
  return ref.watch(catalogProvider).whenData((c) => c.sources);
});

/// True when the refresh failed and local data is shown (no internet / GitHub down).
final isUsingFallbackProvider = Provider<bool>((ref) {
  return ref.watch(catalogProvider).value?.isStale ?? false;
});

/// Timestamp from the manifest of the data currently shown.
final dataGeneratedAtProvider = Provider<DateTime?>((ref) {
  return ref.watch(catalogProvider).value?.generatedAt;
});
