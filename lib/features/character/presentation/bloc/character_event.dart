part of 'character_bloc.dart';

/// Base class for Character Events
abstract class CharacterEvent {
  const CharacterEvent();
}

/// Event: Fetch initial page of characters with pagination
class FetchCharactersPaginatedEvent extends CharacterEvent {}

/// Event: Load more characters (next page)
class LoadMoreCharactersEvent extends CharacterEvent {}

/// Event: Refresh character list
class RefreshCharactersPaginatedEvent extends CharacterEvent {}
