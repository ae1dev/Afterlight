// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'apps.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppState {

/// The apps
 List<dynamic> get apps;/// The favorite apps
 List<dynamic> get favoriteApps;/// The favorites
 List<dynamic> get favorites;
/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppStateCopyWith<AppState> get copyWith => _$AppStateCopyWithImpl<AppState>(this as AppState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppState&&const DeepCollectionEquality().equals(other.apps, apps)&&const DeepCollectionEquality().equals(other.favoriteApps, favoriteApps)&&const DeepCollectionEquality().equals(other.favorites, favorites));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(apps),const DeepCollectionEquality().hash(favoriteApps),const DeepCollectionEquality().hash(favorites));

@override
String toString() {
  return 'AppState(apps: $apps, favoriteApps: $favoriteApps, favorites: $favorites)';
}


}

/// @nodoc
abstract mixin class $AppStateCopyWith<$Res>  {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) _then) = _$AppStateCopyWithImpl;
@useResult
$Res call({
 List<dynamic> apps, List<dynamic> favoriteApps, List<dynamic> favorites
});




}
/// @nodoc
class _$AppStateCopyWithImpl<$Res>
    implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._self, this._then);

  final AppState _self;
  final $Res Function(AppState) _then;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? apps = null,Object? favoriteApps = null,Object? favorites = null,}) {
  return _then(_self.copyWith(
apps: null == apps ? _self.apps : apps // ignore: cast_nullable_to_non_nullable
as List<dynamic>,favoriteApps: null == favoriteApps ? _self.favoriteApps : favoriteApps // ignore: cast_nullable_to_non_nullable
as List<dynamic>,favorites: null == favorites ? _self.favorites : favorites // ignore: cast_nullable_to_non_nullable
as List<dynamic>,
  ));
}

}


/// @nodoc


class _AppState implements AppState {
  const _AppState({final  List<dynamic> apps = const [], final  List<dynamic> favoriteApps = const [], final  List<dynamic> favorites = const []}): _apps = apps,_favoriteApps = favoriteApps,_favorites = favorites;
  

/// The apps
 final  List<dynamic> _apps;
/// The apps
@override@JsonKey() List<dynamic> get apps {
  if (_apps is EqualUnmodifiableListView) return _apps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_apps);
}

/// The favorite apps
 final  List<dynamic> _favoriteApps;
/// The favorite apps
@override@JsonKey() List<dynamic> get favoriteApps {
  if (_favoriteApps is EqualUnmodifiableListView) return _favoriteApps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_favoriteApps);
}

/// The favorites
 final  List<dynamic> _favorites;
/// The favorites
@override@JsonKey() List<dynamic> get favorites {
  if (_favorites is EqualUnmodifiableListView) return _favorites;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_favorites);
}


/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppStateCopyWith<_AppState> get copyWith => __$AppStateCopyWithImpl<_AppState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppState&&const DeepCollectionEquality().equals(other._apps, _apps)&&const DeepCollectionEquality().equals(other._favoriteApps, _favoriteApps)&&const DeepCollectionEquality().equals(other._favorites, _favorites));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_apps),const DeepCollectionEquality().hash(_favoriteApps),const DeepCollectionEquality().hash(_favorites));

@override
String toString() {
  return 'AppState(apps: $apps, favoriteApps: $favoriteApps, favorites: $favorites)';
}


}

/// @nodoc
abstract mixin class _$AppStateCopyWith<$Res> implements $AppStateCopyWith<$Res> {
  factory _$AppStateCopyWith(_AppState value, $Res Function(_AppState) _then) = __$AppStateCopyWithImpl;
@override @useResult
$Res call({
 List<dynamic> apps, List<dynamic> favoriteApps, List<dynamic> favorites
});




}
/// @nodoc
class __$AppStateCopyWithImpl<$Res>
    implements _$AppStateCopyWith<$Res> {
  __$AppStateCopyWithImpl(this._self, this._then);

  final _AppState _self;
  final $Res Function(_AppState) _then;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? apps = null,Object? favoriteApps = null,Object? favorites = null,}) {
  return _then(_AppState(
apps: null == apps ? _self._apps : apps // ignore: cast_nullable_to_non_nullable
as List<dynamic>,favoriteApps: null == favoriteApps ? _self._favoriteApps : favoriteApps // ignore: cast_nullable_to_non_nullable
as List<dynamic>,favorites: null == favorites ? _self._favorites : favorites // ignore: cast_nullable_to_non_nullable
as List<dynamic>,
  ));
}


}

// dart format on
