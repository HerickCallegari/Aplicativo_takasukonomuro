import 'package:takasukonomuro/business/repositories/transacaoRepository.dart';
import 'package:takasukonomuro/business/services/Interfaces/iTransacaoService.dart';
import 'package:takasukonomuro/models/transacao.dart';

class Transacaoservice implements ITransacaoService {
  @override
  TransacaoRepository repository = TransacaoRepository();

  @override
  Future<void> add(Transacao? transacao) async {
    if (transacao == null) {
      throw Exception("Transação esta null.");
    } else if (transacao.valor == null) {
      throw Exception("Transação valor esta null.");
    } else if (transacao.data == null) {
      throw Exception("Transação data esta null.");
    } else if (transacao.comandaId == null) {
      throw Exception("Transação comanda esta null.");
    } else if (transacao.tipoTransacao == null) {
      throw Exception("Transação tipo esta null.");
    }

    try {
      repository.add(transacao);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Transacao>> findAll() async {
    List<Transacao> lista;

    try {
      lista = await repository.findAll();
    } catch (e) {
      rethrow;
    }

    return lista;
  }

  @override
  Future<Transacao?> findBy(String? id) async {
    if (id == null || id == '') {
      throw Exception("ID esta null.");
    }

    try {
      return repository.findBy(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> remove(Transacao? transacao) async {
    if (transacao == null || transacao.transacaoId == null) {
      throw Exception("Transação esta null.");
    }

    try {
      repository.remove(transacao);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(Transacao? transacao) async {
    if (transacao == null) {
      throw Exception("Transação esta null.");
    } else if (transacao.valor == null) {
      throw Exception("Transação valor esta null.");
    } else if (transacao.data == null) {
      throw Exception("Transação data esta null.");
    } else if (transacao.comandaId == null) {
      throw Exception("Transação comanda esta null.");
    } else if (transacao.tipoTransacao == null) {
      throw Exception("Transação tipo esta null.");
    } else if (transacao.transacaoId == null) {
      throw Exception("Transação ID esta null.");
    }

    try {
      repository.update(transacao);
    } catch (e) {
      rethrow;
    }
  }
}
