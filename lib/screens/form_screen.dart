import 'package:flutter/material.dart';
import 'package:infoware/bloc/form_bloc.dart';
import 'package:infoware/bloc/form_event.dart';
import 'package:infoware/bloc/form_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// lib/screens/form_screen.dart

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  String _gender = 'Male';
  final List<String> _countries = ['USA', 'Canada', 'Mexico'];
  String _selectedCountry = 'USA';
  final List<String> _states = ['California', 'Texas', 'New York'];
  String _selectedState = 'California';
  final List<String> _cities = ['Los Angeles', 'San Francisco', 'San Diego'];
  String _selectedCity = 'Los Angeles';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FormBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Form')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<FormBloc, ProductFormState>(
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                      onChanged: (value) =>
                          context.read<FormBloc>().add(FormNameChanged(value)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      onChanged: (value) =>
                          context.read<FormBloc>().add(FormEmailChanged(value)),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(labelText: 'Phone'),
                      keyboardType: TextInputType.phone,
                      onChanged: (value) =>
                          context.read<FormBloc>().add(FormPhoneChanged(value)),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !RegExp(r'^\d{10}$').hasMatch(value)) {
                          return 'Please enter a valid phone number';
                        }
                        return null;
                      },
                    ),
                    DropdownButtonFormField<String>(
                      value: _gender,
                      decoration: const InputDecoration(labelText: 'Gender'),
                      items: ['Male', 'Female', 'Other'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _gender = newValue!;
                        });
                      },
                    ),
                    DropdownButtonFormField<String>(
                      value: _selectedCountry,
                      decoration: const InputDecoration(labelText: 'Country'),
                      items: _countries.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedCountry = newValue!;
                        });
                      },
                    ),
                    DropdownButtonFormField<String>(
                      value: _selectedState,
                      decoration: const InputDecoration(labelText: 'State'),
                      items: _states.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedState = newValue!;
                        });
                      },
                    ),
                    DropdownButtonFormField<String>(
                      value: _selectedCity,
                      decoration: const InputDecoration(labelText: 'City'),
                      items: _cities.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedCity = newValue!;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              state.isValid ? Colors.amber : Colors.grey)),
                      onPressed: state.isValid
                          ? () {
                              context.read<FormBloc>().add(FormSubmitted());
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Form submitted')));
                            }
                          : null,
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
