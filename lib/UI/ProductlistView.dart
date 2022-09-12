import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learningapp/Services/sqfLiteServices.dart';
import 'package:learningapp/cubit/ProductList/product_list_cubit.dart';
import 'package:sqflite/sqflite.dart';
import '../models/productModels.dart';
import '../utils/db_helper.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({Key? key}) : super(key: key);

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  final _cubit = ProductListCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cubit.getProduct();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Shopping Mall")),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/cart');
              },
              icon: Icon(Icons.shopping_cart)),
        ],
      ),
      body: BlocBuilder<ProductListCubit, ProductListState>(
        bloc: _cubit,
        builder: (context, state) {
          if (state is ProductListInitial) {
            return Center(
              child: Text("No Products"),
            );
          } else if (state is ProductListLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProductListLoaded) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
              ),
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      Flexible(
                        flex: 8,
                        child: Image.network(
                          state.products[index].featuredImage!,
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 8,
                                child: Text(state.products[index].title!),
                              ),
                              Spacer(),
                              Flexible(
                                flex: 2,
                                child: TextButton(
                                  onPressed: () async {
                                    await _cubit
                                        .addToCart(state.products[index]);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Added to cart'),
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.shopping_cart,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text("No Products"),
            );
          }
        },
      ),
    );
  }
}
