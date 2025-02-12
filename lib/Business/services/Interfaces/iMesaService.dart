import 'package:takasukonomuro/business/repositories/mesaRepository.dart';
import 'package:takasukonomuro/models/mesa.dart';

abstract class IMesaService {
  late MesaRepository repository;
  Future<void> add(Mesa? mesa);
  Future<void> update(Mesa? mesa);
  Future<void> remove(Mesa? mesa);
  Future<Mesa?> findBy(String? id);
  Future<List<Mesa>> findAll();
  Future<void> aumentaQuantidadePessoas(int pessoas);
}
