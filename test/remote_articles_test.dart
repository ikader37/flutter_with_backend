import 'package:app_test_with_backend/features/news/data/datasource/interfaces/remote_article_data_source.dart';
import 'package:app_test_with_backend/features/news/data/repositories/Articlerepositoryimpl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'remote_articles_test.mocks.dart';

@GenerateMocks([
  RemoteArticleDataSource,
])
void main() {
  late MockRemoteArticleDataSource remoteArticleDataSource;
  late Articlerepositoryimpl repository;

  setUp(() {
    remoteArticleDataSource = MockRemoteArticleDataSource();

    repository = Articlerepositoryimpl(
      remoteArticleDataSource: remoteArticleDataSource,
    );
  });

  group('Articlerepositoryimpl', () {

    // ============================================================
    // FIND ALL
    // ============================================================

    group('findAll', () {

      test(
        'should return ArticleEntity list when datasource succeeds',
            () async {
          // Arrange
          when(
            remoteArticleDataSource.findAll(
              'flutter',
              'us',
              1,
            ),
          ).thenAnswer(
                (_) async => [],
          );

          // Act
          final result = await repository.findAll(
            'flutter',
            'us',
            1,
          );

          // Assert
          expect(result, isEmpty);

          verify(
            remoteArticleDataSource.findAll(
              'flutter',
              'us',
              1,
            ),
          ).called(1);
        },
      );

      test(
        'should rethrow exception when datasource fails',
            () async {
          // Arrange
          when(
            remoteArticleDataSource.findAll(
              'flutter',
              'us',
              1,
            ),
          ).thenThrow(
            Exception('Erreur API'),
          );

          // Act + Assert
          expect(
                () => repository.findAll(
              'flutter',
              'us',
              1,
            ),
            throwsException,
          );

          verify(
            remoteArticleDataSource.findAll(
              'flutter',
              'us',
              1,
            ),
          ).called(1);
        },
      );
    });

    // ============================================================
    // TOP HEADLINES
    // ============================================================

    group('findTopHeadlines', () {

      test(
        'should return empty list when datasource returns empty list',
            () async {
          // Arrange
          when(
            remoteArticleDataSource.findTopHeadlines(
              'flutter',
              'us',
              1,
            ),
          ).thenAnswer(
                (_) async => [],
          );

          // Act
          final result = await repository.findTopHeadlines(
            'flutter',
            'us',
            1,
          );

          // Assert
          expect(result, isEmpty);

          verify(
            remoteArticleDataSource.findTopHeadlines(
              'flutter',
              'us',
              1,
            ),
          ).called(1);
        },
      );

      test(
        'should rethrow exception when datasource fails',
            () async {
          // Arrange
          when(
            remoteArticleDataSource.findTopHeadlines(
              'flutter',
              'us',
              1,
            ),
          ).thenThrow(
            Exception('Erreur API'),
          );

          // Act + Assert
          expect(
                () => repository.findTopHeadlines(
              'flutter',
              'us',
              1,
            ),
            throwsException,
          );

          verify(
            remoteArticleDataSource.findTopHeadlines(
              'flutter',
              'us',
              1,
            ),
          ).called(1);
        },
      );
    });

    // ============================================================
    // FIND SOURCES
    // ============================================================

    group('findSources', () {

      test(
        'should return empty SourceEntity list when datasource returns empty list',
            () async {
          // Arrange
          when(
            remoteArticleDataSource.findSources(
              'us',
              1,
            ),
          ).thenAnswer(
                (_) async => [],
          );

          // Act
          final result = await repository.findSources(
            'us',
            1,
          );

          // Assert
          expect(result, isEmpty);

          verify(
            remoteArticleDataSource.findSources(
              'us',
              1,
            ),
          ).called(1);
        },
      );

      test(
        'should rethrow exception when datasource fails',
            () async {
          // Arrange
          when(
            remoteArticleDataSource.findSources(
              'us',
              1,
            ),
          ).thenThrow(
            Exception('Erreur API'),
          );

          // Act + Assert
          expect(
                () => repository.findSources(
              'us',
              1,
            ),
            throwsException,
          );

          verify(
            remoteArticleDataSource.findSources(
              'us',
              1,
            ),
          ).called(1);
        },
      );
    });
  });
}