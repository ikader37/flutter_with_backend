import 'package:app_test_with_backend/features/news/domain/entities/ArticleEntity.dart';
import 'package:app_test_with_backend/features/news/domain/entities/SourceEntity.dart';
import 'package:app_test_with_backend/features/news/domain/usecases/all_news_usecase.dart';
import 'package:app_test_with_backend/features/news/domain/usecases/sources_usecase.dart';
import 'package:app_test_with_backend/features/news/domain/usecases/top_head_lines_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {

  final AllNewsUsecase _allNewsUsecase;
  final SourcesUsecase _sourcesUsecase;
  final TopHeadLinesUseCase _topHeadLinesUseCase;

  NewsBloc(this._allNewsUsecase, this._sourcesUsecase,
      this._topHeadLinesUseCase) : super(NewsInitialState()) {
    on<TopHeadlinesEvent>(onLoadTopHeadLines);
    on<AllNewsEvent>(onLoadAllNews);
    on<SourcesEvent>(onLoadSources);
  }


    Future<void> onLoadTopHeadLines(TopHeadlinesEvent topHeadlinesEvent,
        Emitter<NewsState> emit) async {
    print("EMIT LOADING");
      emit(NewsLoadingState());
      try {
        print("BLOC: TOP HEADING");
        final articles = await _topHeadLinesUseCase.call(SearchParamsTop(
            search: topHeadlinesEvent.search,
            country: topHeadlinesEvent.country,
            page: topHeadlinesEvent.page));
        print("BLOC: TOP HEADING");
        print("LENGTH::");

        emit(LoadedTopHeadLinesState(articles));
      } catch (e) {

        emit(ArticlesErrorState(e.toString()));
      }
    }


  Future<void> onLoadAllNews(AllNewsEvent allNewsEvent,
      Emitter<NewsState> emit) async {
    emit(NewsLoadingState());
    try {
      final articles = await _allNewsUsecase.call(SearchParamsAl(
          search: allNewsEvent.search,
          country: allNewsEvent.country,
          page: allNewsEvent.page));
      emit(LoadedNewsState(articles));
    } catch (e) {
      emit(ArticlesErrorState(e.toString()));
    }
  }

  Future<void> onLoadSources(SourcesEvent sourcesEvent,
      Emitter<NewsState> emit) async {
    emit(NewsLoadingState());
    try {
      final sources = await _sourcesUsecase.call(SearchParamsS(
          country: sourcesEvent.country, page: sourcesEvent.page));
      emit(LoadedSourcesState(sources));
    } catch (e) {
      emit(ArticlesErrorState(e.toString()));
    }
  }
}
