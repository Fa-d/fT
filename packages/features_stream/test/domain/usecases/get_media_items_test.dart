import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:features_stream/features_stream.dart';
import 'package:core/core.dart';

class MockStreamRepository extends Mock implements StreamRepository {}

void main() {
  late GetMediaItems useCase;
  late MockStreamRepository mockRepository;

  setUp(() {
    mockRepository = MockStreamRepository();
    useCase = GetMediaItems(mockRepository);
  });

  group('GetMediaItems', () {
    final tMediaItems = [
      MediaItem(
        id: '1',
        title: 'Test Video 1',
        description: 'Description 1',
        thumbnailUrl: 'https://example.com/thumb1.jpg',
        duration: const Duration(minutes: 10),
        streamUrl: 'https://example.com/video1.m3u8',
        type: MediaType.video,
        qualityOptions: const {'720p': 'https://example.com/video1.m3u8'},
        publishedAt: DateTime(2024, 1, 1),
        viewCount: 1000,
      ),
      MediaItem(
        id: '2',
        title: 'Test Video 2',
        description: 'Description 2',
        thumbnailUrl: 'https://example.com/thumb2.jpg',
        duration: const Duration(minutes: 15),
        streamUrl: 'https://example.com/video2.m3u8',
        type: MediaType.video,
        qualityOptions: const {'720p': 'https://example.com/video2.m3u8'},
        publishedAt: DateTime(2024, 1, 2),
        viewCount: 2000,
      ),
    ];

    test('should get media items from repository', () async {
      // arrange
      when(() => mockRepository.getMediaItems(
            page: any(named: 'page'),
            limit: any(named: 'limit'),
            type: any(named: 'type'),
          )).thenAnswer((_) async => Right(tMediaItems));

      // act
      final result = await useCase(const GetMediaItemsParams());

      // assert
      expect(result, Right(tMediaItems));
      verify(() => mockRepository.getMediaItems(
            page: 1,
            limit: 20,
            type: null,
          )).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should get media items with custom parameters', () async {
      // arrange
      const tPage = 2;
      const tLimit = 10;
      const tType = MediaType.video;

      when(() => mockRepository.getMediaItems(
            page: any(named: 'page'),
            limit: any(named: 'limit'),
            type: any(named: 'type'),
          )).thenAnswer((_) async => Right(tMediaItems));

      // act
      final result = await useCase(const GetMediaItemsParams(
        page: tPage,
        limit: tLimit,
        type: tType,
      ));

      // assert
      expect(result, Right(tMediaItems));
      verify(() => mockRepository.getMediaItems(
            page: tPage,
            limit: tLimit,
            type: tType,
          )).called(1);
    });

    test('should return ServerFailure when repository fails', () async {
      // arrange
      const tFailure = ServerFailure('Server error');

      when(() => mockRepository.getMediaItems(
            page: any(named: 'page'),
            limit: any(named: 'limit'),
            type: any(named: 'type'),
          )).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await useCase(const GetMediaItemsParams());

      // assert
      expect(result, const Left(tFailure));
      verify(() => mockRepository.getMediaItems(
            page: 1,
            limit: 20,
            type: null,
          )).called(1);
    });

    test('should return NetworkFailure when no internet connection', () async {
      // arrange
      const tFailure = NetworkFailure('No internet connection');

      when(() => mockRepository.getMediaItems(
            page: any(named: 'page'),
            limit: any(named: 'limit'),
            type: any(named: 'type'),
          )).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await useCase(const GetMediaItemsParams());

      // assert
      expect(result, const Left(tFailure));
    });
  });
}
