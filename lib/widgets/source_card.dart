import 'package:aktivizam/config.dart';
import 'package:aktivizam/data/activism_source.dart';
import 'package:aktivizam/theme.dart';
import 'package:aktivizam/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SourceGrid extends StatelessWidget {
  final List<ActivismSource> sources;
  final int crossAxisCount;
  final void Function(ActivismSource) onTap;

  const SourceGrid({
    super.key,
    required this.sources,
    required this.crossAxisCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (crossAxisCount == 1) {
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: sources.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: SourceListCard(
            source: sources[index],
            onTap: () => onTap(sources[index]),
          ),
        ),
      );
    }

    return MasonryGridView.count(
      padding: const EdgeInsets.all(24),
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      itemCount: sources.length,
      itemBuilder: (context, index) => SourceGridCard(
        source: sources[index],
        onTap: () => onTap(sources[index]),
      ),
    );
  }
}

class SourceListCard extends StatelessWidget {
  final ActivismSource source;
  final VoidCallback onTap;

  const SourceListCard({super.key, required this.source, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: cardBorderColor),
      ),
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: SourceImage(source: source),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      source.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      source.description,
                      style: const TextStyle(
                        fontSize: 13,
                        color: textSecondary,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    if (source.categories.isNotEmpty)
                      Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: source.categories
                            .take(2)
                            .map((e) => CategoryChip(label: e.nameHr))
                            .toList(),
                      ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: textSecondary, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class SourceGridCard extends StatelessWidget {
  final ActivismSource source;
  final VoidCallback onTap;

  const SourceGridCard({super.key, required this.source, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: cardBorderColor),
      ),
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: SourceImage(source: source),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    source.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    source.description,
                    style: const TextStyle(
                      fontSize: 13,
                      color: textSecondary,
                      height: 1.4,
                    ),
                  ),
                  if (source.categories.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: source.categories
                          .take(3)
                          .map((e) => CategoryChip(label: e.nameHr))
                          .toList(),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SourceImage extends StatelessWidget {
  final ActivismSource source;

  const SourceImage({super.key, required this.source});

  @override
  Widget build(BuildContext context) {
    if (source.image.isNotEmpty) {
      return Image.network(
        '$kGithubRawBase/assets/screenshots/${source.image}',
        fit: BoxFit.cover,
        errorBuilder: (_, err, stacktrace) {
          debugPrint(err.toString());
          return SourcePlaceholder(title: source.title);
        },
      );
    }
    return SourcePlaceholder(title: source.title);
  }
}

class SourcePlaceholder extends StatelessWidget {
  final String title;

  const SourcePlaceholder({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: chipBgColor,
      child: Center(
        child: Text(
          title.isNotEmpty ? title[0].toUpperCase() : '?',
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ),
    );
  }
}
