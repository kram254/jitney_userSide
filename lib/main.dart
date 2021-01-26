import 'package:flutter/material.dart';
import 'package:jitney_userSide/providers/app.dart';
import 'screens/home.dart';
import 'package:provider/provider.dart';
void main(){
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AppProvider>.value(
        value: AppProvider(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'j!tney',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomeScreen(title: 'J!tney'),
    );
  }
}


