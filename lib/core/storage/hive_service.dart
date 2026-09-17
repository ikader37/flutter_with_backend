import 'package:app_test_with_backend/features/news/data/models/ArticleLocalModel.dart';
import 'package:app_test_with_backend/features/news/data/models/SourceLocalModel.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class HiveService {
  static const String headlinesBox = 'headlines';
  static const String allBox = 'all';
  static const String sourcesBox = 'sources';


  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ArticleLocalModelAdapter());
    Hive.registerAdapter(SourceLocalModelAdapter());

    await Hive.openBox<ArticleLocalModel>(headlinesBox);
    await Hive.openBox<ArticleLocalModel>(allBox);
    await Hive.openBox<SourceLocalModel>(sourcesBox);


  }

  static Box<ArticleLocalModel> get headlines =>
      Hive.box<ArticleLocalModel>(headlinesBox);

  static Box<ArticleLocalModel> get all =>
      Hive.box<ArticleLocalModel>(allBox);
  static Box<SourceLocalModel> get sources =>
      Hive.box<SourceLocalModel>(sourcesBox);
}