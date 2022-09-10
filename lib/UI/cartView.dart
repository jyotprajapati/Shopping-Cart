import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/Cart/cart_cubit.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final _cubit = CartCubit();
  @override
  void initState() {
    // TODO: implement initState
    _cubit.getCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("My Cart")),
      ),
      bottomSheet: BlocBuilder<CartCubit, CartState>(
        bloc: _cubit,
        builder: (context, state) {
          if (state is CartLoaded) {
            int totalItems = state.products == null ? 0 : state.products.length;
            int? totalPrice = 0;
            for (var i = 0; i < totalItems; i++) {
              totalPrice = totalPrice! + state.products[i].price!;
            }

            return BottomSheet(
                builder: (context) {
                  return Container(
                    color: Color(0xFF94CDFF),
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Total Items:    $totalItems"),
                        Text("Grand Total:    $totalPrice"),
                      ],
                    ),
                  );
                },
                onClosing: () {});
          } else {
            return Container();
          }
        },
      ),
      body: BlocBuilder<CartCubit, CartState>(
        bloc: _cubit,
        builder: (context, state) {
          if (state is CartInitial) {
            return Center(
              child: Text("No Products"),
            );
          } else if (state is CartLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CartLoaded) {
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Row(
                    children: [
                      Image.network(
                        state.products[index].featuredImage ?? "",
                        height: 100,
                        width: 100,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(state.products[index].title ?? ""),
                          Text(
                              "Amount : ${state.products[index].price.toString()}"),
                          Text("Quantity: 1"),
                        ],
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
