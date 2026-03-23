import 'package:aktivizam/data/activism_path.dart';
import 'package:aktivizam/data/activitsm_categories.dart';
import 'package:aktivizam/theme.dart';
import 'package:aktivizam/widgets/common.dart';
import 'package:aktivizam/widgets/data_freshness_banner.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DesktopSidebar extends StatelessWidget {
  final List<ActivismCategory> filters;
  final void Function(ActivismCategory, bool) onToggle;
  final ActivismPath? selectedPath;
  final void Function(ActivismPath?) onSelectPath;
  final VoidCallback onSuggest;

  const DesktopSidebar({
    super.key,
    required this.filters,
    required this.onToggle,
    required this.selectedPath,
    required this.onSelectPath,
    required this.onSuggest,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: cardBorderColor)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  const Logo(),
                  const SizedBox(height: 28),

                  _sectionLabel('PUTOVI'),
                  const SizedBox(height: 6),
                  PathNavItem(
                    label: 'Svi resursi',
                    emoji: '',
                    selected: selectedPath == null,
                    onTap: () => onSelectPath(null),
                  ),
                  ...ActivismPaths.paths.map(
                    (path) => PathNavItem(
                      label: path.titleHr,
                      emoji: path.emoji,
                      selected: selectedPath?.id == path.id,
                      onTap: () => onSelectPath(path),
                    ),
                  ),

                  const SizedBox(height: 24),

                  _sectionLabel('KATEGORIJE'),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: ActivismCategories.categories.map((e) {
                      final selected = filters.contains(e);
                      return FilterChip(
                        label: Text(e.nameHr),
                        selected: selected,
                        onSelected: (v) => onToggle(e, v),
                        backgroundColor: chipBgColor,
                        selectedColor: primaryColor.withValues(alpha: 0.15),
                        checkmarkColor: primaryColor,
                        labelStyle: TextStyle(
                          fontSize: 13,
                          color: selected ? primaryColor : textPrimary,
                          fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                        ),
                        side: BorderSide(
                          color: selected ? primaryColor : Colors.transparent,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: onSuggest,
                icon: const Icon(Icons.add, size: 16),
                label: const Text('Predloži novi resurs'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: primaryColor,
                  side: const BorderSide(color: primaryColor),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  textStyle: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          const DataFreshnessBanner(),
        ],
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: textSecondary,
        letterSpacing: 1.0,
      ),
    );
  }
}

class DesktopHeader extends StatelessWidget {
  final int count;
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;

  const DesktopHeader({
    super.key,
    required this.count,
    required this.searchController,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchController,
              onChanged: onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Pretraži resurse…',
                hintStyle: const TextStyle(color: textSecondary, fontSize: 14),
                prefixIcon: const Icon(Icons.search, color: textSecondary, size: 20),
                suffixIcon: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: searchController,
                  builder: (_, value, __) => value.text.isEmpty
                      ? const SizedBox.shrink()
                      : IconButton(
                          icon: const Icon(Icons.close, size: 18, color: textSecondary),
                          onPressed: () {
                            searchController.clear();
                            onSearchChanged('');
                          },
                        ),
                ),
                filled: true,
                fillColor: chipBgColor,
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: primaryColor),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            '$count resursa',
            style: const TextStyle(fontSize: 14, color: textSecondary),
          ),
        ],
      ),
    );
  }
}

class PathNavItem extends StatelessWidget {
  final String label;
  final String emoji;
  final bool selected;
  final VoidCallback onTap;

  const PathNavItem({
    super.key,
    required this.label,
    required this.emoji,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
        margin: const EdgeInsets.only(bottom: 2),
        decoration: BoxDecoration(
          color: selected ? primaryColor.withValues(alpha: 0.08) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 22,
              child: emoji.isNotEmpty
                  ? Text(emoji, style: const TextStyle(fontSize: 15))
                  : const Icon(Icons.grid_view_rounded, size: 15, color: textSecondary),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: selected ? primaryColor : textPrimary,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
