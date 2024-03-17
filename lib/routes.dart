import 'package:bookly/Features/Splash/presentation/views/splash_view.dart';
import 'package:bookly/Features/Splash/presentation/views/widgets/splash_view_body.dart';
import 'package:bookly/presentation/screens/admin_screens/admin_home_screen.dart';
import 'package:bookly/presentation/screens/admin_screens/add_new_book.dart';
import 'package:bookly/presentation/screens/login_screen.dart';
import 'package:bookly/presentation/screens/not_activated.dart';
import 'package:bookly/presentation/screens/signup_screen.dart';
import 'package:bookly/presentation/screens/users_home_screen.dart';
import 'package:flutter/material.dart';

import 'core/utils/strings.dart';


class AppRoutes {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case usersHomeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case splash:
        return MaterialPageRoute(builder: (_) => SplashView());
      case adminHomeScreen:
        return MaterialPageRoute(builder: (_) => AdminHomeScreen());
      case loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case signupScreen:
        return MaterialPageRoute(builder: (_) => SignupScreen());
      case addNewBook:
        return MaterialPageRoute(builder: (_) => AddBookScreen());
      case notActivated:
        return MaterialPageRoute(builder: (_) => NotActivated());

    }
  }
}
