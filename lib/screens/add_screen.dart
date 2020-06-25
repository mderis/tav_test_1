import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tavtestproject1/bloc/bloc.dart';
import 'package:tavtestproject1/objects/product_model.dart';
import 'package:tavtestproject1/route_generator.dart';

class AddScreen extends StatefulWidget {
  bool editMode;
  ProductModel productModel;

  AddScreen.add(AddArgs addArgs) {
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

  AddScreen.edit(EditArgs editArgs) {
    editMode = true;
    this.productModel = editArgs.productModel;
  }

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
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
        title: Text(widget.editMode ? "Edit product" : "Add product"),
        actions: <Widget>[
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                if (widget.productModel.name.isEmpty) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("All fields must be filled"),
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
                  new TextFormField(
                    initialValue: widget.productModel.name,
                    decoration: new InputDecoration(labelText: "Name"),
                    maxLength: 20,
                    onChanged: (text) {
                      widget.productModel.name = text;
                    },
                  ),
                  new TextFormField(
                    initialValue: widget.productModel.price.toString(),
                    decoration: new InputDecoration(labelText: "Price"),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly,
                    ], //
                    onChanged: (text) {
                      widget.productModel.price =
                          text.isEmpty ? 0 : int.parse(text);
                    }, // Only numbers can be entered
                  ),
                  new TextFormField(
                    initialValue: widget.productModel.oldPrice == null? "": widget.productModel.oldPrice.toString(),
                    decoration: new InputDecoration(labelText: "Old price"),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly,
                    ], //
                    onChanged: (text) {
                      widget.productModel.oldPrice =
                          text.isEmpty ? null : int.parse(text);
                    }, // Only numbers can be entered
                  ),
                  new TextFormField(
                    initialValue: widget.productModel.count.toString(),
                    decoration: new InputDecoration(labelText: "Count"),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly,
                    ], //
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
