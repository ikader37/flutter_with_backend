
import 'package:app_test_with_backend/features/news/domain/entities/ArticleEntity.dart';
import 'package:app_test_with_backend/features/news/domain/entities/SourceEntity.dart';

abstract class ArticleRepository {
  Future<List<ArticleEntity>> findTopHeadlines(String search,String country,int page);
  Future<List<ArticleEntity>> findAll(String search,String country,int page);
  Future<List<SourceEntity>> findSources(String country,int page);


}