import 'package:bloc/bloc.dart';
import 'package:learningapp/models/productModels.dart';
import 'package:meta/meta.dart';

import '../../repository/product_repository.dart';
import '../../utils/db_helper.dart';

part 'product_list_state.dart';

class ProductListCubit extends Cubit<ProductListState> {
  ProductListCubit() : super(ProductListInitial());
  final dbHelper = DatabaseHelper.instance;

  // void addProduct(String product) {
  //   final List<String> products = state.products;

  //   products.add(product);
  //   emit(ProductListLoaded(products));
  // }
  Future<void> addToCart(product) async {
    final id = await dbHelper.insert(product, 1);
  }

  void getProduct() async {
    emit(ProductListLoading());
    final List<Products> products = await ProductRepository().getProducts();

    emit(ProductListLoaded(products));
  }
}
