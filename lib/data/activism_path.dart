class ActivismPath {
  final String id;
  final String titleHr;
  final String emoji;

  const ActivismPath({
    required this.id,
    required this.titleHr,
    required this.emoji,
  });
}

class ActivismPaths {
  static const List<ActivismPath> paths = [
    ActivismPath(id: 'vlast',     titleHr: 'Pratim vlast',       emoji: '🏛'),
    ActivismPath(id: 'okolis',    titleHr: 'Okoliš i klima',     emoji: '🌿'),
    ActivismPath(id: 'grad',      titleHr: 'Grad u pokretu',     emoji: '🏙'),
    ActivismPath(id: 'digitalno', titleHr: 'Digitalni aktivizam', emoji: '💻'),
    ActivismPath(id: 'prava',     titleHr: 'Prava i slobode',    emoji: '✊'),
  ];
}
