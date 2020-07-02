import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tavtestproject1/features/product/data/models/product_model.dart';
import 'package:tavtestproject1/features/product/presentation/bloc/bloc.dart';
import 'package:tavtestproject1/route_generator.dart';

class ProductShopDetailsScreen extends StatefulWidget {
  ProductModel _productModel;

  ProductShopDetailsScreen(ProductDetailsArgs args) {
    _productModel = args.productModel;
  }

  @override
  _ProductShopDetailsScreenState createState() =>
      _ProductShopDetailsScreenState(_productModel);
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
          backgroundColor: Color.fromRGBO(239, 239, 239, 1),
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Color.fromRGBO(96, 91, 85, 1), //change your color here
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: <Widget>[
              Container(
                margin: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(228, 227, 225, 0.6),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: IconButton(
                  icon: Icon(
                    _productModel.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    size: 24,
                    color: Color.fromRGBO(96, 91, 85, 1),
                  ),
                  onPressed: () {
                    _productModel.isFavorite = !_productModel.isFavorite;
                    _productBloc.add(EditProductEvent(_productModel));
                  },
                ),
              )
            ],
          ),
          body: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Expanded(
                      flex: 4,
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(50),
                                bottomRight: Radius.circular(50))),
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
                      )),
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(32, 12, 32, 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            _productModel.name,
                            style: TextStyle(
                                fontFamily: "Geometria",
                                fontSize: 32,
                                color: Color.fromRGBO(78, 74, 71, 1),
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Mate Plate",
                            style: TextStyle(
                                fontFamily: "Geometria",
                                fontSize: 18,
                                color: Color.fromRGBO(114, 109, 104, 1),
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "Colors",
                                style: TextStyle(
                                    fontFamily: "Geometria",
                                    fontSize: 22,
                                    color: Color.fromRGBO(114, 109, 104, 1)),
                              ),
                              SizedBox(
                                width: 60,
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    _getColorBox(
                                        Color.fromRGBO(253, 253, 253, 1)),
                                    _getColorBox(
                                        Color.fromRGBO(231, 208, 186, 1)),
                                    _getColorBox(
                                        Color.fromRGBO(139, 134, 128, 1)),
                                    _getColorBox(
                                        Color.fromRGBO(121, 123, 133, 1)),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Text(
                            "Dinnerware plates keeps heatand allvoluable properties of product.",
                            style: TextStyle(
                                fontFamily: "Geometria",
                                fontSize: 18,
                                color: Color.fromRGBO(114, 109, 104, 1)),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                _productModel.price.toString() + "\$",
                                style: TextStyle(
                                    fontFamily: "Geometria",
                                    fontSize: 36,
                                    color: Color.fromRGBO(78, 74, 71, 1),
                                    fontWeight: FontWeight.bold),
                              ),
                              FlatButton(
                                padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                                child: Text(
                                  "ADD TO CARD",
                                  style: TextStyle(
                                      fontFamily: "Geometria",
                                      fontSize: 20,
                                      color: Color.fromRGBO(78, 74, 71, 1),
                                      fontWeight: FontWeight.bold),
                                ),
                                  color: Colors.white,
                                  shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                onPressed: () {},
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  _getColorBox(Color color) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}
