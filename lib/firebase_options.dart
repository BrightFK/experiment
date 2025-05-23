// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAGvAbqGi5SRckfg5zbNAfk-VEhucI8yzA',
    appId: '1:248029410940:web:dbeed30086745e2d06bbf9',
    messagingSenderId: '248029410940',
    projectId: 'ecom-805dc',
    authDomain: 'ecom-805dc.firebaseapp.com',
    storageBucket: 'ecom-805dc.firebasestorage.app',
    measurementId: 'G-5932DK2ZMH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB4jqF0LZ9fdAnxIdN4YrvNca11B-JBOQg',
    appId: '1:248029410940:android:7a52e02543d3c4db06bbf9',
    messagingSenderId: '248029410940',
    projectId: 'ecom-805dc',
    storageBucket: 'ecom-805dc.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCTQz-dL7AJ7s6FwD90SGmxexldQSXumAU',
    appId: '1:248029410940:ios:864b6f9bc936841b06bbf9',
    messagingSenderId: '248029410940',
    projectId: 'ecom-805dc',
    storageBucket: 'ecom-805dc.firebasestorage.app',
    iosBundleId: 'com.example.experiment',
  );
}
