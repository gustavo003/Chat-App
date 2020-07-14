import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Usuarios extends StatelessWidget {
  List <String> usuario = List();

  Usuarios(this.usuario);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Usuarios"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: usuario.length,
        itemBuilder: (context, index){
          return Container(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border:Border.all(color: Colors.black)
              ),
              child: Text(usuario[index], style: TextStyle(

                fontWeight: FontWeight.bold,
                fontSize: 16
              ),),
            ),
          );

        },

      ),
    );
  }
}
