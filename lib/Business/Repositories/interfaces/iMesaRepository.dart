import 'package:takasukonomuro/models/Mesa.dart';

abstract class IMesaRepository {
  Future<void> add(Mesa mesa);
  Future<void> update(Mesa mesa);
  Future<List<Mesa>> findAll();
  Future<Mesa?> findBy(String id);
}
