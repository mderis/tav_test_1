import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tavtestproject1/features/product/data/models/product_model.dart';
import 'package:tavtestproject1/features/product/presentation/bloc/bloc.dart';
import 'package:tavtestproject1/route_generator.dart';

class ProductDetailsScreen extends StatefulWidget {
  String productId;

  ProductDetailsScreen(ProductDetailsArgs args) {
    productId = args.id;
  }

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ProductBloc _productBloc;

  @override
  void initState() {
    super.initState();
    _productBloc = BlocProvider.of<ProductBloc>(context);
    _productBloc.add(GetAllProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      bloc: _productBloc,
      builder: (context, state) {
        if(state is ProductListLoadedState){
          return _buildDetailsWidget(state.productList.firstWhere((element) => element.id == widget.productId));
        }else{
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
    return Container(
      child: Text(productModel.name),
    );
  }
}
