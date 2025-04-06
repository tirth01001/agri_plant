

class CropDetail {

    final String images;
    final String title;
    final String boxTitle;
    final List<dynamic> boxDescr;

    CropDetail({
        this.boxDescr=const[],
        this.boxTitle="",
        this.title="",
        this.images="",
    });

    factory CropDetail.fromJson(Map<String,dynamic> data) => CropDetail(
        boxTitle: data["nested_title"],
        boxDescr: data["descr"],
        title: data["title"],
        images: data["image"],
    );

}

class CropCareModel {

    final String id;
    final String title;
    final String subtitle;
    final List<CropDetail> widgets;


    CropCareModel({
        required this.id,
        required this.title,
        required this.subtitle,
        required this.widgets,
    });

    factory CropCareModel.fromJson(Map<String,dynamic> data){

        // print (data);
        List<CropDetail> detail = List.generate(data["widgets"].length, (index) => CropDetail.fromJson(data["widgets"][index]));

        return CropCareModel(
            id: data["id"],
            title: data["title"], 
            subtitle: data["subtitle"], 
            widgets: detail, 
        );
    }
  
}