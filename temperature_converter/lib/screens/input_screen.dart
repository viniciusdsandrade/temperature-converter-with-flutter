import 'package:flutter/material.dart'; // Importa os widgets do Flutter.
import 'result_screen.dart'; // Importa a tela de resultado.

class InputScreen extends StatefulWidget {
  const InputScreen({super.key}); // Construtor que aceita uma chave opcional.

  @override
  InputScreenState createState() =>
      InputScreenState(); // Cria o estado associado a este widget.
}

class InputScreenState extends State<InputScreen> {
  final _formKey = GlobalKey<
      FormState>(); // Chave global para identificar o formulário e permitir validação.
  final TextEditingController _tempController =
      TextEditingController(); // Controlador para o campo de entrada de temperatura.
  String _selectedUnit =
      'Fahrenheit'; // Unidade selecionada pelo usuário, iniciando com 'Fahrenheit' como padrão.

  // Função que navega para a tela de resultado após validar o formulário.
  void _navigateToResult(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // Se o formulário é válido, prossegue com a conversão.
      double celsius = double.parse(_tempController
          .text); // Converte o texto digitado em um número do tipo double.

      // Navega para a ResultScreen com uma animação personalizada.
      Navigator.push(
        context,
        PageRouteBuilder(
          // Constrói a nova tela.
          pageBuilder: (context, animation, secondaryAnimation) => ResultScreen(
            celsius: celsius,
            targetUnit: _selectedUnit,
          ),
          // Define a transição entre as telas.
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = const Offset(
                0.0, 1.0); // Posição inicial (fora da tela, abaixo).
            var end = Offset.zero; // Posição final (no lugar original).
            var curve = Curves.ease; // Curva de animação suave.

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            // Combina o Tween de posição com a curva de animação.

            return SlideTransition(
              position: animation.drive(tween),
              // Aplica a animação de deslize na posição.
              child: child, // O widget filho que será animado (ResultScreen).
            );
          },
        ),
      );
    }
  }

  @override
  void dispose() {
    _tempController
        .dispose(); // Libera o controlador quando o widget for removido da árvore.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Constrói a interface da tela de entrada.
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Conversor de Temperatura'), // Define o título da AppBar.
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // Adiciona espaçamento ao redor do conteúdo.
        child: Form(
          key: _formKey, // Associa o formulário à chave global para validação.
          child: Column(
            children: [
              // Campo de entrada para a temperatura em Celsius.
              TextFormField(
                controller: _tempController,
                // Controlador que gerencia o conteúdo do campo.
                decoration: const InputDecoration(
                  labelText: 'Temperatura em Celsius', // Rótulo do campo.
                  border: OutlineInputBorder(), // Borda do campo.
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                // Define o teclado numérico com opção de decimal.
                validator: (value) {
                  // Função de validação do campo.
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a temperatura'; // Mensagem se o campo estiver vazio.
                  }
                  if (double.tryParse(value) == null) {
                    return 'Por favor, insira um número válido'; // Mensagem se o valor não for um número.
                  }
                  return null; // Retorna null se o valor é válido.
                },
              ),
              const SizedBox(height: 16.0),
              // Espaçamento vertical entre os widgets.

              // Dropdown para seleção da unidade de destino.
              DropdownButtonFormField<String>(
                value: _selectedUnit,
                // Valor atualmente selecionado.
                items: ['Fahrenheit', 'Kelvin']
                    .map((unit) => DropdownMenuItem(
                          value: unit, // Valor da opção.
                          child: Text(unit), // Texto exibido para a opção.
                        ))
                    .toList(),
                // Converte a lista em uma lista de DropdownMenuItem.
                onChanged: (value) {
                  // Função chamada quando o usuário seleciona uma opção diferente.
                  setState(() {
                    _selectedUnit = value!; // Atualiza a unidade selecionada.
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Unidade de Destino', // Rótulo do dropdown.
                  border: OutlineInputBorder(), // Borda do campo.
                ),
              ),
              const SizedBox(height: 16.0),
              // Espaçamento vertical.

              // Botão para realizar a conversão.
              ElevatedButton(
                onPressed: () => _navigateToResult(context),
                // Chama a função ao ser pressionado.
                child: const Text('Converter'), // Texto do botão.
              ),
            ],
          ),
        ),
      ),
    );
  }
}
