import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tavtestproject1/bloc/bloc.dart';
import 'package:tavtestproject1/objects/product_model.dart';
import 'package:tavtestproject1/route_generator.dart';

class AddScreen extends StatefulWidget {
  bool editMode;
  ProductModel productModel;

//  AddScreen.add(AddArgs addArgs) {
//    editMode = false;
//    this.productModel = ProductModel(name: "", description: "", price: 0);
//  }

//  AddScreen.edit(EditArgs editArgs) {
//    editMode = true;
//    this.productModel = editArgs.productModel;
//  }

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
        actions: <Widget>[],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        bloc: _productBloc,
        builder: (ctx, state) {
          return Container(
              padding: EdgeInsets.all(32),
              child: ListView(
                children: <Widget>[
                  new TextField(
                    decoration: new InputDecoration(labelText: "Name"),
                    maxLength: 20,
                    onChanged: (text) {
                      widget.productModel.name = text;
                    },
                  ),
                  new TextField(
                    decoration: new InputDecoration(labelText: "Description"),
                    maxLength: 50,
                    onChanged: (text) {
                      widget.productModel.description = text;
                    },
                  ),
                  new TextField(
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
                ],
              ));
        },
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () {
            if (widget.productModel.name.isEmpty ||
                widget.productModel.description.isEmpty ||
                widget.productModel.price == 0) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("All fields must be filled"),
              ));
              return;
            }
            if (widget.editMode)
              throw UnimplementedError();
            else
              _productBloc.add(AddProductEvent(widget.productModel));
          },
          tooltip: 'Done',
          child: Icon(Icons.done),
        ),
      ),
    );
  }
}
