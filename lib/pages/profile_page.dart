import 'dart:io';

import 'package:agriplant/atemp/temp.dart';
import 'package:agriplant/auth/config/routes/app_pages.dart';
import 'package:agriplant/auth/utils/services/service.dart';
import 'package:agriplant/models/user_account.dart';
import 'package:agriplant/pages/components/edit_location.dart';
import 'package:agriplant/pages/components/edit_profile.dart';
import 'package:agriplant/pages/onboarding_page.dart';
import 'package:agriplant/service/firebase_service.dart';
import 'package:agriplant/service/loading.dart';
import 'package:agriplant/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {

  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  // final auth = AuthService();

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          GestureDetector(
            onTap: () async {

              // File ? profileImage = await pickFile();
              // if(profileImage != null){

              //   Loading<String?>(
              //     context, 
              //     process: uploadProfileImage(profileImage, globalUserAccount.uid),
              //     onSucess: (data) {
              //       if(data != null){

              //         globalUserAccount.profile[Profile.dp] = data;

              //         Loading<Result>(
              //           context, 
              //           process: FirebaseService.service.updateProfile(globalUserAccount),
              //         ).executeProcess();


              //       }
              //     },
              //   ).executeProcess();

              // }
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
          Center(
            child: Text(
              globalUserAccount.profile[Profile.name] ?? "User Name",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Center(
            child: Text(
              globalUserAccount.profile[Profile.emailaddress].toString(),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          const SizedBox(height: 25),
          ListTile(
            title: const Text("Profile"),
            leading: const Icon(IconlyLight.profile),
            onTap: () {

              Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()));
            },
          ),
          ListTile(
            title: const Text("Location"),
            leading: const Icon(IconlyLight.location),
            onTap: () {

              Navigator.push(context, MaterialPageRoute(builder: (context) => EditLocationScreen()));
            },
          ),
          ListTile(
            title: const Text("My orders"),
            leading: const Icon(IconlyLight.bag),
            onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Temp(),
                ));
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const OrdersPage(),
              //   ));
            
            },
          ),
          ListTile(
            title: const Text("About us"),
            leading: const Icon(IconlyLight.infoSquare),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Logout"),
            leading: const Icon(IconlyLight.logout),
            onTap: () {

              showDialog(context: context, builder: (context) {

                return AlertDialog(
                  content: Container(
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          Text("Are you sure to logout ?"),
                          const SizedBox(height: 10,),
                          ElevatedButton(onPressed: ()async{
                      
                            final auth = AuthService();
                            // isLoading.value = true; 
                            await auth.signOut();
                            // isLoading.value = false;
                            Get.offAllNamed(Routes.splash);
                            // await auth.signOut();
                      
                          }, child: Text("LogOut"))
                        ],
                      ),
                    )
                  )
                );
              });

            },
          ),
        ],
      ),
    );
  }
}
