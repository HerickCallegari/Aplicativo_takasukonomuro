import 'package:takasukonomuro/business/repositories/comandaRepository.dart';
import 'package:takasukonomuro/business/repositories/interfaces/iComandaRepository.dart';
import 'package:takasukonomuro/business/services/Interfaces/iComandaService.dart';
import 'package:takasukonomuro/models/comanda.dart';

class ComandaService implements IComandaService {
  @override
  late ComandaRepository repository = ComandaRepository();

  @override
  Future<void> add(Comanda? comanda) async {
    if (comanda == null) {
      throw Exception("Comanda esta null.");
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
      lista = await repository.findAll();
    } catch (e) {
      rethrow;
    }
    if (lista == null) {
      throw Exception("Não foi possivel requisitar a lista de comandas");
    }
    return lista;
  }

  @override
  Future<Comanda?> findBy(String? id) {
    if (id == null || id == '') {
      throw Exception("Id esta null");
    }
    try {
      return repository.findBy(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> remove(Comanda? comanda) async {
    if (comanda == null) {
      throw Exception("Comanda esta null.");
    } else if (comanda.comandaId == null) {
      throw Exception("Comanda não encontrada");
    }
    try {
      repository.remove(comanda);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(Comanda? comanda) async {
    if (comanda == null) {
      throw Exception("Comanda esta null.");
    } else if (comanda.pago == null) {
      throw Exception("Sem informação sobre o pagamento.");
    } else if (comanda.comandaId == null) {
      throw Exception("comanda sem ID.");
    } else if (comanda.data == null) {
      throw Exception("comanda sem data.");
    } else if (comanda.funcionarioId == null) {
      throw Exception("comanda sem Funcionario.");
    } else if (comanda.horarioAbertura == null) {
      throw Exception("comanda sem Horario de Abertura.");
    } else if (comanda.data == null) {
      throw Exception("comanda sem data.");
    } else if (comanda.mesaId == null) {
      throw Exception("comanda sem Mesa associada.");
    } else if (comanda.quantidadePessoas == null) {
      throw Exception("comanda sem pessoas registradas.");
    } else if (comanda.valorTotal == null) {
      throw Exception("comanda sem valor registrado.");
    }

    try {
      repository.update(comanda);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Comanda>> findByDate(DateTime? data) {
    if (data == null) {
      throw Exception("Data esta null.");
    }
    try {
      return repository.findByDate(data);
    } catch (e) {
      rethrow;
    }
  }
}
