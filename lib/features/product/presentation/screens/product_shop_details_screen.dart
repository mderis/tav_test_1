import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tavtestproject1/features/product/data/models/product_model.dart';
import 'package:tavtestproject1/features/product/presentation/bloc/bloc.dart';
import 'package:tavtestproject1/route_generator.dart';

class ProductShopDetailsScreen extends StatefulWidget {

  ProductModel _productModel;
  ProductShopDetailsScreen(ProductDetailsArgs args){
    _productModel = args.productModel;
  }

  @override
  _ProductShopDetailsScreenState createState() => _ProductShopDetailsScreenState(_productModel);
}

class _ProductShopDetailsScreenState extends State<ProductShopDetailsScreen> {
  ProductBloc _productBloc;
  ProductModel _productModel;

  _ProductShopDetailsScreenState(this._productModel);

  @override
  void initState() {
    super.initState();
    _productBloc = BlocProvider.of<ProductBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductState>(
      bloc: _productBloc,
      listenWhen: (oldState, newState) => newState is ProductLoadedState,
      listener: (context, state) {
        ProductModel newProductModel =
            (state as ProductLoadedState).productModel;
        if (newProductModel.id == _productModel.id)
          setState(() {
            _productModel = newProductModel;
          });
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: _productModel.imagePath == null
                        ? Image.asset(
                      "assets/images/default_product.png",
                      fit: BoxFit.cover,
                      width: double.infinity,
                    )
                        : Image.file(
                      File(_productModel.imagePath),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Text(_productModel.name),
                  )
                ],
              ),
              Positioned(
                top: 20,
                right: 20,
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(228, 227, 225, 1),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: IconButton(
                    icon: Icon(
                      _productModel.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      size: 16,
                      color: Color.fromRGBO(96, 91, 85, 1),
                    ),
                    onPressed: () {
                      _productModel.isFavorite = !_productModel.isFavorite;
                      _productBloc.add(EditProductEvent(_productModel));
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
