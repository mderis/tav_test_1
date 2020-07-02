import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/global.dart';
import 'package:tavtestproject1/core/localization/lz.dart';
import 'package:tavtestproject1/core/widgets/drawer.dart';
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
      appBar: _getAppBar(context),
      body: _getProductList(),
      drawer: MainDrawer('/product/list'),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToAddScreen,
        tooltip: translate(Lz.General_Add),
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
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text(
                  translate(Lz.Product_Empty_List_Message),
                  style: TextStyle(color: Colors.black26),
                  textAlign: TextAlign.center,
                ),
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
          subtitle: Row(
            children: <Widget>[
              if (product.oldPrice != null)
                Text(
                  product.oldPrice > 0
                      ? product.oldPrice.toString() + "\$"
                      : "FREE",
                  style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.red[200]),
                ),
              if (product.oldPrice != null)
                SizedBox(
                  width: 12,
                ),
              Text(
                product.price > 0 ? product.price.toString() + "\$" : "FREE",
                style: TextStyle(
                    color: (product.price > 0)
                        ? Colors.blue[400]
                        : Colors.green[400]),
              ),
            ],
          ),
          trailing: Text(product.count > 0
              ? translate(Lz.General_Count) + ": " + product.count.toString()
              : translate(Lz.General_Finished)),
          onTap: () {
            Navigator.pushNamed(context, '/product/details',
                arguments: ProductDetailsArgs(product));
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
                    content: Text(translate(Lz.Dialog_Text_Delete_Confirmation,
                        args: {'name': product.name})),
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

  _getAppBar(BuildContext context) {
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
                  hintText: translate(Lz.General_Search),
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        searchMode = false;
                        _productBloc.add(GetAllProductsEvent());
                      });
                    },
                  ),
                ),
              );
            }),
      );
    else
      return AppBar(
        title: Text(translate(Lz.Product_List_Title)),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {
                  searchMode = true;
                });
              }),
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              }),
        ],
      );
  }
}
