import 'package:experiment/extentions.dart';
import 'package:experiment/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  // Ensure that Flutter is initialized.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase.  This is crucial for using Firebase services.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  // Run the app.
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: SplashScreen(),
    );
  }
}
