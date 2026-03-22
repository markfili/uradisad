import 'package:aktivizam/providers/sources_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DataFreshnessBanner extends ConsumerWidget {
  const DataFreshnessBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isStale = ref.watch(isUsingFallbackProvider);
    if (!isStale) return const SizedBox.shrink();

    final generatedAt = ref.watch(dataGeneratedAtProvider);
    final label = generatedAt != null
        ? 'Prikazuju se pohranjeni podaci (${_formatDate(generatedAt)})'
        : 'Prikazuju se pohranjeni podaci';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: const Color(0xFFFFF3CD),
      child: Row(
        children: [
          const Icon(Icons.cloud_off_outlined, size: 14, color: Color(0xFF856404)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 12, color: Color(0xFF856404)),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime dt) {
    return '${dt.day}. ${dt.month}. ${dt.year}.';
  }
}
