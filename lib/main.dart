import 'exported.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //! FIREBASE
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //! Set Orientation -> portraitUp only
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: const EntryPoint(),
    );
  }
}

class EntryPoint extends StatelessWidget {
  const EntryPoint({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Finance Goal',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: MaterialColor(primary, swatch),
        ),
        primaryColor: appPrimary,
        appBarTheme: AppBarTheme(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: statusBarColor,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: statusBarColor,
          ),
          backgroundColor: appPrimary,
          elevation: 0.0,
          centerTitle: true,
          titleTextStyle: MyTextStyle.semiBold.copyWith(
            fontSize: 18,
            color: black,
          ),
        ),
        scaffoldBackgroundColor: background,
        canvasColor: white,
        useMaterial3: false,
        fontFamily: 'Inter',
        splashColor: splashColor,
        highlightColor: highlightColor,
        hoverColor: hoverColor,
      ),
      // routes: routes,
      onGenerateRoute: (_) => onGenerateRoute(_, context),
      initialRoute: RoutePath.splashScreenRoute,
    );
  }
}

final providers = <SingleChildWidget>[
  ChangeNotifierProvider(create: (_) => GeneralProvider()),
  ChangeNotifierProvider(create: (_) => AuthProvider()),
  ChangeNotifierProvider(create: (_) => GoalProvider()), 
];
