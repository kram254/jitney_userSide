import 'package:flutter/material.dart';
import 'package:jitney_userSide/helpers/navigation.dart';
import 'package:jitney_userSide/helpers/style.dart';
import 'package:jitney_userSide/providers/app.dart';
import 'package:jitney_userSide/providers/user.dart';
import 'package:jitney_userSide/screens/home.dart';
import 'package:jitney_userSide/screens/login.dart';
import 'package:jitney_userSide/widgets/custom_txt.dart';
import 'package:jitney_userSide/widgets/loading.dart';
import 'package:provider/provider.dart';


class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    UserProvider authProvider = Provider.of<UserProvider>(context);
    AppProvider app = Provider.of<AppProvider>(context);

    return Scaffold(
      key: _key,
      backgroundColor: orange,
      body: authProvider.status == Status.Authenticating? Loading() : SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: white,
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
              height: 40,
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
                    controller: authProvider.name,
                    decoration: InputDecoration(
                        hintStyle: TextStyle(color: white),
                        border: InputBorder.none,
                        labelStyle: TextStyle(color: white),
                        labelText: "Name",
                        hintText: "eg: Mark Ndaliro",
                        icon: Icon(Icons.person, color: white,)
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
                    controller: authProvider.email,
                    decoration: InputDecoration(
                        hintStyle: TextStyle(color: white),
                        border: InputBorder.none,
                        labelStyle: TextStyle(color: white),
                        labelText: "Email",
                        hintText: "jitney@jitney.com",
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
                    controller: authProvider.phone,
                    decoration: InputDecoration(
                        hintStyle: TextStyle(color: white),
                        border: InputBorder.none,
                        labelStyle: TextStyle(color: white),
                        labelText: "Phone",
                        hintText: "+254xxxxxxxxx",
                        icon: Icon(Icons.phone, color: white,)
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
                        labelStyle: TextStyle(color: white),
                        labelText: "Password",
                        hintText: "at least 6 digits",
                        icon: Icon(Icons.lock, color: white,)
                    ),
                  ),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                onTap: ()async{
                  if(!await authProvider.signUp()){
                    _key.currentState.showSnackBar(
                        SnackBar(content: Text("Registration failed!"))
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
                        CustomText(text: "Register", color: black, size: 22,)
                      ],
                    ),),
                ),
              ),
            ),

            GestureDetector(
              onTap: (){
                changeScreen(context, LoginScreen());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomText(text: "Login here", size: 20,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
