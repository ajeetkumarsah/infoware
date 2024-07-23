import 'services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infoware/bloc/product_bloc.dart';
import 'package:infoware/bloc/product_event.dart';
import 'package:infoware/utils/app_constants.dart';
import 'package:infoware/screens/form_screen.dart';
import 'package:infoware/screens/product_screen.dart';
import 'package:infoware/repositories/product_repo.dart';
import 'package:infoware/screens/audio_player_screen.dart';

void main() async {
  final apiService = ApiService(baseUrl: AppConstants.baseUrl);
  final itemRepository = ProductRepository(apiService: apiService);
  runApp(MyApp(itemRepository: itemRepository));
}

class MyApp extends StatelessWidget {
  final ProductRepository itemRepository;

  const MyApp({super.key, required this.itemRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => ProductBloc(itemRepository)..add(FetchProducts()),
        child: const ProductScreen(),
      ),
      routes: {
        '/form': (context) => const FormScreen(),
        '/audio': (context) => const AudioPlayerScreen(),
      },
    );
  }
}
