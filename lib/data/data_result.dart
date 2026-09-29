import 'package:aktivizam/data/activism_source.dart';
import 'package:aktivizam/data/activitsm_categories.dart';

enum DataSource { remote, cache, asset }

/// Everything the app needs to render, loaded together from one origin.
class Catalog {
  final List<ActivismCategory> categories;
  final List<ActivismSource> sources;
  final DateTime? generatedAt;
  final DataSource source;

  /// True while a background refresh from GitHub is still in flight.
  final bool isRefreshing;

  const Catalog({
    required this.categories,
    required this.sources,
    required this.generatedAt,
    required this.source,
    this.isRefreshing = false,
  });

  /// Stale only once the refresh has given up and we're still on local data.
  bool get isStale => source != DataSource.remote && !isRefreshing;

  Catalog copyWith({bool? isRefreshing}) => Catalog(
        categories: categories,
        sources: sources,
        generatedAt: generatedAt,
        source: source,
        isRefreshing: isRefreshing ?? this.isRefreshing,
      );
}
