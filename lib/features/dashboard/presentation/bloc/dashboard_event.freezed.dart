// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$DashboardEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() refreshRequested,
    required TResult Function() syncRequested,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? refreshRequested,
    TResult? Function()? syncRequested,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? refreshRequested,
    TResult Function()? syncRequested,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_RefreshRequested value) refreshRequested,
    required TResult Function(_SyncRequested value) syncRequested,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_RefreshRequested value)? refreshRequested,
    TResult? Function(_SyncRequested value)? syncRequested,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_RefreshRequested value)? refreshRequested,
    TResult Function(_SyncRequested value)? syncRequested,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardEventCopyWith<$Res> {
  factory $DashboardEventCopyWith(
    DashboardEvent value,
    $Res Function(DashboardEvent) then,
  ) = _$DashboardEventCopyWithImpl<$Res, DashboardEvent>;
}

/// @nodoc
class _$DashboardEventCopyWithImpl<$Res, $Val extends DashboardEvent>
    implements $DashboardEventCopyWith<$Res> {
  _$DashboardEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$StartedImplCopyWith<$Res> {
  factory _$$StartedImplCopyWith(
    _$StartedImpl value,
    $Res Function(_$StartedImpl) then,
  ) = __$$StartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StartedImplCopyWithImpl<$Res>
    extends _$DashboardEventCopyWithImpl<$Res, _$StartedImpl>
    implements _$$StartedImplCopyWith<$Res> {
  __$$StartedImplCopyWithImpl(
    _$StartedImpl _value,
    $Res Function(_$StartedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DashboardEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StartedImpl implements _Started {
  const _$StartedImpl();

  @override
  String toString() {
    return 'DashboardEvent.started()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() refreshRequested,
    required TResult Function() syncRequested,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? refreshRequested,
    TResult? Function()? syncRequested,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? refreshRequested,
    TResult Function()? syncRequested,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_RefreshRequested value) refreshRequested,
    required TResult Function(_SyncRequested value) syncRequested,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_RefreshRequested value)? refreshRequested,
    TResult? Function(_SyncRequested value)? syncRequested,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_RefreshRequested value)? refreshRequested,
    TResult Function(_SyncRequested value)? syncRequested,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements DashboardEvent {
  const factory _Started() = _$StartedImpl;
}

/// @nodoc
abstract class _$$RefreshRequestedImplCopyWith<$Res> {
  factory _$$RefreshRequestedImplCopyWith(
    _$RefreshRequestedImpl value,
    $Res Function(_$RefreshRequestedImpl) then,
  ) = __$$RefreshRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RefreshRequestedImplCopyWithImpl<$Res>
    extends _$DashboardEventCopyWithImpl<$Res, _$RefreshRequestedImpl>
    implements _$$RefreshRequestedImplCopyWith<$Res> {
  __$$RefreshRequestedImplCopyWithImpl(
    _$RefreshRequestedImpl _value,
    $Res Function(_$RefreshRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DashboardEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RefreshRequestedImpl implements _RefreshRequested {
  const _$RefreshRequestedImpl();

  @override
  String toString() {
    return 'DashboardEvent.refreshRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RefreshRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() refreshRequested,
    required TResult Function() syncRequested,
  }) {
    return refreshRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? refreshRequested,
    TResult? Function()? syncRequested,
  }) {
    return refreshRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? refreshRequested,
    TResult Function()? syncRequested,
    required TResult orElse(),
  }) {
    if (refreshRequested != null) {
      return refreshRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_RefreshRequested value) refreshRequested,
    required TResult Function(_SyncRequested value) syncRequested,
  }) {
    return refreshRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_RefreshRequested value)? refreshRequested,
    TResult? Function(_SyncRequested value)? syncRequested,
  }) {
    return refreshRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_RefreshRequested value)? refreshRequested,
    TResult Function(_SyncRequested value)? syncRequested,
    required TResult orElse(),
  }) {
    if (refreshRequested != null) {
      return refreshRequested(this);
    }
    return orElse();
  }
}

abstract class _RefreshRequested implements DashboardEvent {
  const factory _RefreshRequested() = _$RefreshRequestedImpl;
}

/// @nodoc
abstract class _$$SyncRequestedImplCopyWith<$Res> {
  factory _$$SyncRequestedImplCopyWith(
    _$SyncRequestedImpl value,
    $Res Function(_$SyncRequestedImpl) then,
  ) = __$$SyncRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SyncRequestedImplCopyWithImpl<$Res>
    extends _$DashboardEventCopyWithImpl<$Res, _$SyncRequestedImpl>
    implements _$$SyncRequestedImplCopyWith<$Res> {
  __$$SyncRequestedImplCopyWithImpl(
    _$SyncRequestedImpl _value,
    $Res Function(_$SyncRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DashboardEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SyncRequestedImpl implements _SyncRequested {
  const _$SyncRequestedImpl();

  @override
  String toString() {
    return 'DashboardEvent.syncRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SyncRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() refreshRequested,
    required TResult Function() syncRequested,
  }) {
    return syncRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? refreshRequested,
    TResult? Function()? syncRequested,
  }) {
    return syncRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? refreshRequested,
    TResult Function()? syncRequested,
    required TResult orElse(),
  }) {
    if (syncRequested != null) {
      return syncRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_RefreshRequested value) refreshRequested,
    required TResult Function(_SyncRequested value) syncRequested,
  }) {
    return syncRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_RefreshRequested value)? refreshRequested,
    TResult? Function(_SyncRequested value)? syncRequested,
  }) {
    return syncRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_RefreshRequested value)? refreshRequested,
    TResult Function(_SyncRequested value)? syncRequested,
    required TResult orElse(),
  }) {
    if (syncRequested != null) {
      return syncRequested(this);
    }
    return orElse();
  }
}

abstract class _SyncRequested implements DashboardEvent {
  const factory _SyncRequested() = _$SyncRequestedImpl;
}
