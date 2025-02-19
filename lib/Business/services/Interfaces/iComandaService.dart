import 'package:takasukonomuro/business/repositories/comandaRepository.dart';
import 'package:takasukonomuro/models/comanda.dart';

abstract class IComandaService {
  late ComandaRepository repository;
  Future<void> add(Comanda? categoria);
  Future<void> update(Comanda? categoria);
  Future<void> remove(Comanda? categoria);
  Future<Comanda?> findBy(String? id);
  Future<List<Comanda>> findAll();
  Future<List<Comanda>> findByDate(DateTime? data);
}
