// ignore_for_file: unnecessary_null_comparison

import 'package:takasukonomuro/business/repositories/interfaces/iCategoriaRepository.dart';
import 'package:takasukonomuro/main.dart';
import 'package:takasukonomuro/models/categoria.dart';

class CategoriaRepository implements ICategoriaRepository {
  @override
  Future<void> add(Categoria categoria) async {
    try {
      await supabase.from('Categorias').insert([
        {
          // 'CategoriaId' será auto incremental no banco de dados
          'Descricao': categoria.descricao
        }
      ]);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Categoria>> findAll() async {
    try {
      var responseList = await supabase.from("Categorias").select('*');
      List<Categoria> Categorias = [];

      for (var response in responseList) {
        if (response != null && response is Map<String, dynamic>) {
          Categoria categoria = Categoria(
              categoriaId: response['CategoriaId'],
              descricao: response['Descricao']);

          Categorias.add(categoria);
        }
      }

      return Categorias;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Categoria?> findBy(id) async {
    try {
      var response = await supabase
          .from('Categorias')
          .select('*')
          .eq('CategoriaId', id)
          .single();

      // ignore: unnecessary_type_check
      if (response != null && response is Map<String, dynamic>) {
        Categoria categoria = Categoria(
          categoriaId: response['CategoriaId'],
          descricao: response['Descricao'],
        );
        return categoria;
      } else {
        throw Exception("Dados do funcionário não encontrados.");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(Categoria categoria) async {
    if (Categoria == null) throw Exception("Categoria não pode ser null");

    try {
      await supabase.from('Categorias').update({
        'Descricao': categoria.descricao,
      }).eq('CategoriaId', categoria.categoriaId.toString());
    } catch (e) {
      rethrow;
    }
  }

  Future<Categoria?> testFetchCategoria() async {
    var response = await supabase.from('Categorias').select().limit(1).single();

    var data = response as Map;
    try {
      if (data != null && data is Map<String, dynamic>) {
        Categoria categoria = Categoria(
          categoriaId: response['CategoriaId'],
          descricao: response['Descricao'],
        );
        return categoria;
      } else {
        throw Exception("Dados do Funcionario nao encontrados");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> remove(Categoria categoria) async {
    try {
      await supabase
          .from('Categorias')
          .delete()
          .eq('CategoriaId', categoria.categoriaId.toString());
    } catch (e) {
      rethrow;
    }
  }
}
