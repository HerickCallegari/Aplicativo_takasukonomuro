import 'package:takasukonomuro/business/repositories/categoriaRepository.dart';
import 'package:takasukonomuro/business/services/Interfaces/iCategoriaService.dart';
import 'package:takasukonomuro/models/categoria.dart';

class Categoriaservice implements ICategoriaService {
  @override
  late CategoriaRepository repository = CategoriaRepository();

  @override
  Future<void> add(Categoria? categoria) async {
    if (categoria == null) {
      throw Exception("Categoria esta null.");
    } else if (categoria.descricao == null || categoria.descricao == '') {
      throw Exception("Categoria sem descrição.");
    }
    try {
      repository.add(categoria);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Categoria>> findAll() async {
    try {
      List<Categoria> Lista = await repository.findAll();
      if (Lista == null) {
        throw Exception("Não foi possivel gerar a Lista de Categorias.");
      }
      return Lista;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Categoria?> findBy(String? id) async {
    if (id == null) {
      throw Exception("Categoria Id esta null.");
    }
    try {
      Categoria? categoria = await repository.findBy(id);
      return categoria;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> remove(Categoria? categoria) async {
    if (categoria == null) {
      throw Exception("Categoria esta null.");
    } else if (categoria.categoriaId == null) {
      throw Exception("Categoria sem Id.");
    }

    try {
      repository.remove(categoria);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(Categoria? categoria) async {
    if (categoria == null) {
      throw Exception("Categoria esta null.");
    } else if (categoria.categoriaId == null) {
      throw Exception("Categoria sem Id.");
    } else if (categoria.descricao == null || categoria.descricao == '') {
      throw Exception("Categoria sem descrição.");
    }

    try {
      repository.update(categoria);
    } catch (e) {
      rethrow;
    }
  }
}
