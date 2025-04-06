import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String productId;
  final String name;
  final String description;
  final List<dynamic> image;
  final Map<String,dynamic> price;
  final String unit;
  final double rating;
  final List<dynamic> ratedBy;
  final List<dynamic> detail;
  final String category;
  final String cid,sid; 
  final Map<String,dynamic> offer;
  final Map<String,dynamic> size;
  int buyQty;

  Product({
    required this.productId,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.unit,
    required this.category,
    required this.cid,
    required this.detail,
    required this.offer,
    required this.ratedBy,
    required this.sid,
    required this.rating,
    required this.size,
    this.buyQty=1
  });

  Product.empty({
    this.productId="",
    this.description="",
    this.image=const[],
    this.name="",
    this.price=const{},
    this.rating=0,
    this.unit="",
    this.category="",
    this.cid="",
    this.detail=const[],
    this.offer=const{},
    this.ratedBy=const[],
    this.sid="",
    this.size=const{},
    this.buyQty=1
});

  factory Product.fromSnap(DocumentSnapshot snap,{bool forCart =false}) =>  Product(
    productId: snap.get('pid'),
    description: snap.get('last_descr'),
    name: snap.get('name'),
    image: snap.get('images'),
    price: snap.get('price'),
    rating: double.tryParse(snap.get('rating').toString()) ?? 0,
    ratedBy: snap.get('rated_by'),
    detail: snap.get('detail'),
    category: snap.get('category'),
    offer: snap.get('offer'),
    cid: snap.get('cid'),
    sid: snap.get('sid'),
    size: snap.get('size'),
    buyQty: forCart ? snap.get('buy_qty') ?? 1 : 1,
    unit: ""
  );

  Map<String,dynamic> map({int ? newQty}) => {
    'pid': productId,
    'name': name,
    'last_descr': description,
    'images': image,
    'price': price,
    'rating': rating,
    'rated_by': ratedBy,
    'detail': detail,
    'category': category,
    'offer': offer,
    'cid': cid,
    'sid': sid,
    'size': size,
    'buy_qty': newQty ?? buyQty,
  };

}
