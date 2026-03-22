import 'package:aktivizam/data/activism_source.dart';
import 'package:aktivizam/theme.dart';
import 'package:aktivizam/widgets/common.dart';
import 'package:aktivizam/widgets/source_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkDetailSheet extends StatelessWidget {
  final ActivismSource source;

  const LinkDetailSheet({super.key, required this.source});

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
                  child: LinkDetailBody(
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

class LinkDetailDialog extends StatelessWidget {
  final ActivismSource source;

  const LinkDetailDialog({super.key, required this.source});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: SingleChildScrollView(
          child: LinkDetailBody(source: source, bottomPadding: 0),
        ),
      ),
    );
  }
}

class LinkDetailBody extends StatelessWidget {
  final ActivismSource source;
  final double bottomPadding;

  const LinkDetailBody({
    super.key,
    required this.source,
    required this.bottomPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: SourceImage(source: source),
            ),
            Positioned(
              top: 12,
              right: 12,
              child: Row(
                children: [
                  IconBtn(
                    icon: Icons.bookmark_outline,
                    onTap: () {},
                  ),
                  const SizedBox(width: 8),
                  IconBtn(
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
              if (source.group != null)
                Text(
                  source.group!.toUpperCase(),
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: primaryColor,
                    letterSpacing: 0.8,
                  ),
                ),
              if (source.group != null) const SizedBox(height: 4),
              Text(
                source.title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: textPrimary,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 12),

              if (source.categories.isNotEmpty)
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: source.categories
                      .map((e) => CategoryChip(label: e.nameHr))
                      .toList(),
                ),

              const SizedBox(height: 16),
              const Divider(color: cardBorderColor),
              const SizedBox(height: 16),

              Text(
                source.description,
                style: const TextStyle(
                  fontSize: 15,
                  color: textSecondary,
                  height: 1.6,
                ),
              ),

              if (source.link.isNotEmpty) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: chipBgColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.link, size: 14, color: primaryColor),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          source.link,
                          style: const TextStyle(
                            fontSize: 12,
                            color: primaryColor,
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
                        backgroundColor: primaryColor,
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
                      foregroundColor: textPrimary,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      side: const BorderSide(color: cardBorderColor),
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

class IconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const IconBtn({super.key, required this.icon, required this.onTap});

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
        child: Icon(icon, size: 18, color: textPrimary),
      ),
    );
  }
}
