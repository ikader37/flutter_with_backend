import 'package:app_test_with_backend/features/news/data/datasource/interfaces/local_article_data_source.dart';
import 'package:app_test_with_backend/features/news/data/datasource/interfaces/remote_article_data_source.dart';
import 'package:app_test_with_backend/features/news/data/models/ArticleLocalModel.dart';
import 'package:app_test_with_backend/features/news/data/models/SourceLocalModel.dart';
import 'package:app_test_with_backend/features/news/data/repositories/ArticleRepositoryImpl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'remote_articles_test.mocks.dart';

@GenerateMocks([
  RemoteArticleDataSource,
  LocalArticleDataSource,
])
void main() {
  late MockRemoteArticleDataSource remoteDataSource;
  late MockLocalArticleDataSource localArticleDataSource;
  late Articlerepositoryimpl repository;

  setUp(() {
    remoteDataSource = MockRemoteArticleDataSource();
    localArticleDataSource = MockLocalArticleDataSource();

    repository = Articlerepositoryimpl(
      localArticleDataSource: localArticleDataSource,
      remoteArticleDataSource: remoteDataSource,
    );
  });

  group('Articlerepositoryimpl - findAll', () {
    test(
      'should return an empty list when the datasource returns no articles',
          () async {
        // Arrange
        when(
          remoteDataSource.findAll('flutter', 'us', 1),
        ).thenAnswer((_) async => []);

        when(
          localArticleDataSource.createAll(any),
        ).thenAnswer((_) async {});

        // Act
        final result = await repository.findAll(
          'flutter',
          'us',
          1,
        );

        // Assert
        expect(result, isEmpty);

        verify(
          remoteDataSource.findAll('flutter', 'us', 1),
        ).called(1);
      },
    );

    test(
      'should propagate the exception when the datasource fails and no cache exists',
          () async {
        // Arrange
        when(
          remoteDataSource.findAll('flutter', 'us', 1),
        ).thenThrow(
          Exception('API error'),
        );

        when(
          localArticleDataSource.findAll('flutter', 'us', 1),
        ).thenAnswer(
              (_) async => [],
        );

        // Act + Assert
        expect(
              () => repository.findAll('flutter', 'us', 1),
          throwsException,
        );

        verify(
          remoteDataSource.findAll('flutter', 'us', 1),
        ).called(1);

        verify(
          localArticleDataSource.findAll('flutter', 'us', 1),
        ).called(1);
      },
    );

    test(
      'should return cached articles when network fails',
          () async {
        // Arrange
        final cachedArticle = ArticleLocalModel(
          title: 'Article en cache',
          description: 'Article disponible hors ligne',
          url: 'https://example.com/article',
          source: SourceLocalModel(
            id: 'cnn',
            name: 'CNN',
          ),
          author: '',
          urlToImage: '',
          publishedAt: '',
          content: '',
        );

        when(
          remoteDataSource.findAll('flutter', 'us', 0),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(
              path: '/everything',
            ),
            type: DioExceptionType.connectionError,
          ),
        );

        when(
          localArticleDataSource.findAll('flutter', 'us', 0),
        ).thenAnswer(
              (_) async => [cachedArticle],
        );

        // Act
        final result = await repository.findAll(
          'flutter',
          'us',
          0,
        );

        // Assert
        expect(result, isNotEmpty);
        expect(result.length, 1);
        expect(result.first.title, 'Article en cache');

        verify(
          remoteDataSource.findAll('flutter', 'us', 0),
        ).called(1);

        verify(
          localArticleDataSource.findAll('flutter', 'us', 0),
        ).called(1);
      },
    );
  });

  group('Articlerepositoryimpl - findTopHeadlines', () {
    test(
      'should return an empty list when the datasource returns no headlines',
          () async {
        // Arrange
        when(
          remoteDataSource.findTopHeadlines('', 'us', 0),
        ).thenAnswer((_) async => []);

        when(
          localArticleDataSource.createAll(any),
        ).thenAnswer((_) async {});

        // Act
        final result = await repository.findTopHeadlines(
          '',
          'us',
          0,
        );

        // Assert
        expect(result, isEmpty);

        verify(
          remoteDataSource.findTopHeadlines('', 'us', 0),
        ).called(1);
      },
    );
  });
}