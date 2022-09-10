part of 'product_list_cubit.dart';

@immutable
abstract class ProductListState {
  late List<Products> products;
}

class ProductListInitial extends ProductListState {
  ProductListInitial() {
    products = [];
  }
}

class ProductListLoading extends ProductListState {
  ProductListLoading() {
    products = [];
  }
}

class ProductListLoaded extends ProductListState {
  ProductListLoaded(List<Products> products) {
    this.products = products;
  }
}
