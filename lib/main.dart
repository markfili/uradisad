import 'package:aktivizam/data/activism_source.dart';
import 'package:aktivizam/providers/filter_provider.dart';
import 'package:aktivizam/theme.dart';
import 'package:aktivizam/widgets/data_freshness_banner.dart';
import 'package:aktivizam/widgets/desktop_layout.dart';
import 'package:aktivizam/widgets/mobile_layout.dart';
import 'package:aktivizam/widgets/source_card.dart';
import 'package:aktivizam/widgets/source_detail.dart';
import 'package:aktivizam/widgets/suggest_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

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
          seedColor: primaryColor,
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
        builder: (_) => LinkDetailDialog(source: source),
      );
    } else {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => LinkDetailSheet(source: source),
      );
    }
  }

  void _openSuggest(BuildContext context) {
    final isDesktop = MediaQuery.sizeOf(context).width >= 1024;
    if (isDesktop) {
      showDialog(
        context: context,
        builder: (_) => const SuggestDialog(),
      );
    } else {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => const SuggestSheet(),
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
      backgroundColor: bgColor,
      body: isDesktop ? _buildDesktop(filtered, filter) : _buildMobile(context, filtered, filter),
    );
  }

  // ── Desktop ──────────────────────────────────────────────────────────────

  Widget _buildDesktop(List<ActivismSource> filtered, FilterState filter) {
    final notifier = ref.read(filterProvider.notifier);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DesktopSidebar(
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
              DesktopHeader(
                count: filtered.length,
                searchController: _searchCtrl,
                onSearchChanged: notifier.setSearchQuery,
              ),
              Expanded(
                child: SourceGrid(
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
        MobileHeader(onSuggest: () => _openSuggest(context)),
        const DataFreshnessBanner(),
        MobileSearchBar(
          controller: _searchCtrl,
          onChanged: notifier.setSearchQuery,
        ),
        MobilePathRow(
          selectedPath: filter.selectedPath,
          onSelectPath: notifier.selectPath,
        ),
        MobileFilterRow(
          filters: filter.categories,
          onToggle: notifier.toggleCategory,
          onClearAll: notifier.clearCategories,
        ),
        const Divider(height: 1, color: cardBorderColor),
        Expanded(
          child: SourceGrid(
            sources: filtered,
            crossAxisCount: 1,
            onTap: (s) => _openDetail(context, s),
          ),
        ),
      ],
    );
  }
}
