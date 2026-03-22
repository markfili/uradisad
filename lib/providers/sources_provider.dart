import 'dart:convert';

import 'package:aktivizam/config.dart';
import 'package:aktivizam/data/activism_api.dart';
import 'package:aktivizam/data/activism_source.dart';
import 'package:aktivizam/data/activitsm_categories.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(baseUrl: kGithubRawBase));
});

final activismApiProvider = Provider<ActivismApi>((ref) {
  return ActivismApi(ref.watch(dioProvider));
});

final categoriesProvider = FutureProvider<List<ActivismCategory>>((ref) async {
  try {
    return await ref.watch(activismApiProvider).getCategories();
  } catch (_) {
    final raw = await rootBundle.loadString('assets/categories.json');
    return (jsonDecode(raw) as List)
        .map((e) => ActivismCategory.fromJson(e as Map<String, dynamic>))
        .toList();
  }
});

final sourcesProvider = FutureProvider<List<ActivismSource>>((ref) async {
  final categories = await ref.watch(categoriesProvider.future);
  ActivismCategories.setCategories(categories);

  try {
    return await ref.watch(activismApiProvider).getSources();
  } catch (_) {
    final raw = await rootBundle.loadString('assets/sources.json');
    return (jsonDecode(raw) as List)
        .map((e) => ActivismSource.fromJson(e as Map<String, dynamic>))
        .toList();
  }
});
