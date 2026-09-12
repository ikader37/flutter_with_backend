import 'package:app_test_with_backend/features/news/data/repositories/ArticleRepositoryImpl.dart';
import 'package:app_test_with_backend/features/news/domain/entities/ArticleEntity.dart';
import 'package:app_test_with_backend/features/news/domain/repositories/ArticleRepository.dart';

abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}
class SearchParamsTop {
  final String search;
  final String country;
  final int page;
  const SearchParamsTop({required this.search, required this.country, required this.page});
}

class TopHeadLinesUseCase implements UseCase<List<ArticleEntity>, SearchParamsTop> {
  final Articlerepositoryimpl _repository;

  TopHeadLinesUseCase(this._repository);

  @override
  Future<List<ArticleEntity>> call(SearchParamsTop params) async{
    // TODO: implement call
    print("DEBUT USE CASE");
    final result=await _repository.findTopHeadlines(params.search, params.country, params.page);
    print("TAILLE:${result.length}");
    return  result;
  }

}
