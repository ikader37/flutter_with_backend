import 'dart:developer';

import 'package:app_test_with_backend/features/news/data/datasource/interfaces/remote_article_data_source.dart';
import 'package:app_test_with_backend/features/news/domain/entities/ArticleEntity.dart';
import 'package:app_test_with_backend/features/news/domain/entities/SourceEntity.dart';

import '../../domain/repositories/ArticleRepository.dart';

class Articlerepositoryimpl implements ArticleRepository {
  final RemoteArticleDataSource _remoteArticleDataSource;

  Articlerepositoryimpl({required RemoteArticleDataSource remoteArticleDataSource}):_remoteArticleDataSource=remoteArticleDataSource;

  @override
  Future<List<SourceEntity>> findSources(String country, int page) async{
    try{
      print("DEBUT REPOSITORY");
     final result=await _remoteArticleDataSource.findSources(country, page);
     return result.map((element)=>element.toEntity()).toList();
  }catch(e){
      rethrow;
    }
}

  @override
  Future<List<ArticleEntity>> findAll(String search, String country, int page) async {
   try{
     final result=await _remoteArticleDataSource.findAll(search, country, page);
     return result.map((element)=>element.toEntity()).toList();
   }catch(e){
     rethrow;
   }
  }

  @override
  Future<List<ArticleEntity>> findTopHeadlines(
    String search,
    String country,
    int page,
  ) async {
    try{
      print("DEBUT REPOSITORY TOP");
      final result=await _remoteArticleDataSource.findTopHeadlines(search, country, page);
      print("RESPONSE:::${result.length}");
      return result.map((element)=>element.toEntity()).toList();
    }catch(e){
      rethrow;
    }
  }
}
