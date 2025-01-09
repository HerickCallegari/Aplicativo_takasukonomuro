import 'package:takasukonomuro/models/mesa.dart';

abstract class IMesaRepository {
  Future<void> add(Mesa mesa);
  Future<void> update(Mesa mesa);
  Future<void> remove(Mesa mesa);
  Future<List<Mesa>> findAll();
  Future<Mesa?> findBy(String id);
}
