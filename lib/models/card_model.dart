import 'package:equatable/equatable.dart';

class CardModel extends Equatable {
  final int id;
  final int idProduct;
  final String title;
  final num price;
  final String description;
  final String category;
  final String image;
  final int quantity;
  final String dataTime;

  const CardModel({
    required this.id,
    required this.idProduct,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.image,
    required this.quantity,
    required this.dataTime,
  });

  factory CardModel.fromMap(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'],
      idProduct: json['productId'],
      title: json['title'],
      price: json['price'],
      description: json['desc'],
      category: json['category'],
      image: json['image'],
      quantity: json['quantity'],
      dataTime: json['dataTime'],
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      idProduct,
      title,
      price,
      description,
      category,
      image,
      quantity,
      dataTime,
    ];
  }
}
