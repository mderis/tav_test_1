import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ProductModel extends Equatable {
  int id;
  String name;
  String imagePath;
  int price;
  int oldPrice;
  int count;
  int countInCart;
  bool isFavorite;



  @override
  List<Object> get props => [
    id,
    name,
    imagePath,
    price,
    oldPrice,
    count,
    countInCart,
    isFavorite,
  ];

  ProductModel({
    this.id,
    @required this.name,
    @required this.imagePath,
    @required this.price,
    @required this.oldPrice,
    @required this.count,
    @required this.countInCart,
    @required this.isFavorite,
  });

  static ProductModel fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      imagePath: json['imagePath'],
      price: json['price'],
      oldPrice: json['oldPrice'],
      count: json['count'],
      countInCart: json['countInCart'],
      isFavorite: json['isFavorite'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'name' : name,
      'imagePath' : imagePath,
      'price' : price,
      'oldPrice' : oldPrice,
      'count' : count,
      'countInCart' : countInCart,
      'isFavorite' : isFavorite,
    };
  }
}
