import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ProductModel extends Equatable {
  int id;
  String name;
  String description;
  int price;

  @override
  List<Object> get props => [id, name, description, price];

  ProductModel(
      {this.id,
      @required this.name,
      @required this.description,
      @required this.price});

  static ProductModel fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description, 'price': price};
  }
}
