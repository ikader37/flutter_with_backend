
import 'package:app_test_with_backend/features/news/data/models/SourceModel.dart';
import 'package:app_test_with_backend/features/news/domain/entities/ArticleEntity.dart';
class ArticleModel{
  final SourceModel source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;
   const ArticleModel({
    required this.source,
    required this.author, required this.title,
    required this.description, required this.url, required this.urlToImage,
    required this.publishedAt,
    required this.content
});
   
   
   factory ArticleModel.fromJson(Map<String,dynamic> json){
     return ArticleModel(source: SourceModel.fromJson(json['source']),
         author: json['author']?? '', title: json['title']?? '',
         description: json['description']?? '', url: json['url']?? '',
         urlToImage: json['urlToImage']?? '', publishedAt: json['publishedAt']?? '',
         content: json['content']?? '');
   }

   ArticleEntity toEntity()=>
      ArticleEntity(author: author,title: title,description: description,
         source: source.toEntity(),urlToImage: urlToImage,url: url,
          publishedAt: publishedAt,content: content);
}