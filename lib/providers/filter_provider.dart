import 'package:aktivizam/data/activism_path.dart';
import 'package:aktivizam/data/activism_source.dart';
import 'package:aktivizam/data/activitsm_categories.dart';
import 'package:aktivizam/providers/sources_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterState {
  final List<ActivismCategory> categories;
  final ActivismPath? selectedPath;
  final String searchQuery;

  const FilterState({
    this.categories = const [],
    this.selectedPath,
    this.searchQuery = '',
  });
}

class FilterNotifier extends Notifier<FilterState> {
  @override
  FilterState build() => const FilterState();

  void toggleCategory(ActivismCategory category, bool selected) {
    final updated = selected
        ? [...state.categories, category]
        : state.categories.where((c) => c != category).toList();
    state = FilterState(
      categories: updated,
      selectedPath: state.selectedPath,
      searchQuery: state.searchQuery,
    );
  }

  void selectPath(ActivismPath? path) {
    state = FilterState(selectedPath: path, searchQuery: state.searchQuery);
  }

  void setSearchQuery(String query) {
    state = FilterState(
      categories: state.categories,
      selectedPath: state.selectedPath,
      searchQuery: query,
    );
  }

  void clearCategories() {
    state = FilterState(
      selectedPath: state.selectedPath,
      searchQuery: state.searchQuery,
    );
  }
}

final filterProvider = NotifierProvider<FilterNotifier, FilterState>(FilterNotifier.new);

final filteredSourcesProvider = Provider<List<ActivismSource>>((ref) {
  final allSources = ref.watch(sourcesProvider).valueOrNull ?? [];
  final filter = ref.watch(filterProvider);

  var result = filter.selectedPath != null
      ? allSources.where((s) => s.paths.contains(filter.selectedPath!.id)).toList()
      : List<ActivismSource>.from(allSources);

  if (filter.categories.isNotEmpty) {
    result = result.where((s) => filter.categories.every((f) => s.categories.contains(f))).toList();
  }

  if (filter.searchQuery.isNotEmpty) {
    final q = filter.searchQuery.toLowerCase();
    result = result
        .where((s) => s.title.toLowerCase().contains(q) || s.description.toLowerCase().contains(q))
        .toList();
  }

  return result;
});
