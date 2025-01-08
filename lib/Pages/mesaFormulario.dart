import 'package:flutter/material.dart';
import 'package:takasukonomuro/models/Mesa.dart';

class MesaFormulario extends StatefulWidget {
  final Mesa? mesa;

  const MesaFormulario({super.key, this.mesa});

  @override
  State<MesaFormulario> createState() => _MesaFormularioState();
}

class _MesaFormularioState extends State<MesaFormulario> {
  final TextEditingController _descricaoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Preenche os campos se o objeto Mesa for passado
    if (widget.mesa != null) {
      _descricaoController.text = widget.mesa!.descricao ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.mesa == null ? "Cadastro de Mesa" : "Atualização de Mesa"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Campo de ID
                TextFormField(
                  initialValue: widget.mesa?.mesaId?.toString() ?? '',
                  decoration: const InputDecoration(
                    labelText: "ID da Mesa",
                    border: OutlineInputBorder(),
                    filled: true, // Ativa o preenchimento do fundo
                    fillColor: Color.fromARGB(
                        255, 210, 210, 210), // Cor de fundo cinza
                  ),
                  readOnly: true, // Campo somente leitura
                ),
                const SizedBox(height: 16),

                // Campo de descrição da mesa
                TextFormField(
                  controller: _descricaoController,
                  decoration: const InputDecoration(
                    labelText: "Descrição da Mesa",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),

                // Botões de ação
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Voltar"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final descricao = _descricaoController.text;

                        if (descricao.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Descrição não pode ser vazia!")),
                          );
                          return;
                        }

                        // Salvar ou atualizar a mesa
                        if (widget.mesa == null ||
                            widget.mesa!.mesaId == null) {
                          // Lógica para cadastrar nova mesa
                          print("Cadastrar nova mesa: $descricao");
                        } else {
                          // Lógica para atualizar mesa existente
                          print(
                              "Atualizar mesa ${widget.mesa!.mesaId}: $descricao");
                        }

                        Navigator.pop(context);
                      },
                      child: const Text("Salvar"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _descricaoController.dispose();
    super.dispose();
  }
}
