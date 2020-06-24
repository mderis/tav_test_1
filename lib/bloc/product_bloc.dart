import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:tavtestproject1/core/parents/use_case.dart';
import 'package:tavtestproject1/domain/use_cases/add_product_use_case.dart';
import 'package:tavtestproject1/domain/use_cases/get_all_products_use_case.dart';
import 'package:tavtestproject1/objects/product_model.dart';

import './bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {

  final GetAllProductsUseCase _getAllProductsUseCase = GetAllProductsUseCase();
  final AddProductUseCase _addProductUseCase = AddProductUseCase();

  @override
  ProductState get initialState => ProductListEmptyState();

  @override
  Stream<ProductState> mapEventToState(
    ProductEvent event,
  ) async* {
    if (event is GetAllProductsEvent) {
      yield ProductListLoadingState();
      List<ProductModel> productList = await _getAllProductsUseCase(NoParams());
      yield ProductListLoadedState(productList);
    }else if(event is AddProductEvent){
      await _addProductUseCase(Params(event.productModel));
      add(GetAllProductsEvent());
    }
  }
}
