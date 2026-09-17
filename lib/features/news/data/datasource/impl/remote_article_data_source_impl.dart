
import 'package:app_test_with_backend/core/di/dio_client.dart';
import 'package:app_test_with_backend/core/errors/exceptions.dart';
import 'package:app_test_with_backend/core/errors/network_exception.dart';
import 'package:app_test_with_backend/features/news/data/datasource/impl/local_article_data_source_impl.dart';
import 'package:app_test_with_backend/features/news/data/datasource/interfaces/local_article_data_source.dart';
import 'package:app_test_with_backend/features/news/data/datasource/interfaces/remote_article_data_source.dart';
import 'package:app_test_with_backend/features/news/data/models/ArticleLocalModel.dart';
import 'package:app_test_with_backend/features/news/data/models/ArticleModel.dart';
import 'package:app_test_with_backend/features/news/data/models/SourceModel.dart';


class RemoteArticleDataSourceImpl implements RemoteArticleDataSource{
  final DioClient dio;
  const RemoteArticleDataSourceImpl({required this.dio});
  
  @override
  Future<List<ArticleModel>> findAll(String search, String country, int page) async{
    // TODO: implement findAll
    try {
      final response = await dio.dio.get(
          "/everything?country=${country}&page=${page}&apiKey=437444ccfcf747bdb2f48239558a9f3a");
      print("FIND ALLL:${response.data.length}");
      if (response.statusCode == 200) {
        final result = (response.data as List).map((element) =>
            ArticleModel.fromJson(element)).toList();
        return result;
      }
      else {
        throw handleNetworkException("Erreur d'internet");
      }
    }catch(e){
      throw handleNetworkException(e);
          }

  }

  @override
  Future<List<SourceModel>> findSources(String country, int page) async{
    final response= await dio.dio.get("/sources?country=${country}&page=${page}&apiKey=437444ccfcf747bdb2f48239558a9f3a");
    
    
    if(response.statusCode==200){
      return (response.data as List).map((element)=>SourceModel.fromJson(element)).toList();

    }else{

    }
    throw UnimplementedError();

  }

  @override
  Future<List<ArticleModel>> findTopHeadlines(String search, String country, int page) async{
    // TODO: implement findTopHeadlines
    print("DEBUT REMOTE");

    final response= await dio.dio.get("/top-headlines?country=${country}&page=${page}&apiKey=437444ccfcf747bdb2f48239558a9f3a");
    if(response.statusCode==200){
      // print("DATA 222:::${(response.data['articles'] as List).length}");
      return (response.data['articles'] as List).map((element)=>ArticleModel.fromJson(element)).toList();
    }else{


      throw ServerException("Une erreur est survenue. Vous netes pas connecté ");
    }
  }
  
}