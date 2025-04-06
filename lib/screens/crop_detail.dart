


import 'dart:convert';

import 'package:agriplant/main.dart';
import 'package:agriplant/models/crop_care_model.dart';
import 'package:agriplant/screens/crop_more_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class CropDetail extends StatelessWidget {
  
  final String cropName;
  const CropDetail({super.key,required this.cropName});


  Widget shortCropDetail(String image,String title,BuildContext context,CropCareModel model,int idx) {

    return GestureDetector(
      onTap: (){

        Navigator.push(context, MaterialPageRoute(builder: (context)=> CropMoreDetail(model: model, idx: idx)));
      },
      child: Container(
        width: 150,
        height: 200,
        // padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.green.shade100,
          borderRadius: BorderRadius.circular(8)
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 150,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(image,fit: BoxFit.cover,),
                ),
              ),
              const SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10,top: 5),
                child: Text(title),
              ),
              const SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: Text("Read more..",style: TextStyle(
                  fontSize: 15,
                  color: Colors.green
                ),),
              )
            ],
          ),
        ),
      ),
    );
  }
  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: ()=>Navigator.pop(context), icon: Icon(IconlyLight.arrowLeft)),
        title: Text(cropName),
      ),
      body: FutureBuilder(
        // future: rootBundle.loadString('assets/crop/${cropName.toLowerCase()}.json'), 
        future: rootBundle.loadString('assets/crop/tomato.json'),
        builder: (context, snapshot) {
          
          if(!snapshot.hasData){

            return Center(child: CircularProgressIndicator(),);
          }

          Map<String,dynamic> data = jsonDecode(snapshot.data!);

          return SingleChildScrollView(
            child: Column(
              children: List.generate(data["data"].length, (index){
                
            
                CropCareModel careModel = CropCareModel.fromJson(data["data"][index]);
            
                return IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: maxW,
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100
                        ),
                        child: Text(careModel.title,style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),),
                      ),   
                      const SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(careModel.subtitle),
                      ),
                      const SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: List.generate(careModel.widgets.length, (index){
                        
                            return shortCropDetail(careModel.widgets[index].images, careModel.widgets[index].title,context,careModel,index);
                          }),
                        ),
                      )
                    ],
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }
}