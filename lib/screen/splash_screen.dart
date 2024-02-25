import '../exported.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Future.delayed(
      const Duration(seconds: 4, milliseconds: 500),
      () {
        final user = context.read<AuthProvider>().currentUser;
        debugPrint('user : ${user?.phoneNumber}');
        if (user != null) {
          pushNRemoveUntil(context: context, newRouteName: RoutePath.home);
        } else {
          pushNRemoveUntil(context: context, newRouteName: RoutePath.loginScreen);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 280,
              height: 280,
              child: LottieBuilder.asset(
                'asset/lottie/goal.json',
                backgroundLoading: true,
                filterQuality: FilterQuality.high,
                frameRate: const FrameRate(30),
                fit: BoxFit.fill,
                animate: true,
                repeat: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
