import 'package:takasukonomuro/business/repositories/transacaoRepository.dart';
import 'package:takasukonomuro/models/transacao.dart';

abstract class ITransacaoService {
  late TransacaoRepository repository;
  Future<void> add(Transacao? transacao);
  Future<void> update(Transacao? transacao);
  Future<void> remove(Transacao? transacao);
  Future<Transacao?> findBy(String? id);
  Future<List<Transacao>> findAll();
}
