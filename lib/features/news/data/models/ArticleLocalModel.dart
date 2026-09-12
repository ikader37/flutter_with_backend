
import 'package:app_test_with_backend/features/news/data/models/ArticleModel.dart';
import 'package:app_test_with_backend/features/news/data/models/SourceLocalModel.dart';
import 'package:app_test_with_backend/features/news/domain/entities/ArticleEntity.dart';
import 'package:hive_ce/hive.dart';

part 'ArticleLocalModel.g.dart';



@HiveType(typeId: 0)
class ArticleLocalModel extends HiveObject{
  @HiveField(1)
  final SourceLocalModel source;
  @HiveField(2)
  final String author;
  @HiveField(0)
  final String title;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final String url;
  @HiveField(5)
  final String urlToImage;
  @HiveField(6)
  final String publishedAt;
  @HiveField(7)
  final String content;
  //
  // ArticleLocalModel({
  //   required source,
  //   required author, required title,
  //   required description, required url, required urlToImage,
  //   required publishedAt,
  //   required content
  // });


  ArticleLocalModel({required this.source, required this.author, required
  this.title, required this.description,
    required this.url, required this.urlToImage,required this.publishedAt,
    required this.content});


  factory ArticleLocalModel.fromJson(Map<String,dynamic> json){
    return ArticleLocalModel(source: SourceLocalModel.fromJson(json['source']),
        author: json['author']?? '', title: json['title']?? '',
        description: json['description']?? '', url: json['url']?? '',
        urlToImage: json['urlToImage']?? '', publishedAt: json['publishedAt']?? '',
        content: json['content']?? '');
  }

  ArticleEntity toEntity()=>
      ArticleEntity(author: author,title: title,description: description,
          source: source.toEntity(),urlToImage: urlToImage,url: url,
          publishedAt: publishedAt,content: content);

  ArticleModel toModel()=>ArticleModel(source: source.toModel(),
      author: author, title: title,
      description: description,
      url: url, urlToImage: urlToImage,
      publishedAt: publishedAt,
      content: content);

  Map<String,dynamic> toJson()=>{
    "author":author,
    "title":title,
    "description":description,
    "urlToImage": urlToImage,
    "url": url,
    "publishedAt": publishedAt,
    "content": content,
    "source": source.toJson()
  };
}
