import 'package:bloc/bloc.dart';
import 'package:learningapp/models/productModels.dart';
import 'package:meta/meta.dart';

import '../../repository/product_repository.dart';
import '../../utils/db_helper.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  final dbHelper = DatabaseHelper.instance;

  void getCart() async {
    emit(CartLoading());
    final allRows = await dbHelper.queryAllRows();
    List<Products> cartProducts = [];
    allRows.forEach((row) => cartProducts.add(Products.fromJson(row)));
    emit(CartLoaded(cartProducts));
  }
}
