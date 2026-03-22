import 'package:aktivizam/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class SuggestSheet extends StatelessWidget {
  final String initialUrl;
  final String? initialSubject;

  const SuggestSheet({super.key, this.initialUrl = '', this.initialSubject});

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
          SuggestForm(bottomPadding: bottomPadding, initialUrl: initialUrl, initialSubject: initialSubject),
        ],
      ),
    );
  }
}

class SuggestDialog extends StatelessWidget {
  final String initialUrl;
  final String? initialSubject;

  const SuggestDialog({super.key, this.initialUrl = '', this.initialSubject});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: SuggestForm(bottomPadding: 0, initialUrl: initialUrl, initialSubject: initialSubject),
      ),
    );
  }
}

class SuggestForm extends StatefulWidget {
  final double bottomPadding;
  final String initialUrl;
  final String? initialSubject;

  const SuggestForm({super.key, this.bottomPadding = 0, this.initialUrl = '', this.initialSubject});

  @override
  State<SuggestForm> createState() => _SuggestFormState();
}

class _SuggestFormState extends State<SuggestForm> {
  final _urlCtrl = TextEditingController();
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _urlCtrl.text = widget.initialUrl;
  }

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
      widget.initialSubject ?? 'Prijedlog resursa${title.isNotEmpty ? ": $title" : ""}',
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
              color: textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Poznaješ dobar alat ili organizaciju za HR aktivizam? Pošalji prijedlog — uredit ćemo i dodati.',
            style: TextStyle(fontSize: 14, color: textSecondary, height: 1.5),
          ),
          const SizedBox(height: 20),
          SuggestField(
            controller: _urlCtrl,
            label: 'URL *',
            hint: 'https://...',
            keyboardType: TextInputType.url,
          ),
          const SizedBox(height: 12),
          SuggestField(
            controller: _titleCtrl,
            label: 'Naziv (opcionalno)',
            hint: 'Npr. Popravi.to',
          ),
          const SizedBox(height: 12),
          SuggestField(
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
        ],
      ),
    );
  }
}

class SuggestField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final int maxLines;
  final TextInputType? keyboardType;

  const SuggestField({
    super.key,
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
            color: textPrimary,
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
            hintStyle: const TextStyle(color: textSecondary, fontSize: 14),
            filled: true,
            fillColor: chipBgColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: primaryColor, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          ),
        ),
      ],
    );
  }
}
