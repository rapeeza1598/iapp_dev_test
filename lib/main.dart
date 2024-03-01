import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/account_bloc.dart';
import 'screens/form_list.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create:(context) => AccountBloc()..add(LoadAccounts()))],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FormList()
      ),
    );
  }
}
