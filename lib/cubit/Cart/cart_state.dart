part of 'cart_cubit.dart';

@immutable
abstract class CartState {
  List<Products>? products;
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<Products> products;
  CartLoaded(this.products);
}

class CartError extends CartState {}
