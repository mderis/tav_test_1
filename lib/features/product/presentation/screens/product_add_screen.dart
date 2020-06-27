import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tavtestproject1/core/localization/lz.dart';
import 'package:tavtestproject1/features/product/data/models/product_model.dart';
import 'package:tavtestproject1/features/product/presentation/bloc/bloc.dart';
import 'package:tavtestproject1/route_generator.dart';

class ProductAddScreen extends StatefulWidget {
  bool editMode;
  ProductModel productModel;

  ProductAddScreen.add(ProductAddArgs addArgs) {
    editMode = false;
    this.productModel = ProductModel(
        name: "",
        imagePath: null,
        price: 0,
        oldPrice: null,
        count: 0,
        countInCart: 0,
        isFavorite: false);
  }

  ProductAddScreen.edit(ProductEditArgs editArgs) {
    editMode = true;
    this.productModel = editArgs.productModel;
  }

  @override
  _ProductAddScreenState createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  ProductBloc _productBloc;

  @override
  void initState() {
    super.initState();
    _productBloc = BlocProvider.of<ProductBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.editMode ? translate(Lz.Product_Edit_Product_Title) : translate(Lz.Product_Add_Product_Title)),
        actions: <Widget>[
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                if (widget.productModel.name.isEmpty) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(translate(Lz.Dialog_Text_Fill_All_Fields)),
                  ));
                  return;
                }
                if (widget.editMode)
                  _productBloc.add(EditProductEvent(widget.productModel));
                else
                  _productBloc.add(AddProductEvent(widget.productModel));
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        bloc: _productBloc,
        builder: (ctx, state) {
          return Container(
              padding: EdgeInsets.all(32),
              child: ListView(
                children: <Widget>[
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      InkWell(
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: CircleAvatar(
                            backgroundImage:
                                widget.productModel.imagePath == null
                                    ? AssetImage(
                                        "assets/images/default_product.png")
                                    : FileImage(
                                        File(widget.productModel.imagePath)),
                            radius: 15,
                          ),
                        ),
                        onTap: () async {
                          final pickedFile = await ImagePicker()
                              .getImage(source: ImageSource.gallery);
                          setState(() {
                            widget.productModel.imagePath = pickedFile.path;
                          });
                        },
                      ),
                      Positioned(
                        left: 0,
                        right: 150,
                        bottom: 0,
                        child: FlatButton(
                          onPressed: () {
                            setState(() {
                              widget.productModel.imagePath = null;
                            });
                            ;
                          },
                          color: Theme.of(context)
                              .primaryColorLight
                              .withOpacity(.5),
                          child: Icon(
                            Icons.delete,
                            color: Colors.blue[800],
                            size: 32,
                          ),
                          padding: EdgeInsets.all(0),
                          shape: CircleBorder(),
                        ),
                      )
                    ],
                  ),
                  new TextFormField(
                    initialValue: widget.productModel.name,
                    decoration: new InputDecoration(labelText: translate(Lz.General_Name)),
                    maxLength: 20,
                    onChanged: (text) {
                      widget.productModel.name = text;
                    },
                  ),
                  new TextFormField(
                    initialValue: widget.productModel.price.toString(),
                    decoration: new InputDecoration(labelText: translate(Lz.General_Price)),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                    //
                    onChanged: (text) {
                      widget.productModel.price =
                          text.isEmpty ? 0 : int.parse(text);
                    }, // Only numbers can be entered
                  ),
                  new TextFormField(
                    initialValue: widget.productModel.oldPrice == null
                        ? ""
                        : widget.productModel.oldPrice.toString(),
                    decoration: new InputDecoration(labelText: translate(Lz.General_Old_Price)),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                    //
                    onChanged: (text) {
                      widget.productModel.oldPrice =
                          text.isEmpty ? null : int.parse(text);
                    }, // Only numbers can be entered
                  ),
                  new TextFormField(
                    initialValue: widget.productModel.count.toString(),
                    decoration: new InputDecoration(labelText: translate(Lz.General_Count)),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                    //
                    onChanged: (text) {
                      widget.productModel.count =
                          text.isEmpty ? 0 : int.parse(text);
                    }, // Only numbers can be entered
                  ),
                ],
              ));
        },
      ),
    );
  }
}
