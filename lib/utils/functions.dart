



import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> pickFile() async {
  try{

    ImagePicker picker = ImagePicker();
    final XFile ? file = await picker.pickImage(source: ImageSource.gallery);

    if(file != null){
      return File(file.path);
    }
    return null;
  }catch(e){
    debugPrint(e.toString());
  }
  return null;
}


Future<String?> uploadProfileImage(File file,String userName) async{
  try{  

    final Reference reference = FirebaseStorage.instance.ref().child('user/$userName');
    final UploadTask uploadTask = reference.putFile(file);

    final TaskSnapshot taskSnapshot = await uploadTask;

    String url = await taskSnapshot.ref.getDownloadURL();

    return url;
  }catch(e){
    //E
  }
  return null;
}