import 'package:rsm/consts/consts.dart';
import 'package:rsm/controllers/challans_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const RSM());
}

class RSM extends StatelessWidget {
  const RSM({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthController(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeScreenController(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChallansController(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: regular,
          filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(
              backgroundColor: blueColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
          ),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
