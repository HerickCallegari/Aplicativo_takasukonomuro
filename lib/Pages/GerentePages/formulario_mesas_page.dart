import 'package:flutter/material.dart';
import 'package:takasukonomuro/business/services/mesaService.dart';
import 'package:takasukonomuro/models/mesa.dart';
import 'package:takasukonomuro/models/enums/status.dart';

class FormularioMesasPage extends StatefulWidget {
  final Mesa? mesa;

  // Construtor para permitir edição ou criação de mesa
  FormularioMesasPage({this.mesa});

  @override
  _FormularioMesasPageState createState() => _FormularioMesasPageState();
}

class _FormularioMesasPageState extends State<FormularioMesasPage> {
  final _formKey = GlobalKey<FormState>();
  final _descricaoController = TextEditingController();
  String? _statusSelecionado;

  final List<String> statusOptions = [
    'Disponível',
    'Ocupada',
    'Reservada',
  ];

  // Variável para saber se estamos editando ou criando uma nova mesa
  late bool _isEdit;

  @override
void initState() {
  super.initState();
  if (widget.mesa != null) {
    _isEdit = true;
    _descricaoController.text = widget.mesa!.descricao;
    _statusSelecionado = widget.mesa!.getStatus();

    // Garantir que o valor de _statusSelecionado seja um dos valores válidos
    if (!statusOptions.contains(_statusSelecionado)) {
      _statusSelecionado = statusOptions[0]; // Se não for válido, coloca um valor padrão
    }
  } else {
    _isEdit = false;
    _statusSelecionado = statusOptions[0]; // Definindo um valor padrão para novo registro
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    _isEdit ? 'Editar Mesa' : 'Cadastro de Mesa',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.red,
                  child: Text(
                    'M',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
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
                image: AssetImage('assets/images/formularioMesasFundo.png'),
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
                    _buildTextField(_descricaoController, 'Descrição*', 'Digite a descrição da mesa'),
                    SizedBox(height: 20),
                    _buildDropdown(),
                    SizedBox(height: 20),
                    _buildButtons(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, String hint) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
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

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      value: _statusSelecionado,
      onChanged: (String? newValue) {
        setState(() {
          _statusSelecionado = newValue;
        });
      },
      decoration: InputDecoration(
        labelText: 'Status*',
        labelStyle: TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      ),
      items: statusOptions.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, selecione um status.';
        }
        return null;
      },
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancelar', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState?.validate() ?? false) {
              try {
                // Se for edição, atualiza a mesa, caso contrário cria uma nova
                if (_isEdit) {
                  Mesa updatedMesa = Mesa(
                    mesaId: widget.mesa!.mesaId,  // ID da mesa para edição
                    descricao: _descricaoController.text,
                    status: _getStatusFromString(_statusSelecionado!),  // Converte a string em Status
                  );
                  await MesaService().update(updatedMesa);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Mesa atualizada com sucesso!")));
                } else {
                  Mesa newMesa = Mesa(
                    descricao: _descricaoController.text,
                    status: _getStatusFromString(_statusSelecionado!),  // Converte a string em Status
                  );
                  await MesaService().add(newMesa);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Mesa cadastrada com sucesso!")));
                }
                Navigator.pop(context);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Erro ao salvar a mesa. Tente novamente!")));
              }
            }
          },
          child: Text('Salvar', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }

  // Função para converter o status string para o enum Status
  Status _getStatusFromString(String status) {
    switch (status) {
      case 'Disponível':
        return Status.Livre;
      case 'Ocupada':
        return Status.Ocupado;
      case 'Reservada':
        return Status.Reservado;
      default:
        return Status.Livre;  // Valor padrão
    }
  }
}
