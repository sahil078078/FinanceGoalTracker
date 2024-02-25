import 'exported.dart';

//! COLORS
const int primary = 0xff9EECFF;
const Color appPrimary = Color(primary);
const Color black = Color(0xff000000);
const Color white = Color(0xffffffff);
const background = Color(0xfff3fafe); // e7f5fe,dbf0fd
const statusBarColor = Color(0xff87CEFA);
const red = Color(0xffff2c2c);
const redMsg = Color(0xfff94449);
const green = Color(0xff3B8132);
const violet = Color(0xff81007F);
const blue = Color(0xff0070C0);
const orange = Color(0xffFFA500);
//* LIGHT COLOR
const Color splashColor = Color(0x0f9EECFF);
const Color hoverColor = Color(0x0D9EECFF);
const Color highlightColor = Color(0x039EECFF);

//* GREY SHADE
const Color grey50 = Color(0xffF3F4F9);
const Color grey100 = Color(0xffD3DFE4);
const Color grey200 = Color(0xffD3D4D9);
const Color grey300 = Color(0xffC1C2C9);
const Color grey400 = Color(0xffADAEB3);
const Color grey500 = Color(0xff919297);
const Color grey600 = Color(0xff828388);
const Color grey700 = Color(0xff75767B);
const Color grey800 = Color(0xff55565B);
const Color grey900 = Color(0xff393A3F);
const Color grey = Color(0xff232429);

//* Swatch Color
final swatch = <int, Color>{
  50: const Color.fromRGBO(158, 236, 255, 0.1),
  100: const Color.fromRGBO(158, 236, 255, 0.2),
  200: const Color.fromRGBO(158, 236, 255, 0.3),
  300: const Color.fromRGBO(158, 236, 255, 0.4),
  400: const Color.fromRGBO(158, 236, 255, 0.5),
  500: const Color.fromRGBO(158, 236, 255, 0.6),
  600: const Color.fromRGBO(158, 236, 255, 0.7),
  700: const Color.fromRGBO(158, 236, 255, 0.8),
  800: const Color.fromRGBO(158, 236, 255, 0.9),
  900: const Color.fromRGBO(158, 236, 255, 1),
};

//! GoalsList
final userGoal = <Map<String, dynamic>>[
  {
    'title': 'Home',
    'png': 'asset/images/home.png',
  },
  {
    'title': 'Car',
    'png': 'asset/images/car.png',
  },
  {
    'title': 'Tour',
    'png': 'asset/images/tour.png',
  },
  {
    'title': 'Loan',
    'png': 'asset/images/loan.png',
  },
  {
    'title': 'Debt',
    'png': 'asset/images/debt.png',
  },
];

//! Numerical
const padding = EdgeInsets.symmetric(horizontal: 17, vertical: 15);
const square15 = SizedBox(width: 15, height: 15);
