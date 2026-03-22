import 'package:aktivizam/data/activism_path.dart';
import 'package:aktivizam/data/activitsm_categories.dart';
import 'package:aktivizam/theme.dart';
import 'package:aktivizam/widgets/common.dart';
import 'package:flutter/material.dart';

class MobileHeader extends StatelessWidget {
  const MobileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8,
        left: 20,
        right: 20,
        bottom: 12,
      ),
      child: const Logo(),
    );
  }
}

class MobileSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const MobileSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Pretraži resurse…',
          hintStyle: const TextStyle(color: textSecondary, fontSize: 14),
          prefixIcon: const Icon(Icons.search, color: textSecondary, size: 20),
          suffixIcon: ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (_, value, __) => value.text.isEmpty
                ? const SizedBox.shrink()
                : IconButton(
                    icon: const Icon(Icons.close, size: 18, color: textSecondary),
                    onPressed: () {
                      controller.clear();
                      onChanged('');
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
    );
  }
}

class MobilePathRow extends StatelessWidget {
  final ActivismPath? selectedPath;
  final void Function(ActivismPath?) onSelectPath;

  const MobilePathRow({
    super.key,
    required this.selectedPath,
    required this.onSelectPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 2, bottom: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            PillChip(
              label: 'Sve',
              selected: selectedPath == null,
              onTap: () => onSelectPath(null),
            ),
            ...ActivismPaths.paths.map(
              (path) => Padding(
                padding: const EdgeInsets.only(left: 8),
                child: PillChip(
                  label: '${path.emoji} ${path.titleHr}',
                  selected: selectedPath?.id == path.id,
                  onTap: () => onSelectPath(path),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MobileFilterRow extends StatelessWidget {
  final List<ActivismCategory> filters;
  final void Function(ActivismCategory, bool) onToggle;
  final VoidCallback onClearAll;

  const MobileFilterRow({
    super.key,
    required this.filters,
    required this.onToggle,
    required this.onClearAll,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(bottom: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            PillChip(
              label: 'Svi',
              selected: filters.isEmpty,
              onTap: onClearAll,
            ),
            ...ActivismCategories.categories.map((e) {
              final selected = filters.contains(e);
              return Padding(
                padding: const EdgeInsets.only(left: 8),
                child: PillChip(
                  label: e.nameHr,
                  selected: selected,
                  onTap: () => onToggle(e, !selected),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
