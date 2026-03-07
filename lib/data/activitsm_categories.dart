class ActivismCategory {
  final String id;
  final String nameEn;
  final String nameHr;
  final String description;

  const ActivismCategory({
    required this.id,
    required this.nameEn,
    required this.nameHr,
    required this.description,
  });
}

class ActivismCategories {

  static List<ActivismCategory> getCategoriesByIds(List<dynamic> ids) {
    return categories.where((element) => ids.contains(element.id)).toList();
  }
  static const List<ActivismCategory> categories = [
    ActivismCategory(
      id: 'public_education',
      nameEn: 'Public education campaigns',
      nameHr: 'Kampanje javnog obrazovanja',
      description: 'Podizanje svijesti kroz dijeljenje informacija.',
    ),
    ActivismCategory(
      id: 'media_advocacy',
      nameEn: 'Media advocacy',
      nameHr: 'Medijsko zagovaranje',
      description: 'Korištenje medijskih kanala za promicanje ciljeva.',
    ),
    ActivismCategory(
      id: 'social_media',
      nameEn: 'Social media activism',
      nameHr: 'Aktivizam na društvenim mrežama',
      description: 'Online kampanje i pokreti s hashtagovima.',
    ),
    ActivismCategory(
      id: 'information',
      nameEn: 'Information dissemination',
      nameHr: 'Širenje informacija',
      description: 'Objavljivanje izvještaja, istraživanja i edukativnih materijala.',
    ),
    ActivismCategory(
      id: 'protests',
      nameEn: 'Protests and demonstrations',
      nameHr: 'Prosvjedi i demonstracije',
      description: 'Javna okupljanja za izražavanje neslaganja.',
    ),
    ActivismCategory(
      id: 'strikes',
      nameEn: 'Strikes and walkouts',
      nameHr: 'Štrajkovi i obustave rada',
      description: 'Uskraćivanje rada radi zahtijevanja promjena.',
    ),
    ActivismCategory(
      id: 'sit_ins',
      nameEn: 'Sit-ins and occupations',
      nameHr: 'Sjedeći prosvjedi i okupacije',
      description: 'Fizičko zauzimanje prostora kao oblik prosvjeda.',
    ),
    ActivismCategory(
      id: 'boycotts',
      nameEn: 'Boycotts',
      nameHr: 'Bojkoti',
      description: 'Odbijanje kupnje proizvoda ili usluga.',
    ),
    ActivismCategory(
      id: 'civil_disobedience',
      nameEn: 'Civil disobedience',
      nameHr: 'Građanski neposluh',
      description: 'Namjerno kršenje nepravednih zakona.',
    ),
    ActivismCategory(
      id: 'lobbying',
      nameEn: 'Lobbying',
      nameHr: 'Lobiranje',
      description: 'Izravno utjecanje na donositelje odluka.',
    ),
    ActivismCategory(
      id: 'voting',
      nameEn: 'Voting campaigns',
      nameHr: 'Kampanje za izlazak na izbore',
      description: 'Poticanje sudjelovanja na izborima.',
    ),
    ActivismCategory(
      id: 'running',
      nameEn: 'Running for office',
      nameHr: 'Kandidiranje za političke funkcije',
      description: 'Aktivisti postaju politički kandidati.',
    ),
    ActivismCategory(
      id: 'policy',
      nameEn: 'Policy development',
      nameHr: 'Razvoj javnih politika',
      description: 'Stvaranje alternativnih prijedloga politika.',
    ),
    ActivismCategory(
      id: 'petitions',
      nameEn: 'Petition drives',
      nameHr: 'Prikupljanje potpisa',
      description: 'Prikupljanje potpisa za promjene politika.',
    ),
    ActivismCategory(
      id: 'grassroots',
      nameEn: 'Grassroots organizing',
      nameHr: 'Organiziranje na lokalnoj razini',
      description: 'Izgradnja moći od razine zajednice.',
    ),
    ActivismCategory(
      id: 'coalition',
      nameEn: 'Coalition building',
      nameHr: 'Izgradnja koalicija',
      description: 'Formiranje saveza između organizacija.',
    ),
    ActivismCategory(
      id: 'mutual_aid',
      nameEn: 'Mutual aid networks',
      nameHr: 'Mreže uzajamne pomoći',
      description: 'Sustavi podrške temeljeni na zajednici.',
    ),
    ActivismCategory(
      id: 'development',
      nameEn: 'Community development',
      nameHr: 'Razvoj zajednice',
      description: 'Poboljšanje lokalne infrastrukture i usluga.',
    ),
    ActivismCategory(
      id: 'litigation',
      nameEn: 'Strategic litigation',
      nameHr: 'Strateška parnica',
      description: 'Korištenje sudova za osporavanje zakona ili politika.',
    ),
    ActivismCategory(
      id: 'legal_aid',
      nameEn: 'Legal aid',
      nameHr: 'Pravna pomoć',
      description: 'Pružanje besplatnih pravnih usluga marginaliziranim skupinama.',
    ),
    ActivismCategory(
      id: 'legal_monitoring',
      nameEn: 'Legal monitoring',
      nameHr: 'Pravno praćenje',
      description: 'Dokumentiranje kršenja prava.',
    ),
    ActivismCategory(
      id: 'legislative_drafting',
      nameEn: 'Legislative drafting',
      nameHr: 'Izrada zakonskih prijedloga',
      description: 'Stvaranje modela zakonodavstva.',
    ),
    ActivismCategory(
      id: 'hacktivism',
      nameEn: 'Hacktivism',
      nameHr: 'Haktivizam',
      description: 'Korištenje tehnoloških vještina za aktivizam.',
    ),
    ActivismCategory(
      id: 'open_data',
      nameEn: 'Open data initiatives',
      nameHr: 'Inicijative otvorenih podataka',
      description: 'Činjenje informacija javno dostupnima.',
    ),
    ActivismCategory(
      id: 'digital_security',
      nameEn: 'Digital security training',
      nameHr: 'Obuka o digitalnoj sigurnosti',
      description: 'Zaštita aktivista na internetu.',
    ),
    ActivismCategory(
      id: 'app_development',
      nameEn: 'App development',
      nameHr: 'Razvoj aplikacija',
      description: 'Stvaranje alata za organiziranje.',
    ),
    ActivismCategory(
      id: 'ethical_consumerism',
      nameEn: 'Ethical consumerism',
      nameHr: 'Etičko potrošačko ponašanje',
      description: 'Podržavanje društveno odgovornih poduzeća.',
    ),
    ActivismCategory(
      id: 'divestment',
      nameEn: 'Divestment campaigns',
      nameHr: 'Kampanje povlačenja ulaganja',
      description: 'Pritisak na institucije da povuku ulaganja.',
    ),
    ActivismCategory(
      id: 'cooperative',
      nameEn: 'Cooperative development',
      nameHr: 'Razvoj zadruga',
      description: 'Stvaranje alternativnih ekonomskih modela.',
    ),
    ActivismCategory(
      id: 'impact_investing',
      nameEn: 'Impact investing',
      nameHr: 'Ulaganje s društvenim učinkom',
      description: 'Financiranje društveno korisnih pothvata.',
    ),
    ActivismCategory(
      id: 'protest_art',
      nameEn: 'Protest art and music',
      nameHr: 'Protestna umjetnost i glazba',
      description: 'Kreativno izražavanje političkih poruka.',
    ),
    ActivismCategory(
      id: 'guerrilla_theater',
      nameEn: 'Guerrilla theater',
      nameHr: 'Gerilsko kazalište',
      description: 'Neočekivane javne izvedbe.',
    ),
    ActivismCategory(
      id: 'documentary',
      nameEn: 'Documentary filmmaking',
      nameHr: 'Dokumentarni film',
      description: 'Bilježenje društvenih pitanja.',
    ),
    ActivismCategory(
      id: 'cultural_preservation',
      nameEn: 'Cultural preservation',
      nameHr: 'Očuvanje kulture',
      description: 'Zaštita baštine i tradicija.',
    ),
    ActivismCategory(
      id: 'alternative_education',
      nameEn: 'Alternative education',
      nameHr: 'Alternativno obrazovanje',
      description: 'Stvaranje obrazovnih modela izvan tradicionalnog sustava.',
    ),
    ActivismCategory(
      id: 'popular_education',
      nameEn: 'Popular education',
      nameHr: 'Narodno obrazovanje',
      description: 'Obrazovne metode koje potiču kritičko razmišljanje i društvenu svijest.',
    ),
    ActivismCategory(
      id: 'skill_sharing',
      nameEn: 'Skill sharing',
      nameHr: 'Dijeljenje vještina',
      description: 'Razmjena znanja i vještina unutar zajednice.',
    ),
    ActivismCategory(
      id: 'curriculum_reform',
      nameEn: 'Curriculum reform',
      nameHr: 'Reforma kurikuluma',
      description: 'Zagovaranje promjena u službenim obrazovnim programima.',
    ),
    ActivismCategory(
      id: 'conservation',
      nameEn: 'Conservation efforts',
      nameHr: 'Napori očuvanja',
      description: 'Zaštita prirodnih staništa i vrsta.',
    ),
    ActivismCategory(
      id: 'climate_action',
      nameEn: 'Climate action',
      nameHr: 'Klimatsko djelovanje',
      description: 'Borba protiv klimatskih promjena i zagovaranje održivih politika.',
    ),
    ActivismCategory(
      id: 'sustainable_living',
      nameEn: 'Sustainable living',
      nameHr: 'Održivi način života',
      description: 'Promicanje ekološki prihvatljivih životnih stilova.',
    ),
    ActivismCategory(
      id: 'pollution_prevention',
      nameEn: 'Pollution prevention',
      nameHr: 'Sprječavanje zagađenja',
      description: 'Borba protiv onečišćenja zraka, vode i tla.',
    ),
    ActivismCategory(
      id: 'environmental_justice',
      nameEn: 'Environmental justice',
      nameHr: 'Ekološka pravda',
      description: 'Borba protiv nerazmjernog utjecaja ekoloških problema na marginalizirane zajednice.',
    ),
    ActivismCategory(
      id: 'healthcare_access',
      nameEn: 'Healthcare access',
      nameHr: 'Pristup zdravstvenoj skrbi',
      description: 'Borba za univerzalni pristup zdravstvenim uslugama.',
    ),
    ActivismCategory(
      id: 'patient_advocacy',
      nameEn: 'Patient advocacy',
      nameHr: 'Zagovaranje prava pacijenata',
      description: 'Zastupanje interesa pacijenata u zdravstvenom sustavu.',
    ),
    ActivismCategory(
      id: 'mental_health',
      nameEn: 'Mental health awareness',
      nameHr: 'Podizanje svijesti o mentalnom zdravlju',
      description: 'Borba protiv stigme i zagovaranje bolje skrbi za mentalno zdravlje.',
    ),
    ActivismCategory(
      id: 'public_health',
      nameEn: 'Public health campaigns',
      nameHr: 'Kampanje javnog zdravstva',
      description: 'Promicanje preventivnih zdravstvenih mjera i edukacije.',
    ),
    ActivismCategory(
      id: 'union_organizing',
      nameEn: 'Union organizing',
      nameHr: 'Sindikalno organiziranje',
      description: 'Formiranje i jačanje radničkih sindikata.',
    ),
    ActivismCategory(
      id: 'fair_wages',
      nameEn: 'Fair wage campaigns',
      nameHr: 'Kampanje za pravedne plaće',
      description: 'Zagovaranje za dostojanstvene plaće i jednakost plaća.',
    ),
    ActivismCategory(
      id: 'workplace_safety',
      nameEn: 'Workplace safety',
      nameHr: 'Sigurnost na radnom mjestu',
      description: 'Borba za sigurne i zdrave radne uvjete.',
    ),
    ActivismCategory(
      id: 'anti_exploitation',
      nameEn: 'Anti-exploitation efforts',
      nameHr: 'Borba protiv izrabljivanja',
      description: 'Suprotstavljanje prisilnom radu i izrabljivačkim praksama.',
    ),
    ActivismCategory(
      id: 'civil_liberties',
      nameEn: 'Civil liberties defense',
      nameHr: 'Obrana građanskih sloboda',
      description: 'Zaštita osnovnih prava i sloboda od državnog zadiranja.',
    ),
    ActivismCategory(
      id: 'minority_rights',
      nameEn: 'Minority rights',
      nameHr: 'Prava manjina',
      description: 'Zagovaranje za prava etničkih, vjerskih i drugih manjina.',
    ),
    ActivismCategory(
      id: 'refugee_rights',
      nameEn: 'Refugee and migrant rights',
      nameHr: 'Prava izbjeglica i migranata',
      description: 'Zaštita prava raseljenih osoba i migranata.',
    ),
    ActivismCategory(
      id: 'anti_torture',
      nameEn: 'Anti-torture campaigns',
      nameHr: 'Kampanje protiv mučenja',
      description: 'Borba protiv mučenja i okrutnog postupanja.',
    ),
  ];
}
