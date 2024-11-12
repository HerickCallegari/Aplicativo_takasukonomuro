import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:takasukonomuro/Business/Repositories/FuncionarioRepository.dart';
import 'package:takasukonomuro/MyApp.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:takasukonomuro/models/Enums/Cargo.dart';
import 'package:takasukonomuro/models/Funcionario.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: 'assets/Dev.env');

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(const MyApp());

  /* // teste de conexao com o banco
  FuncionarioRepository repository = FuncionarioRepository();

  var funcionario = await repository.testFetchFuncionario();

  print(funcionario);
  */
}

final supabase = Supabase.instance.client;
