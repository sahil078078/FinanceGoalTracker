import 'package:finance_tracker/screen/otp_screen.dart';
import 'screen/goal_details_screen.dart';
import 'exported.dart';
import 'screen/home.dart';
import 'screen/login_screen.dart';
import 'screen/splash_screen.dart';
import 'screen/select_goal_screen.dart';
import 'screen/create_goal.dart';

// final routes = <String, WidgetBuilder>{
//   RoutePath.splashScreenRoute: (context) => const SplashScreen(),
//   RoutePath.loginScreen: (context) => const LoginScreen(),
//   RoutePath.otp: (context) => const OTPScreen(),
//   RoutePath.selectGoalScreen: (context) => const SelectGoalScreen(),
//   RoutePath.home: (context) => const Home(),
//   RoutePath.createGoal: (context) => const CreateGoal(),
//   RoutePath.goalDetailsScreen: (context) => const GoalDetailsScreen(),
// };

Route<dynamic>? onGenerateRoute(RouteSettings settings, BuildContext context) {
  debugPrint('==> Route : ${settings.name}');

  late PageRouteBuilder<dynamic> page;

  //! PAGE BUILDER
  PageRouteBuilder<dynamic> builder({required Widget widget}) => PageRouteBuilder(
        settings: settings,
        pageBuilder: (_, __, ___) => widget,
        transitionsBuilder: (context, opacity, animation2, child) => FadeTransition(
          opacity: opacity,
          child: child,
        ),
        maintainState: true,
        transitionDuration: const Duration(milliseconds: 150),
        reverseTransitionDuration: const Duration(milliseconds: 150),
        opaque: false,
      );

  //! ROOT
  switch (settings.name) {
    case RoutePath.splashScreenRoute:
      page = builder(widget: const SplashScreen());
      break;
    case RoutePath.loginScreen:
      page = builder(widget: const LoginScreen());
      break;
    case RoutePath.otp:
      {
        final verificationId = settings.arguments as String? ?? '';
        if (verificationId.isNotEmpty) {
          page = builder(widget: OTPScreen(verificationId: verificationId));
        } else {
          page = builder(widget: const LoginScreen());
        }
      }
      break;
    case RoutePath.selectGoalScreen:
      page = builder(widget: const SelectGoalScreen());
      break;
    case RoutePath.home:
      page = builder(widget: const Home());
      break;
    case RoutePath.createGoal:
      page = builder(widget: const CreateGoal());
      break;
    case RoutePath.goalDetailsScreen:
      {
        final goal = settings.arguments as GoalModel?;
        if (goal != null) {
          page = builder(widget: GoalDetailsScreen(goal: goal));
        } else {
          page = builder(widget: const Home());
        }
      }
      break;
    default:
      page = builder(widget: const LoginScreen());
      break;
  }

  return page;
}
