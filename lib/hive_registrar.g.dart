import 'package:hive_ce/hive.dart';
import 'package:app_test_with_backend/features/news/data/models/ArticleLocalModel.dart';
import 'package:app_test_with_backend/features/news/data/models/SourceLocalModel.dart';

extension HiveRegistrar on HiveInterface {
  void registerAdapters() {
    registerAdapter(ArticleLocalModelAdapter());
    registerAdapter(SourceLocalModelAdapter());
  }
}
