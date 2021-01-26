import 'package:flutter/material.dart';
import 'package:jitney_userSide/helpers/navigation.dart';
import 'package:jitney_userSide/helpers/style.dart';
import 'package:jitney_userSide/providers/user.dart';
import 'package:jitney_userSide/screens/home.dart';
import 'package:jitney_userSide/screens/registration.dart';
import 'package:jitney_userSide/widgets/custom_txt.dart';
import 'package:jitney_userSide/widgets/loading.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      key: _key,
      backgroundColor: orange,
      body: authProvider.status == Status.Authenticating? Loading() : SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: orange,
              height: 100,
            ),

            Container(
              color: orange,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset("images/logo.png", width: 230, height: 230,),
                ],
              ),
            ),

            Container(
              height: 60,
              color: orange,
            ),
           SizedBox(
             height: 20,
           ),
           Padding(
             padding: const EdgeInsets.all(12),
             child: Container(
               decoration: BoxDecoration(
                 border: Border.all(color: white),
                 borderRadius: BorderRadius.circular(5)
               ),
               child: Padding(padding: EdgeInsets.only(left: 10),
               child: TextFormField(
                 controller: authProvider.email,
                 decoration: InputDecoration(
                   hintStyle: TextStyle(color: white),
                     border: InputBorder.none,
                     hintText: "Email",
                     icon: Icon(Icons.email, color: white,)
                 ),
               ),),
             ),
           ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: white),
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Padding(padding: EdgeInsets.only(left: 10),
                  child: TextFormField(
                    controller: authProvider.password,
                    decoration: InputDecoration(
                        hintStyle: TextStyle(color: white),
                        border: InputBorder.none,
                        hintText: "Password",
                        icon: Icon(Icons.lock, color: white,)
                    ),
                  ),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                onTap: ()async{
                  if(!await authProvider.signIn()){
                    _key.currentState.showSnackBar(
                      SnackBar(content: Text("Login failed!"))
                    );
                    return;
                  }
                  authProvider.clearController();
                  changeScreenReplacement(context, HomeScreen());
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: white,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Padding(padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CustomText(text: "Login", color: black, size: 22,)
                      ],
                    ),),
                ),
              ),
            ),

            GestureDetector(
              onTap: (){
                changeScreen(context, RegistrationScreen());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomText(text: "Register here", size: 20, color: white,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
