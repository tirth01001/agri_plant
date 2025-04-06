


import 'dart:io';

import 'package:agriplant/models/user_account.dart';
import 'package:agriplant/pages/onboarding_page.dart';
import 'package:agriplant/service/firebase_service.dart';
import 'package:agriplant/service/loading.dart';
import 'package:agriplant/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  String _gender = "male";
  String _farmingType = "Organic";
  // Organic / Traditional / Hydroponic

  // List<String> _cropGrown = [];
  // List<String> 

  Widget textField({TextEditingController ? controller,String ? hint,Widget ? prefix}) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
    child: TextField(
      controller: controller,
      onSubmitted: (value) {
    
    
      },
      decoration: InputDecoration(
        hintText: hint,
        isDense: true,
        contentPadding: const EdgeInsets.all(12.0),
        border: const OutlineInputBorder(
          borderSide: BorderSide(),
          borderRadius: BorderRadius.all(
            Radius.circular(99),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(99),
          ),
        ),
        prefixIcon: prefix,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10,),
          //Change Profile Can do this
          GestureDetector(
            onTap: () async {
              File ? profileImage = await pickFile();
              if(profileImage != null){
                Loading<String?>(
                  context, 
                  process: uploadProfileImage(profileImage, globalUserAccount.uid),
                  onSucess: (data) {
                    if(data != null){
                      globalUserAccount.profile[Profile.dp] = data;
                      Loading<Result>(
                        context, 
                        process: FirebaseService.service.updateProfile(globalUserAccount),
                      ).executeProcess();
                    }
                  },
                ).executeProcess();
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 15),
              child: CircleAvatar(
                radius: 62,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: CircleAvatar(
                  radius: 60,
                  foregroundImage: NetworkImage(globalUserAccount.profile[Profile.dp]),
                  // foregroundImage: NetworkImage('https://images.unsplash.com/photo-1464863979621-258859e62245?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=3386&q=80'),
                ),
              ),
            ),
          ),

          const SizedBox(height: 30,),

          textField(
            hint: "Name",
            prefix: Icon(IconlyLight.edit)
          ),
          textField(
            hint: "Email Address",
            prefix: Icon(IconlyLight.work)
          ),
          textField(
            hint: "Mobile Number",
            prefix: Icon(IconlyLight.call)
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300)
                  ),
                  child: DropdownButton<String>(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    value: _gender,
                    borderRadius: BorderRadius.circular(8),
                    underline: SizedBox(),
                    items: [
                      DropdownMenuItem(
                        value: "male",
                        child: Text("Male"),
                      ),
                      DropdownMenuItem(
                        value: "female",
                        child: Text("Female"),
                      ),
                    ], 
                    onChanged: (value){
                      setState(() {
                        _gender = value ?? "male";
                      });
                    },
                  ),
                ),
                Expanded(
                  child: textField(
                    hint: "Date of Birth",
                    prefix: Icon(IconlyLight.calendar),
                  ),
                )
              ],
            ),
          ),


          // Organic / Traditional / Hydroponic
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300)
                  ),
                  child: DropdownButton<String>(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    value: _farmingType,
                    borderRadius: BorderRadius.circular(8),
                    underline: SizedBox(),
                    items: [
                      DropdownMenuItem(
                        value: "Organic",
                        child: Text("Organic"),
                      ),
                      DropdownMenuItem(
                        value: "Traditional",
                        child: Text("Traditional"),
                      ),
                      DropdownMenuItem(
                        value: "Hydroponic",
                        child: Text("Hydroponic"),
                      ),
                    ], 
                    onChanged: (value){
                      setState(() {
                        _farmingType = value ?? "Organic";
                      });
                    },
                  ),
                ),
                Expanded(
                  child: textField(
                    hint: "Land Area",
                    prefix: Icon(IconlyLight.editSquare),
                  ),
                )
              ],
            ),
          ),

        ],
      ),
      bottomNavigationBar: Container(
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: ElevatedButton(
          onPressed: (){}, 
          child: Text("Update Profile")
        ),
      ),
    );
  }
}