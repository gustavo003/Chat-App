import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';

import 'Usuarios.dart';

class Tela_usuario extends StatefulWidget {

  final String usuario;

  Tela_usuario({this.usuario});

  @override
  _Tela_usuarioState createState() => _Tela_usuarioState();
}

class _Tela_usuarioState extends State<Tela_usuario> {
  SocketIO socket;
  List <Map <String, String>> mensagens;
  TextEditingController mensagem_controller;
  ScrollController scrollController;
Map<String, String> actual;


  String usuario;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usuario = widget.usuario;


    mensagens = List();
    actual = Map();
mensagem_controller = TextEditingController();
    socket = SocketIOManager().createSocketIO(
      'https://chat03app.herokuapp.com/',
      '/',
    );
    socket.init();

    socket.subscribe('receive_message', (data){
      Map<String, dynamic> dados = json.decode(data);
actual[dados['message']] = dados['usuario'];

setState(() {

  mensagens.insert(0, actual);
actual = {};
});
    });





    socket.connect();



  }




  Input(){



    return Container(
margin: EdgeInsets.only(left:20),
      child: TextField(
        controller: mensagem_controller,
decoration: InputDecoration.collapsed(hintText: "Digite sua mensagem"),
      ),
    );

  }



  Single_message(int index, {int x}){

    return Container(
      padding: const EdgeInsets.only(bottom:20, left:20, right:20, top:10),
      margin: const EdgeInsets.only(bottom: 10.0, left: 40.0,  top:10),
      decoration: BoxDecoration(
        color: Colors.lightBlue,
        borderRadius: BorderRadius.circular(20),

      ),
child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: <Widget>[

    Container(
      child: Text(mensagens[index].values.toList()[0] ,style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16
      ),),
    ),
        SizedBox(height: 10,),
        Text(mensagens[index].keys.toList()[0], style: TextStyle(
          color: Colors.white
        ),)
  ],
),
    );


  }
Mensagens(){

    return Expanded(
child: ListView.builder(
  reverse: true,
  controller: scrollController,
  itemCount: mensagens.length,
  itemBuilder: (BuildContext context, int index){

    return Single_message(index);
  },
),
    );

}


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Olá "+ usuario),
        backgroundColor: Colors.black,

      ),
      body: Column(
        children: <Widget>[

Mensagens(),


          Container(

child: Row(
children: <Widget>[

  Expanded(
    child:   Input()
    ,
  ),  Container(
    margin: EdgeInsets.only(right:12),
          child: IconButton(
            icon: Icon(Icons.send, color: Colors.red,),
            onPressed: (){
              if (mensagem_controller.text.isEmpty){
                return;
              }
              socket.sendMessage('send_message', json.encode({'message':mensagem_controller.text, 'usuario':usuario}));
              actual[mensagem_controller.text] = usuario;

              setState(() {
                mensagens.insert(0, actual);
actual = {};
              });
              mensagem_controller.text= '';


            },
          )
  ),
],
),

          ),
        ],
      ),
    );
  }
}

