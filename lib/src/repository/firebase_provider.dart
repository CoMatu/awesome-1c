import 'package:firebase_core/firebase_core.dart' as fb_core;
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:google_sign_in/google_sign_in.dart' as google_sign_in;
import 'package:cloud_firestore/cloud_firestore.dart' as fb_store;
import '../models/user.dart';
import 'logger.dart';

class FirebaseProvider {
  final Log _log = Log();
  fb_core.FirebaseApp _app;
  fb_auth.FirebaseAuth _auth;
  fb_store.Firestore _store;
  Stream<User> _onAuthStateChanged;
  Stream<User> get onAuthStateChanged => _onAuthStateChanged;
  
  bool _isInit = false;

  /// Проверка инициализации Firebase
  Future<void> init() async {
    if (_isInit) return;
    List<fb_core.FirebaseApp> _apps = await fb_core.FirebaseApp.allApps();
    if (_apps == null || _apps.isEmpty) {
      throw 'No FirebaseApps';
    }
    _app = _apps?.first;
    _auth = fb_auth.FirebaseAuth.fromApp(_app);
    _store = fb_store.Firestore.instance;    
    _isInit = _app is fb_core.FirebaseApp;
    _onAuthStateChanged = _auth.onAuthStateChanged.map<User>((fb_auth.FirebaseUser event) => 
      User(
        providerId: event?.providerId ?? '',
        uid: event?.uid ?? '',
        displayName: event?.displayName ?? '',
        email: event?.email ?? '',
        photoUrl: event?.photoUrl ?? '',
      ))..handleError((dynamic error) => _log.e('Произошла ошибка подписки на смену состояний авторизации FirebaseAuth: ${error.toString()}'));
    _log.vv(_isInit ? 'Firebase приложение (${_app.name}) успешно инициализировано' : 'Firebase приложение не инициализировано');
  }

  ///
  Future<User> currentUser() async {
    fb_auth.FirebaseUser currentUser = await _auth.currentUser();
    if (currentUser is fb_auth.FirebaseUser) {
      _log.vvv('Получен пользователь из кэша');
      return User(
        providerId: currentUser.providerId,
        uid: currentUser.uid,
        displayName: currentUser.displayName,
        email: currentUser.email,
        photoUrl: currentUser.photoUrl,
      );
    }
    _log.vvv('Пользователь в кэше не найден');
    return null;
  }

  /// Авторизация в Firebase через Google Sign-In
  Future<User> signIn() async {
    // Инициализируем FirebaseAuth и GoogleSignIn
    fb_auth.FirebaseUser currentUser = await _auth.currentUser();
    if (currentUser is fb_auth.FirebaseUser) {
      _log.vvvv('Получен пользователь из кэша');
      return User(
        providerId: currentUser.providerId,
        uid: currentUser.uid,
        displayName: currentUser.displayName,
        email: currentUser.email,
        photoUrl: currentUser.photoUrl,
      );
    }

    final google_sign_in.GoogleSignIn _googleSignIn = google_sign_in.GoogleSignIn(
      scopes: <String>[
        'email',
        'profile',
      ],
    );

    // Пробуем авторизоваться в гугле
    _log.vvvv('Начата авторизация в гугле');
    google_sign_in.GoogleSignInAccount _googleUser = await _googleSignIn.signIn()
                                                    .catchError((Object err) => null);
    if (_googleUser == null) {
      _log.vvvv('Авторизация прервана');
      return null;
    }

    // Получим данные авторизации для аккаунта
    final google_sign_in.GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;

    final fb_auth.AuthCredential credential = fb_auth.GoogleAuthProvider.getCredential(
      idToken: _googleAuth.idToken, 
      accessToken: _googleAuth.accessToken,
    );
    _log.vvvv('Авторизуемся в firebase с данными гугла');
    fb_auth.AuthResult authResult = await _auth.signInWithCredential(credential);
    currentUser = authResult?.user;
    if (currentUser is fb_auth.FirebaseUser) {
      _log.vvvv('Получен пользователь firebase');
      return User(
        providerId: currentUser.providerId,
        uid: currentUser.uid,
        displayName: currentUser.displayName,
        email: currentUser.email,
        photoUrl: currentUser.photoUrl,
      );
    }
    _log.w('Пользователь firebase не получен');
    return null;
  }

  /// Деавторизация
  Future<void> signOut() async {
    await _auth.signOut();
    _log.vvvv('Разлогинен в firebase');
  }

  /// Поместить модель в Firebase
  Future<void> put(String collection, Map<String, dynamic> data, [String path]) =>
    _store.collection(collection)
          .document(path)
          .setData(data);

  /// Получить модель из Firebase
  Future<Map<String, dynamic>> get(String collection, String path) =>
    _store.collection(collection)
          .document(path)
          .get(source: fb_store.Source.server)
          ?.then<Map<String, dynamic>>((fb_store.DocumentSnapshot snapshot) => snapshot?.data);

  /// Получить модель из Firebase
  Future<List<Map<String, dynamic>>> getDocumentsAfter(String collection, DateTime date) =>
    _store.collection(collection)
          .where('date', isGreaterThanOrEqualTo: date)
          .getDocuments(source: fb_store.Source.server)
          ?.then<List<Map<String, dynamic>>>((fb_store.QuerySnapshot snapshots) => 
            snapshots
            ?.documents
            ?.map<Map<String, dynamic>>((fb_store.DocumentSnapshot snapshot) => snapshot?.data)
            ?.toList(),
          );
}