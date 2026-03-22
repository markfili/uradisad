import 'package:aktivizam/config.dart';
import 'package:aktivizam/data/activism_path.dart';
import 'package:aktivizam/data/activism_source.dart';
import 'package:aktivizam/data/activitsm_categories.dart';
import 'package:aktivizam/providers/filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

const _primaryColor = Color(0xFF2B4BEE);
const _bgColor = Color(0xFFF5F7FF);
const _cardBorderColor = Color(0xFFE5E7EB);
const _chipBgColor = Color(0xFFEEF0FF);
const _textPrimary = Color(0xFF111827);
const _textSecondary = Color(0xFF6B7280);

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: _primaryColor,
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.plusJakartaSansTextTheme(),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  final _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _openDetail(BuildContext context, ActivismSource source) {
    final isDesktop = MediaQuery.sizeOf(context).width >= 1024;
    if (isDesktop) {
      showDialog(
        context: context,
        builder: (_) => _LinkDetailDialog(source: source),
      );
    } else {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => _LinkDetailSheet(source: source),
      );
    }
  }

  void _openSuggest(BuildContext context) {
    final isDesktop = MediaQuery.sizeOf(context).width >= 1024;
    if (isDesktop) {
      showDialog(
        context: context,
        builder: (_) => const _SuggestDialog(),
      );
    } else {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => const _SuggestSheet(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final filtered = ref.watch(filteredSourcesProvider);
    final filter = ref.watch(filterProvider);
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= 1024;

    return Scaffold(
      backgroundColor: _bgColor,
      body: isDesktop ? _buildDesktop(filtered, filter) : _buildMobile(context, filtered, filter),
      // floatingActionButton: isDesktop
      //     ? null
      //     : FloatingActionButton.extended(
      //         onPressed: () => _openSuggest(context),
      //         backgroundColor: _primaryColor,
      //         elevation: 2,
      //         icon: const Icon(Icons.add, color: Colors.white, size: 20),
      //         label: Text(
      //           'Predloži resurs',
      //           style: GoogleFonts.plusJakartaSans(
      //             color: Colors.white,
      //             fontWeight: FontWeight.w700,
      //             fontSize: 14,
      //           ),
      //         ),
      //       ),
    );
  }

  // ── Desktop ──────────────────────────────────────────────────────────────

  Widget _buildDesktop(List<ActivismSource> filtered, FilterState filter) {
    final notifier = ref.read(filterProvider.notifier);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DesktopSidebar(
          filters: filter.categories,
          onToggle: notifier.toggleCategory,
          selectedPath: filter.selectedPath,
          onSelectPath: notifier.selectPath,
          onSuggest: () => _openSuggest(context),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _DesktopHeader(
                count: filtered.length,
                searchController: _searchCtrl,
                onSearchChanged: notifier.setSearchQuery,
              ),
              Expanded(
                child: _SourceGrid(
                  sources: filtered,
                  crossAxisCount: 3,
                  onTap: (s) => _openDetail(context, s),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Mobile ───────────────────────────────────────────────────────────────

  Widget _buildMobile(BuildContext context, List<ActivismSource> filtered, FilterState filter) {
    final notifier = ref.read(filterProvider.notifier);
    return Column(
      children: [
        _MobileHeader(),
        _MobileSearchBar(
          controller: _searchCtrl,
          onChanged: notifier.setSearchQuery,
        ),
        _MobilePathRow(
          selectedPath: filter.selectedPath,
          onSelectPath: notifier.selectPath,
        ),
        _MobileFilterRow(
          filters: filter.categories,
          onToggle: notifier.toggleCategory,
          onClearAll: notifier.clearCategories,
        ),
        const Divider(height: 1, color: _cardBorderColor),
        Expanded(
          child: _SourceGrid(
            sources: filtered,
            crossAxisCount: 1,
            onTap: (s) => _openDetail(context, s),
          ),
        ),
      ],
    );
  }
}

// ── Sidebar (Desktop) ───────────────────────────────────────────────────────

class _DesktopSidebar extends StatelessWidget {
  final List<ActivismCategory> filters;
  final void Function(ActivismCategory, bool) onToggle;
  final ActivismPath? selectedPath;
  final void Function(ActivismPath?) onSelectPath;
  final VoidCallback onSuggest;

  const _DesktopSidebar({
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
        border: Border(right: BorderSide(color: _cardBorderColor)),
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
                  const _Logo(),
                  const SizedBox(height: 28),

                  // Paths section
                  _sectionLabel('PUTOVI'),
                  const SizedBox(height: 6),
                  _PathNavItem(
                    label: 'Svi resursi',
                    emoji: '',
                    selected: selectedPath == null,
                    onTap: () => onSelectPath(null),
                  ),
                  ...ActivismPaths.paths.map(
                    (path) => _PathNavItem(
                      label: path.titleHr,
                      emoji: path.emoji,
                      selected: selectedPath?.id == path.id,
                      onTap: () => onSelectPath(path),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Categories section
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
                        backgroundColor: _chipBgColor,
                        selectedColor: _primaryColor.withValues(alpha: 0.15),
                        checkmarkColor: _primaryColor,
                        labelStyle: TextStyle(
                          fontSize: 13,
                          color: selected ? _primaryColor : _textPrimary,
                          fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                        ),
                        side: BorderSide(
                          color: selected ? _primaryColor : Colors.transparent,
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

          // Suggest button pinned at bottom — disabled until feature is ready
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
          //   child: OutlinedButton.icon(
          //     onPressed: onSuggest,
          //     icon: const Icon(Icons.add, size: 16),
          //     label: const Text('Predloži resurs'),
          //     style: OutlinedButton.styleFrom(
          //       minimumSize: const Size(double.infinity, 44),
          //       foregroundColor: _primaryColor,
          //       side: const BorderSide(color: _primaryColor),
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(10),
          //       ),
          //       textStyle: GoogleFonts.plusJakartaSans(
          //         fontSize: 14,
          //         fontWeight: FontWeight.w600,
          //       ),
          //     ),
          //   ),
          // ),
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
        color: _textSecondary,
        letterSpacing: 1.0,
      ),
    );
  }
}

// ── Desktop header ────────────────────────────────────────────────────────────

class _DesktopHeader extends StatelessWidget {
  final int count;
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;

  const _DesktopHeader({
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
                hintStyle: const TextStyle(color: _textSecondary, fontSize: 14),
                prefixIcon: const Icon(Icons.search, color: _textSecondary, size: 20),
                suffixIcon: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: searchController,
                  builder: (_, value, __) => value.text.isEmpty
                      ? const SizedBox.shrink()
                      : IconButton(
                          icon: const Icon(Icons.close, size: 18, color: _textSecondary),
                          onPressed: () {
                            searchController.clear();
                            onSearchChanged('');
                          },
                        ),
                ),
                filled: true,
                fillColor: _chipBgColor,
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: _primaryColor),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            '$count resursa',
            style: const TextStyle(fontSize: 14, color: _textSecondary),
          ),
        ],
      ),
    );
  }
}

// ── Mobile header ─────────────────────────────────────────────────────────────

class _MobileHeader extends StatelessWidget {
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
      child: const _Logo(),
    );
  }
}

// ── Mobile search bar ─────────────────────────────────────────────────────────

class _MobileSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const _MobileSearchBar({required this.controller, required this.onChanged});

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
          hintStyle: const TextStyle(color: _textSecondary, fontSize: 14),
          prefixIcon: const Icon(Icons.search, color: _textSecondary, size: 20),
          suffixIcon: ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (_, value, __) => value.text.isEmpty
                ? const SizedBox.shrink()
                : IconButton(
                    icon: const Icon(Icons.close, size: 18, color: _textSecondary),
                    onPressed: () {
                      controller.clear();
                      onChanged('');
                    },
                  ),
          ),
          filled: true,
          fillColor: _chipBgColor,
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: _primaryColor),
          ),
        ),
      ),
    );
  }
}

// ── Mobile path row ───────────────────────────────────────────────────────────

class _MobilePathRow extends StatelessWidget {
  final ActivismPath? selectedPath;
  final void Function(ActivismPath?) onSelectPath;

  const _MobilePathRow({required this.selectedPath, required this.onSelectPath});

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
            _PillChip(
              label: 'Sve',
              selected: selectedPath == null,
              onTap: () => onSelectPath(null),
            ),
            ...ActivismPaths.paths.map(
              (path) => Padding(
                padding: const EdgeInsets.only(left: 8),
                child: _PillChip(
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

// ── Mobile filter row ─────────────────────────────────────────────────────────

class _MobileFilterRow extends StatelessWidget {
  final List<ActivismCategory> filters;
  final void Function(ActivismCategory, bool) onToggle;
  final VoidCallback onClearAll;

  const _MobileFilterRow({
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
            _PillChip(
              label: 'Svi',
              selected: filters.isEmpty,
              onTap: onClearAll,
            ),
            ...ActivismCategories.categories.map((e) {
              final selected = filters.contains(e);
              return Padding(
                padding: const EdgeInsets.only(left: 8),
                child: _PillChip(
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

class _PillChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _PillChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? _primaryColor : _chipBgColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : _textPrimary,
          ),
        ),
      ),
    );
  }
}

// ── Logo ──────────────────────────────────────────────────────────────────────

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: _primaryColor,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          'URADI SAD',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: _primaryColor,
          ),
        ),
      ],
    );
  }
}

// ── Grid / List ───────────────────────────────────────────────────────────────

class _SourceGrid extends StatelessWidget {
  final List<ActivismSource> sources;
  final int crossAxisCount;
  final void Function(ActivismSource) onTap;

  const _SourceGrid({
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
          child: _SourceListCard(
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
      itemBuilder: (context, index) => _SourceGridCard(
        source: sources[index],
        onTap: () => onTap(sources[index]),
      ),
    );
  }
}

// ── List card (mobile) ────────────────────────────────────────────────────────

class _SourceListCard extends StatelessWidget {
  final ActivismSource source;
  final VoidCallback onTap;

  const _SourceListCard({required this.source, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: _cardBorderColor),
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
                  child: _SourceImage(source: source),
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
                        color: _textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      source.description,
                      style: const TextStyle(
                        fontSize: 13,
                        color: _textSecondary,
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
                        children: source.categories.take(2).map((e) => _CategoryChip(label: e.nameHr)).toList(),
                      ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: _textSecondary, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Grid card (desktop) ───────────────────────────────────────────────────────

class _SourceGridCard extends StatelessWidget {
  final ActivismSource source;
  final VoidCallback onTap;

  const _SourceGridCard({required this.source, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: _cardBorderColor),
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
                child: _SourceImage(source: source),
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
                      color: _textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    source.description,
                    style: const TextStyle(
                      fontSize: 13,
                      color: _textSecondary,
                      height: 1.4,
                    ),
                  ),
                  if (source.categories.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: source.categories.take(3).map((e) => _CategoryChip(label: e.nameHr)).toList(),
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

// ── Link Detail Sheet (mobile modal bottom sheet) ─────────────────────────────

class _LinkDetailSheet extends StatelessWidget {
  final ActivismSource source;

  const _LinkDetailSheet({required this.source});

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return DraggableScrollableSheet(
      initialChildSize: 0.88,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Drag handle
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD1D5DB),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: _LinkDetailBody(
                    source: source,
                    bottomPadding: bottomPadding,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ── Link Detail Dialog (desktop centered dialog) ──────────────────────────────

class _LinkDetailDialog extends StatelessWidget {
  final ActivismSource source;

  const _LinkDetailDialog({required this.source});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: SingleChildScrollView(
          child: _LinkDetailBody(source: source, bottomPadding: 0),
        ),
      ),
    );
  }
}

// ── Shared detail body ────────────────────────────────────────────────────────

class _LinkDetailBody extends StatelessWidget {
  final ActivismSource source;
  final double bottomPadding;

  const _LinkDetailBody({
    required this.source,
    required this.bottomPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image with close + bookmark overlay
        Stack(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: _SourceImage(source: source),
            ),
            Positioned(
              top: 12,
              right: 12,
              child: Row(
                children: [
                  _IconBtn(
                    icon: Icons.bookmark_outline,
                    onTap: () {},
                  ),
                  const SizedBox(width: 8),
                  _IconBtn(
                    icon: Icons.close,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
          ],
        ),

        Padding(
          padding: EdgeInsets.fromLTRB(24, 20, 24, 24 + bottomPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title + site name
              if (source.group != null)
                Text(
                  source.group!.toUpperCase(),
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: _primaryColor,
                    letterSpacing: 0.8,
                  ),
                ),
              if (source.group != null) const SizedBox(height: 4),
              Text(
                source.title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: _textPrimary,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 12),

              // Categories
              if (source.categories.isNotEmpty)
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: source.categories.map((e) => _CategoryChip(label: e.nameHr)).toList(),
                ),

              const SizedBox(height: 16),
              const Divider(color: _cardBorderColor),
              const SizedBox(height: 16),

              // Description
              Text(
                source.description,
                style: const TextStyle(
                  fontSize: 15,
                  color: _textSecondary,
                  height: 1.6,
                ),
              ),

              // URL chip
              if (source.link.isNotEmpty) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: _chipBgColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.link, size: 14, color: _primaryColor),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          source.link,
                          style: const TextStyle(
                            fontSize: 12,
                            color: _primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 24),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: source.link.isNotEmpty
                          ? () => launchUrl(
                                Uri.parse(source.link),
                                mode: LaunchMode.externalApplication,
                              )
                          : null,
                      icon: const Icon(Icons.open_in_new, size: 16),
                      label: const Text('Posjeti stranicu'),
                      style: FilledButton.styleFrom(
                        backgroundColor: _primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        textStyle: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.share_outlined, size: 16),
                    label: const Text('Dijeli'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: _textPrimary,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      side: const BorderSide(color: _cardBorderColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Shared widgets ────────────────────────────────────────────────────────────

class _IconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _IconBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 18, color: _textPrimary),
      ),
    );
  }
}

class _SourceImage extends StatelessWidget {
  final ActivismSource source;

  const _SourceImage({required this.source});

  @override
  Widget build(BuildContext context) {
    if (source.image.isNotEmpty) {
      return Image.network(
        '$kGithubRawBase/assets/screenshots/${source.image}',
        fit: BoxFit.cover,
        errorBuilder: (_, err, stacktrace) {
          debugPrint(err.toString());
          return _Placeholder(title: source.title);
        },
      );
    }
    return _Placeholder(title: source.title);
  }
}

class _Placeholder extends StatelessWidget {
  final String title;

  const _Placeholder({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _chipBgColor,
      child: Center(
        child: Text(
          title.isNotEmpty ? title[0].toUpperCase() : '?',
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: _primaryColor,
          ),
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;

  const _CategoryChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: _chipBgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: _primaryColor,
        ),
      ),
    );
  }
}

// ── Path nav item (Desktop sidebar) ──────────────────────────────────────────

class _PathNavItem extends StatelessWidget {
  final String label;
  final String emoji;
  final bool selected;
  final VoidCallback onTap;

  const _PathNavItem({
    required this.label,
    required this.emoji,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
        margin: const EdgeInsets.only(bottom: 2),
        decoration: BoxDecoration(
          color: selected ? _primaryColor.withValues(alpha: 0.08) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 22,
              child: emoji.isNotEmpty
                  ? Text(emoji, style: const TextStyle(fontSize: 15))
                  : const Icon(Icons.grid_view_rounded, size: 15, color: _textSecondary),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: selected ? _primaryColor : _textPrimary,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Suggest resource (mobile bottom sheet) ────────────────────────────────────

class _SuggestSheet extends StatelessWidget {
  const _SuggestSheet();

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFD1D5DB),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          _SuggestForm(bottomPadding: bottomPadding),
        ],
      ),
    );
  }
}

// ── Suggest resource (desktop dialog) ────────────────────────────────────────

class _SuggestDialog extends StatelessWidget {
  const _SuggestDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: const _SuggestForm(bottomPadding: 0),
      ),
    );
  }
}

// ── Shared suggest form ───────────────────────────────────────────────────────

class _SuggestForm extends StatefulWidget {
  final double bottomPadding;

  const _SuggestForm({this.bottomPadding = 0});

  @override
  State<_SuggestForm> createState() => _SuggestFormState();
}

class _SuggestFormState extends State<_SuggestForm> {
  final _urlCtrl = TextEditingController();
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();

  @override
  void dispose() {
    _urlCtrl.dispose();
    _titleCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    final url = _urlCtrl.text.trim();
    if (url.isEmpty) return;
    final title = _titleCtrl.text.trim();
    final desc = _descCtrl.text.trim();

    final subject = Uri.encodeComponent(
      'Prijedlog resursa${title.isNotEmpty ? ": $title" : ""}',
    );
    final bodyLines = [
      'URL: $url',
      if (title.isNotEmpty) '\nNaziv: $title',
      if (desc.isNotEmpty) '\nOpis: $desc',
      '\n\n---\nPoslan putem HR Aktivizam app',
    ];
    final body = Uri.encodeComponent(bodyLines.join());

    launchUrl(
      Uri.parse('mailto:arilus.hr@gmail.com?subject=$subject&body=$body'),
      mode: LaunchMode.externalApplication,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(24, 20, 24, 24 + widget.bottomPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Predloži resurs',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: _textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Poznaješ dobar alat ili organizaciju za HR aktivizam? Pošalji prijedlog — uredit ćemo i dodati.',
            style: TextStyle(fontSize: 14, color: _textSecondary, height: 1.5),
          ),
          const SizedBox(height: 20),
          _SuggestField(
            controller: _urlCtrl,
            label: 'URL *',
            hint: 'https://...',
            keyboardType: TextInputType.url,
          ),
          const SizedBox(height: 12),
          _SuggestField(
            controller: _titleCtrl,
            label: 'Naziv (opcionalno)',
            hint: 'Npr. Popravi.to',
          ),
          const SizedBox(height: 12),
          _SuggestField(
            controller: _descCtrl,
            label: 'Kratki opis (opcionalno)',
            hint: 'Što ova stranica radi?',
            maxLines: 3,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: _submit,
              icon: const Icon(Icons.open_in_new, size: 16),
              label: const Text('Pošalji email'),
              style: FilledButton.styleFrom(
                backgroundColor: _primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SuggestField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final int maxLines;
  final TextInputType? keyboardType;

  const _SuggestField({
    required this.controller,
    required this.label,
    required this.hint,
    this.maxLines = 1,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: _textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: _textSecondary, fontSize: 14),
            filled: true,
            fillColor: _chipBgColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: _primaryColor, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          ),
        ),
      ],
    );
  }
}
