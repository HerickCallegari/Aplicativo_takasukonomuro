import 'package:takasukonomuro/models/transacao.dart';

abstract class ITransacaoRepository {
  Future<void> add(Transacao transacao);
  Future<void> update(Transacao transacao);
  Future<void> remove(Transacao transacao);
  Future<List<Transacao>> findAll();
  Future<Transacao?> findBy(String id);
}
