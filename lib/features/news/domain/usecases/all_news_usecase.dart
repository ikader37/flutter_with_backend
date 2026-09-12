import 'package:app_test_with_backend/features/news/domain/entities/ArticleEntity.dart';
import 'package:app_test_with_backend/features/news/domain/repositories/ArticleRepository.dart';

abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}
class SearchParamsAl {
  final String search;
  final String country;
  final int page;
  const SearchParamsAl({required this.search, required this.country, required this.page});
}

class AllNewsUsecase implements UseCase<List<ArticleEntity>, SearchParamsAl> {
  final ArticleRepository _repository;

  const AllNewsUsecase(this._repository);
  @override
  Future<List<ArticleEntity>> call(SearchParamsAl params) {
    return _repository.findAll(params.search, params.country, params.page);
  }


}