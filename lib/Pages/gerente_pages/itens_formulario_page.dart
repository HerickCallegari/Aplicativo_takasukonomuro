import 'package:flutter/material.dart';
import 'package:takasukonomuro/business/services/itemService.dart';
import 'package:takasukonomuro/models/item.dart';

class FormularioItensPage extends StatefulWidget {
  const FormularioItensPage(
      {super.key, this.item}); // Agora aceita um item opcional

  final Item? item; // Pode ser nulo para novos cadastros

  @override
  _FormularioItensPageState createState() => _FormularioItensPageState();
}

class _FormularioItensPageState extends State<FormularioItensPage> {
  final _formKey = GlobalKey<FormState>();
  final _descricaoController = TextEditingController();
  final _precoController = TextEditingController();
  final _estoqueController = TextEditingController();
  final _categoriaController = TextEditingController();
  final ItemService _itemService = ItemService();

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _descricaoController.text = widget.item!.descricao;
      _precoController.text = widget.item!.preco.toString();
      _estoqueController.text = widget.item!.estoque.toString();
      _categoriaController.text = widget.item!.categoriaId.toString();
    }
  }

  @override
  void dispose() {
    _descricaoController.dispose();
    _precoController.dispose();
    _estoqueController.dispose();
    _categoriaController.dispose();
    super.dispose();
  }

  void _salvarItem() async {
    if (_formKey.currentState!.validate()) {
      final novoItem = Item(
        itemId: widget.item?.itemId, // Se for edição, mantém o ID original
        descricao: _descricaoController.text,
        preco: double.parse(_precoController.text),
        estoque: int.parse(_estoqueController.text),
        categoriaId: int.parse(_categoriaController.text),
      );

      try {
        if (widget.item == null) {
          await _itemService.add(novoItem);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Item cadastrado com sucesso!")),
          );
        } else {
          await _itemService.update(novoItem);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Item atualizado com sucesso!")),
          );
        }

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao salvar item: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back,
                      size: 30, color: Colors.black),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(blurRadius: 6, color: Colors.black12)
                      ],
                    ),
                    child: Text(
                      widget.item == null
                          ? 'Cadastro de Produto'
                          : 'Editar Produto',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.account_circle),
                    onPressed: () {},
                    padding: EdgeInsets.zero),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/teste.png'),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
          Center(
            child: Container(
              width: 340,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)],
              ),
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTextField(_descricaoController, 'Descrição*',
                        'Digite a descrição do produto'),
                    SizedBox(height: 20),
                    _buildTextField(
                        _precoController, 'Preço*', 'Digite o preço do produto',
                        keyboardType: TextInputType.number),
                    SizedBox(height: 20),
                    _buildTextField(_estoqueController, 'Estoque*',
                        'Digite a quantidade em estoque',
                        keyboardType: TextInputType.number),
                    SizedBox(height: 20),
                    _buildTextField(_categoriaController, 'Categoria*',
                        'Digite o ID da categoria',
                        keyboardType: TextInputType.number),
                    SizedBox(height: 20),
                    _buildButtons(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, String hint,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: TextStyle(color: Colors.black),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: Colors.white,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, preencha este campo.';
        }
        return null;
      },
    );
  }

  Widget _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancelar', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        ElevatedButton(
          onPressed: _salvarItem,
          child: Text('Salvar', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }
}
