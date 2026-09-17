import 'dart:developer';

import 'package:app_test_with_backend/core/errors/network_exception.dart';
import 'package:app_test_with_backend/features/news/data/datasource/interfaces/local_article_data_source.dart';
import 'package:app_test_with_backend/features/news/data/datasource/interfaces/remote_article_data_source.dart';
import 'package:app_test_with_backend/features/news/data/models/ArticleLocalModel.dart';
import 'package:app_test_with_backend/features/news/data/models/SourceLocalModel.dart';
import 'package:app_test_with_backend/features/news/domain/entities/ArticleEntity.dart';
import 'package:app_test_with_backend/features/news/domain/entities/SourceEntity.dart';
import 'package:dio/dio.dart';

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
     print("AFTER REMOTE");
     await localArticleDataSource.createSources(result.map((element)=>SourceLocalModel(id: element.id, name: element.name)).toList());
     return result.map((element)=>element.toEntity()).toList();
  }
    on DioException catch (e) {
      print("EXCEPTION SOURCE ${e.toString()}");
      final cachedSources =
      await localArticleDataSource.findSources();

      if (cachedSources.isNotEmpty) {
        return cachedSources
            .map((source) => source.toEntity())
            .toList();
      }
      throw NetworkException(_getNetworkErrorMessage(e));
    }catch(e){
      print("EXCEPTION SOURCE2  ${e.toString()}");
      final cachedSources =
      await localArticleDataSource.findSources();

      if (cachedSources.isNotEmpty) {
        return cachedSources
            .map((source) => source.toEntity())
            .toList();
      }
      throw NetworkException(e.toString());
    }
}

  @override
  Future<List<ArticleEntity>> findAll(String search, String country, int page) async {
   try{
     print("ALLLL:::");
     final result=await _remoteArticleDataSource.findAll(search, country, page);
     print("ALLL @");
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
   } on DioException catch (e){
     final cachedArticles=await localArticleDataSource.findAll(search, country, page);
     if(cachedArticles.isNotEmpty){
       return cachedArticles.map((element)=>element.toEntity()).toList();
     }
     throw NetworkException(_getNetworkErrorMessage(e));
   }catch(e){
     throw NetworkException("Une erreur est survenue");
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
    }on DioException catch (e){
      final cachedArticle =await localArticleDataSource.findTopHeadlines(search, country, page);
      if(cachedArticle.isNotEmpty){
        return cachedArticle.map((element)=>element.toEntity()).toList();
      }
      throw NetworkException(_getNetworkErrorMessage(e));
    }
    catch(e){
      throw NetworkException("Une erreur est survenue");
    }
  }

  String _getNetworkErrorMessage(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'La connexion a pris trop de temps.';

      case DioExceptionType.receiveTimeout:
        return 'Le serveur met trop de temps à répondre.';

      case DioExceptionType.connectionError:
        return 'Impossible de se connecter à Internet.';

      case DioExceptionType.badResponse:
        return 'Le serveur a rencontré un problème.';

      default:
        return 'Une erreur réseau est survenue.';
    }
  }
}
