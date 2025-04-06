



import 'package:agriplant/screens/crop_detail.dart';
import 'package:flutter/material.dart';

class CropAdvise extends StatelessWidget {

  const CropAdvise({super.key});

  @override
  Widget build(BuildContext context) {

    final List<String> imags = [
      "assets/crop/crop_image/tomato.png",
      "assets/crop/crop_image/chili-pepper.png",
      "assets/crop/crop_image/onion.png",
      "assets/crop/crop_image/beet.png",
      "assets/crop/crop_image/cabbage.png",
      "assets/crop/crop_image/carrot.png",
      "assets/crop/crop_image/cucumber.png",
      "assets/crop/crop_image/eggplant.png",
      "assets/crop/crop_image/ginger.png",
      "assets/crop/crop_image/kale.png",
      "assets/crop/crop_image/pea.png",
      "assets/crop/crop_image/strawberry.png",
      "assets/crop/crop_image/grapes.png",
    ];
    // final List<String> names = [
    //   "Tomato","Red Chilli",  
    //   "Onion","Okra","Brinjal","Cabbage","Muskmelon",
    //   "Carrot","Cotton","Beans","Barley","Capsicum","Potato","Paddy",
    //   "Watermelon","Cauliflower","Brocoli","Beetroot",
    //   "Gralic","Groundnut","Soybean","Green gram",
    //   "Black gram","Cucumber","Bengal Gram","Red Gram",
    //   "Bitter gourd","Ridge gourd","Snake gourd","Bottle gourd",
    //   "Pole beans","Chrysanthemum","Merigold","Sugarcane",
    //   "Sunflower","Wheat","Ginger","Turmeric"
    // ];
    final List<String> names = [
      "Tomato","Red Chilli",  "Onion" , "Beetroot", "Cabbage",
      "Carrot","Cucumber","Eggplant","Ginger","Kale","Pea",
      "Strawberry","Grapes"
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back)),
        title: Text("Crop Advice"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: SingleChildScrollView(
          child: Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: List.generate(imags.length, (index){
            
                return GestureDetector(
                  onTap: (){

                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CropDetail(cropName: names[index])));
                  },
                  child: Container(
                    width: 100,
                    // margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          const SizedBox(height: 10,),
                          Container(
                            child: CircleAvatar(
                              backgroundImage: AssetImage(imags[index]),
                            ),
                          ),
                          const SizedBox(height: 8,),
                          Text(names[index],style: TextStyle(
                            fontSize: 14,
                          ),),
                          const SizedBox(height: 10,)
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}