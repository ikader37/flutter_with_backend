import 'package:app_test_with_backend/features/news/data/datasource/interfaces/remote_article_data_source.dart';
import 'package:app_test_with_backend/features/news/data/repositories/ArticleRepositoryImpl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'remote_articles_test.mocks.dart';


@GenerateMocks([
  RemoteArticleDataSource,
])
void main() {
  late MockRemoteArticleDataSource remoteDataSource;
  late Articlerepositoryimpl repository;

  setUp(() {
    remoteDataSource = MockRemoteArticleDataSource();

    repository = Articlerepositoryimpl(
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

        // Act
        final result = await repository.findAll('flutter', 'us', 1);

        // Assert
        expect(result, isEmpty);

        verify(
          remoteDataSource.findAll('flutter', 'us', 1),
        ).called(1);
      },
    );

    test(
      'should propagate the exception when the datasource fails',
          () async {
        // Arrange
        when(
          remoteDataSource.findAll('flutter', 'us', 1),
        ).thenThrow(Exception('API error'));

        // Act + Assert
        expect(
              () => repository.findAll('flutter', 'us', 1),
          throwsException,
        );

        verify(
          remoteDataSource.findAll('flutter', 'us', 1),
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

        // Act
        final result = await repository.findTopHeadlines('', 'us', 0);

        // Assert
        expect(result, isEmpty);

        verify(
          remoteDataSource.findTopHeadlines('', 'us', 0),
        ).called(1);
      },
    );
  });
}