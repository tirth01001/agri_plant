



import 'package:agriplant/main.dart';
import 'package:agriplant/provider/expolar_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchFilter extends StatefulWidget {

  final ExpolarProvider provider;
  const SearchFilter({super.key,required this.provider});

  @override
  State<SearchFilter> createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {

 
  final List<String> _categorys = [
    "Seeds & Plants",
    "Fertilizers & Soil Enhancers",
    "Pesticides & Insecticides",
    "Farm Machinery & Tools",
    "Irrigation & Water Management",
    "Livestock & Dairy Farming",
    "Organic Farming Products"
  ];

  final List<String> _rating = [
    "1 Star",
    "2 Star",
    "3 Star",
    "4 Star & above",
  ];

  final List<int> _selectedIndex = [];
  // final List<int> _selectedRatingIndex = [];
  int selectedRatingIndex = 0;

  bool _filterStock = true;

  RangeValues _rangeValues = RangeValues(10, 12000);

  Widget categoryBox(String text,{VoidCallback ? onTap,bool isActive=false}) => Container(
    height: 40,
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Ink(
          padding: const EdgeInsets.only(left: 10,right: 10,top: 8,bottom: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.green.shade300
            ),
          ),
          child: Text(text,textAlign: TextAlign.center,style: TextStyle(
            color: isActive ? Colors.green : null
          ),),
        ),
      ),
    ),
  );
  
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider.value(
      value: widget.provider,
      child: Container(
        width: maxW,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              Text("Categorys",style: TextStyle(fontSize: 17),),
              const SizedBox(height: 15,),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(_categorys.length, (index){
          
                  return categoryBox(
                    _categorys[index],
                    isActive: _selectedIndex.contains(index),
                    onTap: (){
                      if(_selectedIndex.contains(index)){
                        _selectedIndex.remove(index);
                      }else{
                        _selectedIndex.add(index);
                      }
                      setState(() {
                      });
                    },
                  );
                }),
              ),
          
          
              const SizedBox(height: 20,),
              Text("Price",style: TextStyle(fontSize: 17),),
              const SizedBox(height: 15,),
              RangeSlider(
                values: _rangeValues, 
                max: 30000,
                min: 10,
                labels: RangeLabels(
                  _rangeValues.start.toString(), 
                  _rangeValues.end.toString()
                ),
                onChanged: (value) {
                  setState(() {
                    _rangeValues = value;
                  });
                },
              ),
          
          
              const SizedBox(height: 15,),
              Text("Rating",style: TextStyle(fontSize: 17),),
              const SizedBox(height: 15,),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(_rating.length, (index){
          
                  return categoryBox(
                    _rating[index],
                    isActive: selectedRatingIndex == index,
                    // isActive: _selectedRatingIndex.contains(index),
                    onTap: (){
                        selectedRatingIndex = index;
                      // if(_selectedRatingIndex.contains(index)){
                      //   // _selectedRatingIndex.remove(index);
                      //   selectedRatingIndex = index;
                      // }else{
                      //   _selectedRatingIndex.add(index);
                      // }
                      setState(() {
                      });
                    },
                  );
                }),
              ),
          
          
              const SizedBox(height: 15,),
              Text("Order & Availability",style: TextStyle(fontSize: 17),),
              const SizedBox(height: 15,),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  categoryBox(
                    "In Stock",
                    isActive: _filterStock,
                    onTap: () {
                      setState(() {
                        _filterStock = !_filterStock;
                      });
                    },
                  ),
                  categoryBox(
                    "Out of Stock",
                    isActive: !_filterStock,
                    onTap: () {
                      setState(() {
                        _filterStock = !_filterStock;
                      });
                    },
                  ),
                ],
              ),
          
              const SizedBox(height: 20,),
              SizedBox(
                width: maxW,
                height: 40,
                child: ElevatedButton(
                  child: Text("Apply Filter"),
                  onPressed: (){

                    widget.provider.category = List.generate(_selectedIndex.length, (index) => _categorys[_selectedIndex[index]]);
                    widget.provider.price = _rangeValues;
                    widget.provider.rating = selectedRatingIndex;

                    // print(widget.provider.category);
                    // print(widget.provider.price);
                    // print(widget.provider.rating);
                    widget.provider.switchMode(value: true);

                  }, 
                ),
              ),
              const SizedBox(height: 10,),
              
            ],
          ),
        ),
      ),
    );
  }
}