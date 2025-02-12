import 'package:takasukonomuro/business/repositories/ItemSubComandaRepository.dart';
import 'package:takasukonomuro/models/itemSubComanda.dart';

abstract class IItemSubComandaService {
  late ItemSubComandaRepository repository;
  Future<void> add(ItemSubComanda? itemsubcomanda);
  Future<void> update(ItemSubComanda? itemsubcomanda);
  Future<void> remove(ItemSubComanda? itemsubcomanda);
  Future<ItemSubComanda?> findBy(String? id);
  Future<List<ItemSubComanda>> findAll();
}
