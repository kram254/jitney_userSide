import 'package:flutter/material.dart';
import 'package:jitney_userSide/providers/app.dart';
import 'package:jitney_userSide/providers/user.dart';
import 'package:jitney_userSide/screens/login.dart';
import 'package:jitney_userSide/screens/splash.dart';
import 'locators/service_locator.dart';
import 'screens/home.dart';
import 'package:provider/provider.dart';


void main(){
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  return runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AppProvider>.value(
        value: AppProvider(),
      ),
      ChangeNotifierProvider<UserProvider>.value(
        value: UserProvider.initialize(),
      )
    ],
    child:  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'j!tney',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: HomeScreen(title: 'J!tney'),
    )
  ));
  }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserProvider auth = Provider.of<UserProvider>(context);
    switch (auth.status) {
      case Status.Uninitialized:
        return Splash();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return LoginScreen();
      case Status.Authenticated:
        return HomeScreen();
      default:
        return LoginScreen();
    }
  }
}


