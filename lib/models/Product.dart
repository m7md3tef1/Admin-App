class Product {
  String? id;
  String? name;
  var price;
  String? Size;
  var imgurl;
  String? Description;
  String? type;
  int? counter = (1);
  Product(
      {this.type,
        this.counter,
        this.name,
        this.price,
        this.id,
        this.Description,
        this.imgurl,
        this.Size});

  Product.fromJson(Map<String, dynamic> json){
    name =json['name'];
    price=json['prise'];
    id=json['id'];
    Description=json['Description'];
    imgurl=json['imgurl'];
    Size=json['size'];
   // type=json['type'];
  }
  Map<String, dynamic>? toMap(){
    return{
      'id': id,
      'name': name,
      'prise': price,
      'Description': Description,
      'size': Size,
      'imgurl': imgurl,
    };
  }
}