import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:tavtestproject1/core/localization/lz.dart';
import 'package:tavtestproject1/features/product/data/models/product_model.dart';
import 'package:tavtestproject1/features/product/presentation/bloc/bloc.dart';
import 'package:tavtestproject1/route_generator.dart';

class ProductDetailsScreen extends StatefulWidget {
  ProductModel _productModel;

  ProductDetailsScreen(ProductDetailsArgs args) {
    _productModel = args.productModel;
  }

  @override
  _ProductDetailsScreenState createState() =>
      _ProductDetailsScreenState(_productModel);
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ProductModel _productModel;
  ProductBloc _productBloc;

  _ProductDetailsScreenState(this._productModel);

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
          _productModel = newProductModel;
        setState(() {});
      },
      builder: (context, state) {
        if (state is ProductLoadedState) {
          return _buildDetailsWidget(_productModel);
        } else {
          return Center(
            child: Text(
              "Something unexpected happened :(",
              style: TextStyle(fontSize: 32, color: Colors.redAccent),
            ),
          );
        }
      },
    );
  }

  Widget _buildDetailsWidget(ProductModel productModel) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              centerTitle: true,
              pinned: true,
              floating: false,
              title: Text(productModel.name),
              expandedHeight: 350,
              flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                tag: productModel.id + "image",
                child: productModel.imagePath == null
                    ? Image.asset(
                        "assets/images/default_product.png",
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        File(productModel.imagePath),
                        fit: BoxFit.cover,
                      ),
              )),
            ),
          ];
        },
        body: _getDetailsList(productModel),
      ),
    );
  }

  Widget _getDetailsList(ProductModel productModel) {
    return Container(
      color: Colors.grey[200],
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 92,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: productModel.price == 0 ? Colors.green : Colors.blue),
            child: productModel.price == 0
                ? Text(
                    translate(Lz.General_Free),
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  )
                : Text(
                    productModel.price.toString() + "\$",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
          ),
          SizedBox(
            height: 48,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(
                child: Text(
                  translate(Lz.General_Delete),
                  style: TextStyle(
                    color: Colors.red[700],
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () async {
                  final bool res = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text(translate(
                              Lz.Dialog_Text_Delete_Confirmation,
                              args: {'name': productModel.name})),
                          actions: <Widget>[
                            FlatButton(
                              child: Text(
                                translate(Lz.General_Cancel),
                                style: TextStyle(color: Colors.black),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            FlatButton(
                              child: Text(
                                translate(Lz.General_Delete),
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () {
                                _productBloc
                                    .add(DeleteProductEvent(productModel));
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });
                },
              ),
              FlatButton(
                child: Text(
                  translate(Lz.General_Edit),
                  style: TextStyle(
                    color: Colors.blue[700],
                    fontSize: 18,
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/product/edit',
                      arguments: ProductEditArgs(productModel));
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _getDetailObject(String key, String value) {
    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(48, 0, 0, 0),
      child: Row(
        children: <Widget>[
          Text(
            key + ":",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.black54),
          ),
          SizedBox(
            width: 12,
          ),
          Text(
            value,
            style: TextStyle(color: Colors.black38),
          ),
        ],
      ),
    );
  }
}
