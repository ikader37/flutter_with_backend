part of 'news_bloc.dart';

sealed class NewsEvent extends Equatable {
  const NewsEvent();
  @override
  List<Object?> get props => [];
}

class TopHeadlinesEvent extends NewsEvent{
  final String search;
  final String country;
  final int page;
  const TopHeadlinesEvent({required this.search,required this.country,required this.page});
}

class AllNewsEvent extends NewsEvent{
  final String search;
  final String country;
  final int page;
  const AllNewsEvent({required this.search,required this.country,required this.page});

}
class SourcesEvent extends NewsEvent{
  final String country;
  final int page;
  const SourcesEvent({required this.country,required this.page});

}
