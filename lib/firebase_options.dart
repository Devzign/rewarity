import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyD4JqrJsyX5Vge9qskSnLi3ZJRyGbXgj6o',
    appId: '1:149667161271:web:963cc32be501ed7f851932',
    messagingSenderId: '149667161271',
    projectId: 'rewarity',
    authDomain: 'rewarity.firebaseapp.com',
    storageBucket: 'rewarity.firebasestorage.app',
    measurementId: 'G-SCXXMQWSVR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyADrUoh13nOyGIn5LV3oAGxBzYLu9Ek-bo',
    appId: '1:149667161271:android:f4091547924faeb6851932',
    messagingSenderId: '149667161271',
    projectId: 'rewarity',
    storageBucket: 'rewarity.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCcPE5mt2fDVu4SRd5EbFnivDPWqCDcCFo',
    appId: '1:149667161271:ios:678ef0606c7a9bca851932',
    messagingSenderId: '149667161271',
    projectId: 'rewarity',
    storageBucket: 'rewarity.firebasestorage.app',
    iosBundleId: 'com.rewarity.loyallty.rewarity',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCcPE5mt2fDVu4SRd5EbFnivDPWqCDcCFo',
    appId: '1:149667161271:ios:678ef0606c7a9bca851932',
    messagingSenderId: '149667161271',
    projectId: 'rewarity',
    storageBucket: 'rewarity.firebasestorage.app',
    iosBundleId: 'com.rewarity.loyallty.rewarity',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD4JqrJsyX5Vge9qskSnLi3ZJRyGbXgj6o',
    appId: '1:149667161271:web:941ec90434c7f3ed851932',
    messagingSenderId: '149667161271',
    projectId: 'rewarity',
    authDomain: 'rewarity.firebaseapp.com',
    storageBucket: 'rewarity.firebasestorage.app',
    measurementId: 'G-67NBZ7T73C',
  );
}
