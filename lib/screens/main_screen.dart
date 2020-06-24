import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tavtestproject1/bloc/bloc.dart';
import 'package:tavtestproject1/objects/product_model.dart';
import 'package:tavtestproject1/route_generator.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  ProductBloc _productBloc;

  @override
  void initState() {
    super.initState();
    _productBloc = BlocProvider.of<ProductBloc>(context);
    _productBloc.add(GetAllProductsEvent());
  }

  void _goToAddScreen() {
    Navigator.of(context).pushNamed('/add');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products list"),
      ),
      body: _getProductList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToAddScreen,
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _getProductList() {
    return BlocBuilder<ProductBloc, ProductState>(bloc: _productBloc,builder: (context, state){
      if(state is ProductListEmptyState){
        return Center(
          child: Text(
            "Add a new product from the below",
            style: TextStyle(color: Colors.black26),
          ),
        );
      }else if (state is ProductListLoadedState){
        return ListView.builder(
          itemCount: state.productList.length,
          itemBuilder: (BuildContext context, int index) {
            return _getProductItem(state.productList, index);
          },
        );
      }else if(state is ProductListLoadingState){
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      else{
        return Center(
          child: Text(
            "Something unexpected happened :(",
            style: TextStyle(fontSize: 32, color: Colors.redAccent),
          ),
        );
      }
    },);
  }

  Widget _getProductItem(List<ProductModel> productList, int index) {
    ProductModel product = productList[index];
    return Card(
      child: ListTile(
        leading: product.imagePath == null ? FlutterLogo(): Image.file(File(product.imagePath)),
        title: Text(product.name),
        subtitle: Text(product.count >0?"Count: " + product.count.toString(): "Finished!"),
        trailing: Text(product.price.toString()),
        onTap: (){},
      ),
    );
  }

}
