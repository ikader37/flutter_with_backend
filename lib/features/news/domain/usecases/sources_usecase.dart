import 'package:app_test_with_backend/features/news/domain/entities/ArticleEntity.dart';
import 'package:app_test_with_backend/features/news/domain/entities/SourceEntity.dart';
import 'package:app_test_with_backend/features/news/domain/repositories/ArticleRepository.dart';

abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}
class SearchParamsS {
  final String country;
  final int page;
  const SearchParamsS({ required this.country,required this.page});
}

class SourcesUsecase implements UseCase<List<SourceEntity>, SearchParamsS> {
  final ArticleRepository _repository;

  SourcesUsecase(this._repository);

  @override
  Future<List<SourceEntity>> call(SearchParamsS params) {
    return _repository.findSources(params.country, params.page);
  }


}
