import 'package:chatapp/Chat/Tela_usuario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

TextEditingController username;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
username = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
appBar: AppBar(
  title: Text("Login"),
),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
TextField(
  controller: username,
  textAlign: TextAlign.center,
  decoration: InputDecoration(
      filled:true,
fillColor: Colors.white,
      contentPadding: EdgeInsets.all(20),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(6.0)),

    )
  ),

),
            SizedBox(height: 20,)
            ,OutlineButton(
              child: Text("Login"),
              onPressed: (){
            if(username.text.isEmpty){
              return;
            }
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Tela_usuario(usuario:username.text)));
              },
            )
          ],
        ),
      ),
    );
  }
}
