



import 'package:agriplant/models/crop_care_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class CropMoreDetail extends StatelessWidget {
  
  final CropCareModel model;
  final int idx;
  const CropMoreDetail({super.key,required this.model,required this.idx});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            floating: false,
            pinned: true,
            leading: IconButton(onPressed: ()=>Navigator.pop(context), icon: Icon(IconlyLight.arrowLeft,color: Colors.white,)),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(model.widgets[idx].images,fit: BoxFit.cover,),
            ),
          ),
          SliverList.builder(
            itemBuilder: (context, index) {
              
              return Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5,),
                      Text(model.widgets[idx].boxDescr[index]["title"],style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),),
                      const SizedBox(height: 5,),
                      Text(model.widgets[idx].boxDescr[index]["descr"]),
                      const SizedBox(height: 5,),
                    ],
                  ),
                ),
              );
            },
            itemCount: model.widgets[idx].boxDescr.length,
          )
        ],
      ),
    );
  }
}