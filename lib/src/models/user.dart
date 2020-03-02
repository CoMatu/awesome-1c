import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0, adapterName: 'UserAdapter')
class User extends HiveObject {
  /// The provider identifier.
  @HiveField(0)
  String providerId;

  /// The provider’s user ID for the user.
  @HiveField(1)
  String uid;

  /// The name of the user.
  @HiveField(2)
  String displayName;

  /// The user’s email address.
  @HiveField(3)
  String email;

  /// The URL of the user’s profile photo.
  @HiveField(4)
  String photoUrl;

  ///
  bool get isEmpty =>
    (providerId?.isEmpty ?? true)
    && (uid?.isEmpty ?? true);

  ///
  bool get isNotEmpty =>
    (providerId?.isNotEmpty ?? false)
    && (uid?.isNotEmpty ?? false);

  ///
  User({
    String providerId,
    String uid,
    String displayName,
    String email,
    String photoUrl,
  }) : assert(providerId is String && uid is String && displayName is String && email is String)
    , providerId = providerId ?? ''
    , uid = uid ?? ''
    , displayName = displayName ?? ''
    , email = email ?? ''
    , photoUrl = photoUrl ?? '';

  ///
  User.empty()
    : providerId = ''
    , uid = ''
    , displayName = ''
    , email = ''
    , photoUrl = '';

  ///
  factory User.fromFirebase({
    String providerId,
    String uid,
    String displayName,
    String email,
    String photoUrl,
  }) => User(
    providerId: providerId,
    uid: uid,
    displayName: displayName,
    email: email,
    photoUrl: photoUrl,
  );

  ///
  Map<String, dynamic> toFirebase() => <String, dynamic>{
    'providerId': providerId,
    'uid': uid,
    'displayName': displayName,
    'email': email,
    'photoUrl': photoUrl,
  };

  ///
  bool hasImage() =>
    isNotEmpty && (photoUrl?.isNotEmpty ?? false);

  ///
  @override
  int get hashCode => 
    '$providerId-$uid'.hashCode;

  ///
  @override
  operator ==(Object obj) => 
    obj is User 
    && obj.providerId == providerId 
    && obj.uid == uid;

  ///
  @override
  String toString() =>
    isEmpty
    ? 'Неавторизованный пользователь'
    : '$displayName ($email)';
}