import 'dart:developer';

import 'package:app_test_with_backend/features/news/data/datasource/interfaces/local_article_data_source.dart';
import 'package:app_test_with_backend/features/news/data/datasource/interfaces/remote_article_data_source.dart';
import 'package:app_test_with_backend/features/news/data/models/ArticleLocalModel.dart';
import 'package:app_test_with_backend/features/news/data/models/SourceLocalModel.dart';
import 'package:app_test_with_backend/features/news/domain/entities/ArticleEntity.dart';
import 'package:app_test_with_backend/features/news/domain/entities/SourceEntity.dart';

import '../../domain/repositories/ArticleRepository.dart';

class Articlerepositoryimpl implements ArticleRepository {
  final RemoteArticleDataSource _remoteArticleDataSource;
  final LocalArticleDataSource localArticleDataSource;

  Articlerepositoryimpl({required this.localArticleDataSource, required this._remoteArticleDataSource});

  @override
  Future<List<SourceEntity>> findSources(String country, int page) async{
    try{
      print("DEBUT REPOSITORY");
     final result=await _remoteArticleDataSource.findSources(country, page);
     await localArticleDataSource.createSources(result.cast<SourceLocalModel>());
     return result.map((element)=>element.toEntity()).toList();
  }catch(e){
      final cachedSources =
      await localArticleDataSource.findSources();

      if (cachedSources.isNotEmpty) {
        return cachedSources
            .map((source) => source.toEntity())
            .toList();
      }

      rethrow;
    }
}

  @override
  Future<List<ArticleEntity>> findAll(String search, String country, int page) async {
   try{
     final result=await _remoteArticleDataSource.findAll(search, country, page);
     await localArticleDataSource.createAll(
       result.map(
             (article) => ArticleLocalModel(
           title: article.title,
           description: article.description,
           url: article.url,
           urlToImage: article.urlToImage,
           publishedAt: article.publishedAt,
           content: article.content, source: SourceLocalModel.fromJson(article.source.toJson()),
           author: article.author,
         ),
       ).toList(),
     );
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
      await localArticleDataSource.createAll(
        result.map(
              (article) => ArticleLocalModel(
            title: article.title,
            description: article.description,
            url: article.url,
            urlToImage: article.urlToImage,
            publishedAt: article.publishedAt,
            content: article.content, source: SourceLocalModel.fromJson(article.source.toJson()),
                author: article.author,
          ),
        ).toList(),
      );
      return result.map((element)=>element.toEntity()).toList();
    }catch(e){
      final cachedArticle =await localArticleDataSource.findTopHeadlines(search, country, page);
      if(cachedArticle.isNotEmpty){
        return cachedArticle.map((element)=>element.toEntity()).toList();
      }
      rethrow;
    }
  }
}
