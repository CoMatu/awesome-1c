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

  bool get isEmpty =>
    (this.providerId?.isEmpty ?? true)
    && (this.uid?.isEmpty ?? true);

  bool get isNotEmpty =>
    (this.providerId?.isNotEmpty ?? false)
    && (this.uid?.isNotEmpty ?? false);

  User({
    String providerId,
    String uid,
    String displayName,
    String email,
    String photoUrl,
  }) : assert(providerId is String && uid is String && displayName is String && email is String)
    , this.providerId = providerId ?? ''
    , this.uid = uid ?? ''
    , this.displayName = displayName ?? ''
    , this.email = email ?? ''
    , this.photoUrl = photoUrl ?? '';

  User.empty()
    : this.providerId = ''
    , this.uid = ''
    , this.displayName = ''
    , this.email = ''
    , this.photoUrl = '';

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

  Map<String, dynamic> toFirebase() => <String, dynamic>{
    'providerId': providerId,
    'uid': uid,
    'displayName': displayName,
    'email': email,
    'photoUrl': photoUrl,
  };

  bool hasImage() =>
    isNotEmpty && (this.photoUrl?.isNotEmpty ?? false);

  @override
  int get hashCode => 
    '${this.providerId}-${this.uid}'.hashCode;
  @override
  operator ==(Object obj) => 
    obj is User 
    && obj.providerId == this.providerId 
    && obj.uid == this.uid;
  @override
  String toString() =>
    this.isEmpty
    ? 'Неавторизованный пользователь'
    : '${this.displayName} (${this.email})';
}