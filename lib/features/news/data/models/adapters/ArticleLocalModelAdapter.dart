import 'package:app_test_with_backend/features/news/data/models/ArticleLocalModel.dart';
import 'package:hive_ce/hive.dart';

class ArticleLocalModelAdapter extends TypeAdapter<ArticleLocalModel> {
  @override
  ArticleLocalModel read(BinaryReader reader) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  // TODO: implement typeId
  int get typeId => throw UnimplementedError();

  @override
  void write(BinaryWriter writer, ArticleLocalModel obj) {
    // TODO: implement write
  }
}