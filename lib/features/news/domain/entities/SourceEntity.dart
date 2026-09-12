
import 'package:app_test_with_backend/features/news/data/models/SourceModel.dart';

class SourceEntity {
  final String id;
  final String name;

  const SourceEntity({required this.id, required this.name});

  SourceModel copyWith({String? id, String? name}) {
    return SourceModel(id: id??this.id, name: name??this.name);
  }
}
