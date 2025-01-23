class Categoria {
  int? categoriaId;
  String descricao;

  Categoria({this.categoriaId, required this.descricao});

  @override
  String toString() {
    return categoriaId.toString() + descricao;
  }
}
