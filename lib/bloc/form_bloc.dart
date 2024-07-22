import 'form_event.dart';
import 'form_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormBloc extends Bloc<FormEvent, ProductFormState> {
  FormBloc() : super(const ProductFormState()) {
    on<FormNameChanged>(_onNameChanged);
    on<FormEmailChanged>(_onEmailChanged);
    on<FormPhoneChanged>(_onPhoneChanged);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onNameChanged(FormNameChanged event, Emitter<ProductFormState> emit) {
    emit(state.copyWith(
        name: event.name,
        isValid: _isFormValid(event.name, state.email, state.phone)));
  }

  void _onEmailChanged(FormEmailChanged event, Emitter<ProductFormState> emit) {
    emit(state.copyWith(
        email: event.email,
        isValid: _isFormValid(state.name, event.email, state.phone)));
  }

  void _onPhoneChanged(FormPhoneChanged event, Emitter<ProductFormState> emit) {
    emit(state.copyWith(
        phone: event.phone,
        isValid: _isFormValid(state.name, state.email, event.phone)));
  }

  void _onFormSubmitted(FormSubmitted event, Emitter<ProductFormState> emit) {
    // Handle form submission logic here, e.g., send data to a server
  }

  bool _isFormValid(String name, String email, String phone) {
    return name.isNotEmpty &&
        email.isNotEmpty &&
        phone.isNotEmpty &&
        RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email) &&
        RegExp(r'^\d{10}$').hasMatch(phone);
  }
}
