import 'package:equatable/equatable.dart';

class ProductFormState extends Equatable {
  final String name;
  final String email;
  final String phone;
  final bool isValid;

  const ProductFormState({
    this.name = '',
    this.email = '',
    this.phone = '',
    this.isValid = false,
  });

  ProductFormState copyWith({
    String? name,
    String? email,
    String? phone,
    bool? isValid,
  }) {
    return ProductFormState(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [name, email, phone, isValid];
}
