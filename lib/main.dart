import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:takasukonomuro/business/repositories/FuncionarioRepository.dart';
import 'package:takasukonomuro/MyApp.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:takasukonomuro/business/repositories/interfaces/IFuncionarioRepository.dart';
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
}

final supabase = Supabase.instance.client;
