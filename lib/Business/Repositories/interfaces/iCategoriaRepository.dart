import 'package:takasukonomuro/models/categoria.dart';

abstract class ICategoriaRepository {
  Future<void> add(Categoria categoria);
  Future<void> update(Categoria categoria);
  Future<void> remove(Categoria categoria);
  Future<List<Categoria>> findAll();
  Future<Categoria?> findBy(String id);
}
