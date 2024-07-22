import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infoware/bloc/product_event.dart';
import 'package:infoware/bloc/product_state.dart';
import 'package:infoware/repositories/product_repo.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc(this.productRepository) : super(ProductInitial()) {
    on<FetchProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await productRepository.fetchProducts();
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
  }
}
