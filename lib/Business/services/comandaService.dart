import 'package:takasukonomuro/business/repositories/comandaRepository.dart';
import 'package:takasukonomuro/business/repositories/interfaces/iComandaRepository.dart';
import 'package:takasukonomuro/models/comanda.dart';

class Comandaservice implements IComandaRepository {
  @override
  late ComandaRepository repository = ComandaRepository();

  @override
  Future<void> add(Comanda comanda) async {
    if (comanda is Null) {
      throw Exception("Comanda nâo existe");
    } else if (comanda.funcionarioId == null) {
      throw Exception("Comanda sem garçom");
    }
    comanda.data ??= DateTime.now();
    comanda.horarioAbertura ??= DateTime.now();
    comanda.pago ??= false;
    comanda.quantidadePessoas ??= 0;
    comanda.valorTotal ??= 0;
    try {
      repository.add(comanda);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Comanda>> findAll() async {
    List<Comanda>? lista;
    try {
      List<Comanda> lista = await repository.findAll();
    } catch (e) {
      rethrow;
    }
    if (lista == null) {
      throw Exception("Não foi possivel requisitar a lista de comandas");
    }
    return lista;
  }

  @override
  Future<Comanda?> findBy(String id) {
    return repository.findBy(id);
  }

  @override
  Future<void> remove(Comanda comanda) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  Future<void> update(Comanda comanda) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
