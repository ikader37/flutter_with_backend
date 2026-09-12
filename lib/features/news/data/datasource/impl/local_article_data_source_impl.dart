import 'package:app_test_with_backend/features/news/data/models/ArticleLocalModel.dart';

import 'package:app_test_with_backend/features/news/data/models/SourceLocalModel.dart';
import 'package:hive_ce/hive.dart';

import '../interfaces/local_article_data_source.dart';

class LocalArticleDataSourceImpl<T> implements LocalArticleDataSource{
  final Box<ArticleLocalModel> articlesBox;
  final Box<SourceLocalModel> sourcesBox;
  final Box<ArticleLocalModel> headlinesBox;


  LocalArticleDataSourceImpl({required this.articlesBox,
      required this.sourcesBox,required this.headlinesBox}
      );

  @override
  Future<void> clearArticles() async{
    await  articlesBox.clear();
    await  sourcesBox.clear();

  }

  @override
  Future<List<ArticleLocalModel>> findAll(String search, String country, int page) async {
    final articles = articlesBox.values.toList();

    return _filterArticles(
      articles,
      search: search,
      page: page,
    );
  }

  @override
  Future<List<ArticleLocalModel>> findTopHeadlines(String search, String country, int page) async{
    final articles = articlesBox.values.toList();

    return _filterArticles(
      articles,
      search: search,
      page: page,
    );
  }

  @override
  Future<void> createAll(List<ArticleLocalModel> articles)async {
    final data = <String, ArticleLocalModel>{
      for (final article in articles)
        article.title: article,
    };
    await articlesBox.putAll(data);
  }

  @override
  Future<void> createSources(List<SourceLocalModel> sources) async{
    final data = <String, SourceLocalModel>{
      for (final source in sources)
        source.id: source,
    };

    await sourcesBox.putAll(data);
  }

  List<ArticleLocalModel> _filterArticles(
      List<ArticleLocalModel> articles, {
        required String search,
        required int page,
      }) {
    var result = articles;

    // Recherche
    if (search.trim().isNotEmpty) {
      final query = search.toLowerCase().trim();

      result = result.where((article) {
        return article.title.toLowerCase().contains(query);
      }).toList();
    }

    // Pagination
    const pageSize = 20;

    final start = (page - 1) * pageSize;

    if (start >= result.length) {
      return [];
    }

    final end = (start + pageSize).clamp(0, result.length);

    return result.sublist(start, end);

}

}