

import 'package:flutter/material.dart';

class Loading<T> {

  final BuildContext context;
  final Future<T> process;
  final void Function(T data) ? onSucess;
  final void Function(T data) ? onFail;
  Loading(this.context,{required this.process,this.onFail,this.onSucess});

  void _start(){
    showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator(),));    
  }


  void _stop() => Navigator.pop(context);

  void executeProcess() async {
    _start();
    T returnData = await process;
    _stop();
    if(returnData != null){
      if(onSucess != null) onSucess!(returnData);
    }else{
      if(onFail != null) onFail!(returnData);
    }
  }


} 