import 'package:takasukonomuro/business/repositories/categoriaRepository.dart';
import 'package:takasukonomuro/models/categoria.dart';

abstract class ICategoriaService {
  CategoriaRepository repository;
  Future<void> add(Categoria? categoria);
  Future<void> update(Categoria? categoria);
  Future<void> remove(Categoria? categoria);
  Future<Categoria?> findBy(String? id);
  Future<List<Categoria>> findAll();
}
