import 'dart:convert';

import 'package:aktivizam/data/activism_source.dart';
import 'package:aktivizam/data/activitsm_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<ActivismSource> sources = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    _prepareData();
  }

  Future<void> _prepareData() async {
    final metadataRaw = await rootBundle.loadString('assets/sources.json');

    sources.addAll((jsonDecode(metadataRaw) as List<dynamic>)
        .map(
          (e) => ActivismSource.fromJson(e),
        )
        .toList());

    setState(() {});
  }

  final List<ActivismCategory> filters = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = MediaQuery.sizeOf(context).width > 1024 ? 4 : 2;
    return Scaffold(
      appBar: AppBar(
        title: const Text('HR AKTIVIZAM'),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Column(
        children: [
          ExpansionTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kategorije',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: filters.map(
                        (e) {
                      return FilterChip(
                        label: Text(e.nameHr),
                        selected: filters.contains(e),
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              filters.add(e);
                            } else {
                              filters.remove(e);
                            }
                          });
                        },
                      );
                    },
                  ).toList(),
                ),
              ],
            ),
            children: [
              Column(
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: ActivismCategories.categories.map(
                      (e) {
                        return FilterChip(
                          label: Text(e.nameHr),
                          selected: filters.contains(e),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                filters.add(e);
                              } else {
                                filters.remove(e);
                              }
                            });
                          },
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(16),
              itemCount: sources.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: 1.0,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                final source = sources[index];
                return Card(
                  elevation: 4,
                  clipBehavior: Clip.antiAlias, // For image overflow
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: InkWell(
                    onTap: () {
                      // Handle tap
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // OG Image if available
                        if (source.image.isNotEmpty)
                          Expanded(
                            flex: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    "./screenshots/${source.image}",
                                  ),
                                ),
                              ),
                            ),
                          )
                        else
                          Expanded(
                            flex: 2,
                            child: Container(
                              color: Theme.of(context).colorScheme.primaryContainer,
                              child: Center(
                                child: Text(
                                  source.title.isNotEmpty ? source.title[0].toUpperCase() : '?',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                                  ),
                                ),
                              ),
                            ),
                          ),

                        // Content section
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Title
                                Text(
                                  source.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),

                                // Description from metadata if available
                                Expanded(
                                  child: Text(
                                    source.description,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Wrap(
                                  spacing: 0.5,
                                  children: source.categories
                                      .map(
                                        (e) => Chip(
                                          label: Text(e.nameHr),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Metadata {
  final String url;
  final String title;
  final String image;
  final String imageOg;
  final String description;

  final List<String> categories;

  Metadata({
    required this.url,
    required this.title,
    required this.image,
    required this.imageOg,
    required this.description,
    this.categories = const [],
  });

  static Metadata fromJson(Map<String, dynamic> json) => Metadata(
        url: json['url'],
        title: json['title'],
        image: json['image'],
        imageOg: json['image_og'],
        description: json['description'],
        categories: json['categories'],
      );

  Map<String, dynamic> toJson() => {
        'url': url,
        'title': title,
        'image': image,
        'image_og': imageOg,
        'description': description,
        'categories': categories,
      };
}
