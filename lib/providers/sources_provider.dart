import 'package:aktivizam/config.dart';
import 'package:aktivizam/data/activism_api.dart';
import 'package:aktivizam/data/activism_source.dart';
import 'package:aktivizam/data/activitsm_categories.dart';
import 'package:aktivizam/data/data_manifest.dart';
import 'package:aktivizam/data/data_result.dart';
import 'package:aktivizam/data/source_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(baseUrl: kGithubRawBase));
});

final activismApiProvider = Provider<ActivismApi>((ref) {
  return ActivismApi(ref.watch(dioProvider));
});

final repositoryProvider = Provider<SourceRepository>((ref) {
  return SourceRepository(ref.watch(activismApiProvider));
});

final manifestProvider = FutureProvider<DataResult<DataManifest>>((ref) {
  return ref.watch(repositoryProvider).getManifest();
});

final categoriesResultProvider = FutureProvider<DataResult<List<ActivismCategory>>>((ref) {
  return ref.watch(repositoryProvider).getCategories();
});

final sourcesResultProvider = FutureProvider<DataResult<List<ActivismSource>>>((ref) async {
  final catResult = await ref.watch(categoriesResultProvider.future);
  ActivismCategories.setCategories(catResult.data);
  return ref.watch(repositoryProvider).getSources();
});

/// Convenience provider — same AsyncValue shape as the old `sourcesProvider`
/// so that `filteredSourcesProvider` in filter_provider.dart needs no changes.
final sourcesProvider = Provider<AsyncValue<List<ActivismSource>>>((ref) {
  return ref.watch(sourcesResultProvider).whenData((r) => r.data);
});

/// True when sources were loaded from the bundled assets (no internet / GitHub down).
final isUsingFallbackProvider = Provider<bool>((ref) {
  return ref.watch(sourcesResultProvider).valueOrNull?.isStale ?? false;
});

/// Timestamp from the manifest of the data currently shown.
final dataGeneratedAtProvider = Provider<DateTime?>((ref) {
  return ref.watch(manifestProvider).valueOrNull?.generatedAt;
});
