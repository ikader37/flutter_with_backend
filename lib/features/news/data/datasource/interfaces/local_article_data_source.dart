import 'package:app_test_with_backend/features/news/data/models/ArticleLocalModel.dart';
import 'package:app_test_with_backend/features/news/data/models/SourceLocalModel.dart';

abstract class LocalArticleDataSource {
  Future<List<ArticleLocalModel>> findTopHeadlines(String search,String country,int page);
  Future<List<ArticleLocalModel>> findAll(String search,String country,int page);
  Future<void> clearArticles();
  Future<void> createAll(List<ArticleLocalModel> articles);
  Future<void> createSources(List<SourceLocalModel> sources);




}