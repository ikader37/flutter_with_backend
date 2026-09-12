import 'package:app_test_with_backend/features/news/domain/entities/SourceEntity.dart';

class ArticleEntity {
  final SourceEntity source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;


  const ArticleEntity({required this.source, required this.author, required this.title, required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content});


}
