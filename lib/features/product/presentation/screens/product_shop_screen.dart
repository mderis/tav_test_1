import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tavtestproject1/core/localization/lz.dart';
import 'package:tavtestproject1/core/widgets/drawer.dart';
import 'package:tavtestproject1/features/product/presentation/bloc/bloc.dart';
import 'package:tavtestproject1/features/product/presentation/screens/widgets/product_shop_item.dart';

class ProductShopScreen extends StatefulWidget {
  @override
  _ProductShopScreenState createState() => _ProductShopScreenState();
}

ProductBloc _productBloc;

class _ProductShopScreenState extends State<ProductShopScreen> {
  @override
  void initState() {
    super.initState();
    _productBloc = BlocProvider.of<ProductBloc>(context);
    _productBloc.add(GetAllProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: _getAppBar(),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 24,
          ),
          _getTabBar(),
          Flexible(flex: 1, child: _getProductList()),
        ],
      ),
      drawer: MainDrawer('/product/shop'),
      backgroundColor: Color.fromRGBO(239, 239, 239, 1),
    );
  }

  AppBar _getAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Builder(
        builder: (context){
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.gripLines,
                  color: Color.fromRGBO(105, 101, 95, 1),
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
              IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.shoppingCart,
                  color: Color.fromRGBO(105, 101, 95, 1),
                ),
                onPressed: () {},
              ),
              // Your widgets here
            ],
          );
        },
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: BlocBuilder<ProductBloc, ProductState>(
            bloc: _productBloc,
            builder: (context, state) {
              return Container(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                child: TextFormField(
                  autofocus: false,
                  onChanged: (value) {
                    if (state is ProductListLoadingState) return;
                    _productBloc.add(SearchProductsEvent(value));
                  },
                  decoration: InputDecoration(
                    hintText: translate(Lz.General_Search),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(105, 101, 95, 1),
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(188, 186, 184, 1),
                        width: 1.0,
                      ),
                    ),
                    prefixIcon: Icon(Icons.search,
                        color: Color.fromRGBO(125, 121, 116, 1), size: 24),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _getTabBar() {
    return DefaultTabController(
      length: 8,
      child: TabBar(
        indicatorColor: Color.fromRGBO(96, 91, 85, 1),
        unselectedLabelColor: Color.fromRGBO(182, 180, 177, 1),
        labelColor: Color.fromRGBO(96, 91, 85, 1),
        isScrollable: true,
        labelStyle:
            TextStyle(color: Color.fromRGBO(96, 91, 85, 1), fontSize: 18),
        tabs: [
          Tab(
            text: "FOOD",
          ),
          Tab(
            text: "TECHNOLOGY",
          ),
          Tab(
            text: "INDUSTRY",
          ),
          Tab(
            text: "MEDITATION",
          ),
          Tab(
            text: "STRATEGY",
          ),
          Tab(
            text: "NAVBAR",
          ),
          Tab(
            text: "MOBILE",
          ),
          Tab(
            text: "ACCESSORY",
          ),
        ],
      ),
    );
  }

  Widget _getProductList() {
    return BlocBuilder<ProductBloc, ProductState>(
      bloc: _productBloc,
      condition: (oldState, newState) =>
          newState is ProductListLoadedState ||
          newState is ProductListLoadingState ||
          newState is ProductListEmptyState,
      builder: (context, state) {
        if (state is ProductListLoadedState) {
          if (state.productList.length == 0) {
            //  Empty list widget
            return Stack(
              children: <Widget>[
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/no_product.png',
                          height: 200,
                          width: 200,
                        ),
                        Text(
                          translate(Lz.Product_Empty_List_Message),
                          style: TextStyle(color: Colors.black26),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            //  List with data
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: GridView.builder(
                itemCount: state.productList.length,
                padding: EdgeInsets.all(24),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    childAspectRatio: 0.8),
                itemBuilder: (BuildContext context, int index) {
                  return ProductShopItem(state.productList[index]);
                },
              ),
            );
          }
        } else if (state is ProductListLoadingState) {
          //  Loading widget
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          //  Unexpected Error
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
}
