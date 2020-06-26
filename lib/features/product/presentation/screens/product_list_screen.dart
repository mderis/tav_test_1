import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tavtestproject1/features/product/data/models/product_model.dart';
import 'package:tavtestproject1/features/product/presentation/bloc/bloc.dart';
import 'package:tavtestproject1/route_generator.dart';

class ProductListScreen extends StatefulWidget {
  ProductListScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<ProductListScreen> {
  ProductBloc _productBloc;

  bool searchMode = false;

  @override
  void initState() {
    super.initState();
    _productBloc = BlocProvider.of<ProductBloc>(context);
    _productBloc.add(GetAllProductsEvent());
  }

  void _goToAddScreen() {
    Navigator.of(context).pushNamed('/product/add');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
      body: _getProductList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToAddScreen,
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _getProductList() {
    return BlocBuilder<ProductBloc, ProductState>(
      bloc: _productBloc,
      builder: (context, state) {
        if (state is ProductListLoadedState) {
          if (state.productList.length == 0) {
            return Center(
              child: Text(
                "Add a new product from the below",
                style: TextStyle(color: Colors.black26),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: state.productList.length,
              itemBuilder: (BuildContext context, int index) {
                return _getProductItem(state.productList, index);
              },
            );
          }
        } else if (state is ProductListLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
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

  Widget _getProductItem(List<ProductModel> productList, int index) {
    ProductModel product = productList[index];
    return Card(
      child: Dismissible(
        key: Key(product.id),
        child: ListTile(
          leading: Hero(
            tag: product.id + "image",
            child: CircleAvatar(
              backgroundImage: product.imagePath == null
                  ? AssetImage("assets/images/default_product.png")
                  : FileImage(File(product.imagePath)),
            ),
          ),
          title: Text(product.name),
          subtitle: Text(product.count > 0
              ? "Count: " + product.count.toString()
              : "FINISHED!"),
          trailing: Text(
              product.price > 0 ? product.price.toString() + "\$" : "FREE"),
          onTap: () {
            Navigator.pushNamed(context, '/product/details',
                arguments: ProductDetailsArgs(product.id));
          },
        ),
        background: Container(
          color: Colors.red,
          child: Icon(Icons.delete),
        ),
        secondaryBackground: Container(
          color: Colors.blue,
          child: Icon(Icons.edit),
        ),
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.startToEnd) {
            //  Handle delete confirmation
            final bool res = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text(
                        "Are you sure you want to delete ${product.name}?"),
                    actions: <Widget>[
                      FlatButton(
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      FlatButton(
                        child: Text(
                          "Delete",
                          style: TextStyle(color: Colors.red),
                        ),
                        onPressed: () {
                          _productBloc.add(DeleteProductEvent(product));
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                });
            return res;
          } else if (direction == DismissDirection.endToStart) {
            Navigator.pushNamed(context, '/product/edit',
                arguments: ProductEditArgs(product));

            return false;
          }
          return false;
        },
        onDismissed: (direction) {
          if (direction == DismissDirection.startToEnd) {
            //  Handle delete

          } else if (direction == DismissDirection.endToStart) {
            //  Handle Edit
          }
        },
      ),
    );
  }

  getAppBar(BuildContext context) {
    if (searchMode)
      return AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: BlocBuilder<ProductBloc, ProductState>(
              bloc: BlocProvider.of<ProductBloc>(context),
              builder: (context, state) {
                return TextFormField(
                  onChanged: (value) {
                    if (state is ProductListLoadingState) return;
                    _productBloc.add(SearchProductsEvent(value));
                  },
                  autofocus: true,
                  decoration: InputDecoration(
                      hintText: "Search ...",
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            searchMode = false;
                            _productBloc.add(GetAllProductsEvent());
                          });
                        },
                      )),
                );
              }));
    else
      return AppBar(
        automaticallyImplyLeading: false,
        title: Text("Products list"),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {
                  searchMode = true;
                });
              }),
        ],
      );
  }
}
