import 'package:firebase_core/firebase_core.dart';

class FirebaseConfig{
  static const _apiKey = 'AIzaSyDdOuK0aRUbpNFd235cIo-cWlnSv-DkPB4';
  static const _projectId = 'shoplift-ed2ec';
  static const _storageBucket = 'shoplift-ed2ec.appspot.com';
  static const _messagingSenderId = '185501209277';
  static const _appId = '1:185501209277:android:9cdf27e2d58e571757ddd4';

  String get apiKey => _apiKey;
  String get projectId => _projectId;
  String get storageBucket => _storageBucket;
  String get messagingSenderId => _messagingSenderId;
  String get appId => _appId;

  Future<void> init() async {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: apiKey,
            appId: appId,
            messagingSenderId: messagingSenderId,
            projectId: projectId));
  }
}
