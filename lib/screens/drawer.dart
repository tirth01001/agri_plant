

import 'package:agriplant/atemp/temp.dart';
import 'package:agriplant/auth/config/routes/app_pages.dart';
import 'package:agriplant/auth/utils/services/service.dart';
import 'package:agriplant/models/user_account.dart';
import 'package:agriplant/pages/onboarding_page.dart';
import 'package:agriplant/screens/crop_advise.dart';
import 'package:agriplant/screens/fertilizer_cacle.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30,),
          SizedBox(
            width: 100,
            height: 100,
            child: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(globalUserAccount.profile[Profile.dp]),
              // backgroundImage: NetworkImage("https://cdn1.iconfinder.com/data/icons/user-avatars-2/300/10-1024.png"),
            ),
          ),
          const SizedBox(height: 20,),
          Text(
            globalUserAccount.profile[Profile.name] ?? "User Name",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            globalUserAccount.profile[Profile.emailaddress].toString(),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 10,),
          const Divider(indent: 20,endIndent: 20,),
          // const SizedBox(height: 10,),
 
          //Button -1
          //Go To Order Page Through the button
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Temp())),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Row(
                children: [
                  Icon(IconlyLight.document),
                  const SizedBox(width: 7,),
                  Text("Order"),
                ],
              ),
            ),
          ),


          //Button -2
          //Crop Advice Button
          GestureDetector(
            onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => CropAdvise())),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Row(
                children: [
                  Icon(IconlyLight.graph),
                  const SizedBox(width: 7,),
                  Text("Crop Advise"),
                ],
              ),
            ),
          ),


          //Button -?
          //Fertilizer Calculator
          GestureDetector(
            onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => FertilizerCalculatorScreen())),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Row(
                children: [
                  Icon(IconlyLight.category),
                  const SizedBox(width: 7,),
                  Text("Fertilizer Calculate"),
                ],
              ),
            ),
          ),



          //Button -?
          //Fertilizer Calculator
          // GestureDetector(
          //   onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => TransactionHistoryScreen())),
          //   child: Container(
          //     margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          //     child: Row(
          //       children: [
          //         Icon(IconlyLight.category),
          //         const SizedBox(width: 7,),
          //         Text("Transaction"),
          //       ],
          //     ),
          //   ),
          // ),


          //Button -3
          //About Us option
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Row(
              children: [
                Icon(IconlyLight.infoSquare),
                const SizedBox(width: 7,),
                Text("About us"),
              ],
            ),
          ),



          //Button -3
          //About Us option
          GestureDetector(
            onTap: (){

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
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Row(
                children: [
                  Icon(IconlyLight.logout,color: Colors.red,),
                  const SizedBox(width: 7,),
                  Text("Logout"),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}