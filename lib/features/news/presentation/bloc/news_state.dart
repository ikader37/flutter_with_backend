part of 'news_bloc.dart';

sealed class NewsState extends Equatable {
  const NewsState();
}

final class NewsInitialState extends NewsState {
  @override
  List<Object> get props => [];
}
class NewsLoadingState extends NewsState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class LoadedTopHeadLinesState extends NewsState{
  final List<ArticleEntity> articles;

  LoadedTopHeadLinesState(this.articles);

  @override
  // TODO: implement props
  List<Object?> get props => [articles];
}

class LoadedSourcesState extends NewsState{
  final List<SourceEntity> sources;

  LoadedSourcesState(this.sources);

  @override
  // TODO: implement props
  List<Object?> get props => [sources];
}
class LoadedNewsState extends NewsState{
  final List<ArticleEntity> articles;

  LoadedNewsState(this.articles);

  @override
  // TODO: implement props
  List<Object?> get props => [articles];
}
class ArticlesErrorState extends NewsState{
  final String _errorMessage;

  ArticlesErrorState(this._errorMessage);

  @override
  // TODO: implement props
  List<Object?> get props => [_errorMessage];
}