import '../services/api_service.dart';
import 'package:infoware/models/product_model.dart';

class ProductRepository {
  final ApiService apiService;

  ProductRepository({required this.apiService});

  Future<List<ProductModel>> fetchProducts() async {
    final List<dynamic> data = await apiService.fetchItems();
    return data.map((json) => ProductModel.fromJson(json)).toList();
  }
}
