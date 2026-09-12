
import 'package:app_test_with_backend/features/news/data/models/ArticleModel.dart';
import 'package:app_test_with_backend/features/news/data/models/SourceModel.dart';

abstract class RemoteArticleDataSource{

  Future<List<ArticleModel>> findTopHeadlines(String search,String country,int page);
  Future<List<ArticleModel>> findAll(String search,String country,int page);
  Future<List<SourceModel>> findSources(String country,int page);
}