class TourModel {
  final String? title;
  final String? price;
  final String? desc;
  final String? image;

  TourModel({this.title, this.price, this.desc, this.image});

  factory TourModel.fromJson(Map<String, dynamic> json) {
    return TourModel(
      title: json['title'],
      price: json['price'],
      desc: json['desc'],
      image: json['image'],
    );
  }
}
