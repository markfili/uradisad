class ActivismPath {
  final String id;
  final String titleHr;
  final String emoji;
  final List<String> sourceUrls;

  const ActivismPath({
    required this.id,
    required this.titleHr,
    required this.emoji,
    required this.sourceUrls,
  });
}

class ActivismPaths {
  static const List<ActivismPath> paths = [
    ActivismPath(
      id: 'vlast',
      titleHr: 'Pratim vlast',
      emoji: '🏛',
      sourceUrls: [
        'https://gong.hr/',
        'https://parlametar.hr/',
        'https://www.mozaikveza.hr/',
        'https://www.detektorimovine.hr/',
        'https://imamopravoznati.org/',
        'https://www.sukobinteresa.hr/',
        'https://lookerstudio.google.com/u/0/reporting/cab3e2df-5406-4b30-aa84-244d60361a88/page/ssaoD',
        'https://docs.google.com/spreadsheets/d/1wo_D2bJji_Sbq_tmuvOIlzbSst7Mbl5_TjoB769xVLI/edit?gid=0',
        'https://izbornisimulator.azurewebsites.net/',
        'https://www.portal-ostro.hr/',
        'https://gong.hr/2026/02/24/prijavi-se-na-prvu-gongovu-skolu-za-lokalne-aktiviste-u-sibeniku/',
      ],
    ),
    ActivismPath(
      id: 'okolis',
      titleHr: 'Okoliš i klima',
      emoji: '🌿',
      sourceUrls: [
        'https://www.zelena-akcija.hr/hr',
        'https://zelena-akcija.hr/hr/vijesti/predstavljena-nova-aplikacija-pametni-zeleni-telefon',
        'https://sindikatbiciklista.hr/',
        'https://bajs.informacija.hr/',
        'https://bajsanje.informacija.hr/',
      ],
    ),
    ActivismPath(
      id: 'grad',
      titleHr: 'Grad u pokretu',
      emoji: '🏙',
      sourceUrls: [
        'https://popravi.to/',
        'https://smart.zagreb.hr/',
        'https://geoportal.zagreb.hr/',
        'https://geohub-zagreb.hub.arcgis.com/',
        'https://zagreb.gdi.net/zg3d/',
        'https://zet-info.com/',
        'https://www.kartografija-otpora.org/hr/',
        'https://bajs.informacija.hr/',
      ],
    ),
    ActivismPath(
      id: 'digitalno',
      titleHr: 'Digitalni aktivizam',
      emoji: '💻',
      sourceUrls: [
        'https://pmpc.hr/',
        'https://codeforcroatia.org/',
        'https://slobodnadomena.hr/',
        'https://opencode.hr/',
        'https://digital-strategy.ec.europa.eu/en/policies/regulatory-framework-ai',
        'https://imamopravoznati.org/',
        'https://myth-code.com/',
      ],
    ),
    ActivismPath(
      id: 'prava',
      titleHr: 'Prava i slobode',
      emoji: '✊',
      sourceUrls: [
        'https://www.cms.hr/',
        'https://www.maz.hr/',
        'https://imamopravoznati.org/',
        'https://www.zelena-akcija.hr/hr',
        'https://www.kartografija-otpora.org/hr/',
        'https://gong.hr/',
      ],
    ),
  ];
}
