import 'package:flutter/material.dart'; // Importa o pacote material do Flutter para acessar widgets padrão.
import 'result_screen.dart'; // Importa a tela de resultado para navegação após a conversão.

// Define a tela de entrada como um StatefulWidget para gerenciar seu estado.
class InputScreen extends StatefulWidget {
  final VoidCallback toggleTheme; // Declara um campo final que recebe uma função para alternar o tema.
  const InputScreen({super.key, required this.toggleTheme}); // Construtor que aceita uma função toggleTheme obrigatória.

  @override
  InputScreenState createState() =>
      InputScreenState(); // Cria o estado associado a este widget.
}

// Estado associado ao InputScreen que gerencia a entrada e seleção do usuário.
class InputScreenState extends State<InputScreen> {
  final _formKey = GlobalKey<FormState>(); // Chave global para identificar o formulário e realizar validação.
  final TextEditingController _tempController = TextEditingController(); // Controlador para gerenciar o texto inserido no campo de temperatura.
  String _selectedUnit =  'Fahrenheit'; // Unidade de destino selecionada pelo usuário, padrão 'Fahrenheit'.

  // Função que navega para a tela de resultado após validar o formulário.
  void _navigateToResult(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // Verifica se o formulário é válido.
      double celsius = double.parse(_tempController
          .text); // Converte o texto inserido para um número do tipo double.

      // Navega para a ResultScreen com uma transição personalizada.
      Navigator.push(
        context,
        PageRouteBuilder(
          // Define a tela que será exibida (ResultScreen) e passa os parâmetros necessários.
          pageBuilder: (context, animation, secondaryAnimation) => ResultScreen(
            celsius: celsius, // Passa a temperatura em Celsius.
            targetUnit:
                _selectedUnit, // Passa a unidade de destino selecionada.
          ),
          // Define a animação de transição entre as telas.
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = const Offset(0.0,
                1.0); // Posição inicial da animação (fora da tela, abaixo).
            var end =
                Offset.zero; // Posição final da animação (posição original).
            var curve = Curves.ease; // Curva de animação suave.

            // Define o Tween que descreve a transição da posição inicial para a final.
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            // Aplica a animação de deslize ao widget filho (ResultScreen).
            return SlideTransition(
              position: animation.drive(tween), // Aplica o Tween à animação.
              child: child, // O widget que será animado.
            );
          },
        ),
      );
    }
  }

  @override
  void dispose() {
    _tempController
        .dispose(); // Libera os recursos do controlador quando o widget é removido.
    super.dispose(); // Chama o metodo dispose da classe pai.
  }

  @override
  Widget build(BuildContext context) {
    // Retorna a estrutura básica da tela com AppBar e corpo.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversor de Temperatura'),
        // Define o título na barra superior.
        actions: [
          // Adiciona um botão de ícone na barra superior para alternar o tema.
          IconButton(
            icon: const Icon(Icons.brightness_6),
            // Ícone que representa o botão de tema.
            onPressed: widget
                .toggleTheme, // Chama a função toggleTheme passada pelo widget pai quando pressionado.
          ),
        ],
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
                // Controlador que gerencia o texto inserido.
                decoration: const InputDecoration(
                  labelText: 'Temperatura em Celsius', // Rótulo do campo.
                  border:
                      OutlineInputBorder(), // Define uma borda ao redor do campo.
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                // Define o tipo de teclado para números com opção decimal.
                validator: (value) {
                  // Função de validação que verifica se o valor inserido é válido.
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a temperatura'; // Mensagem de erro se o campo estiver vazio.
                  }
                  if (double.tryParse(value) == null) {
                    return 'Por favor, insira um número válido'; // Mensagem de erro se o valor não for um número válido.
                  }
                  return null; // Retorna null se o valor for válido.
                },
              ),
              const SizedBox(height: 16.0),
              // Espaçamento vertical entre os widgets.

              // Dropdown para selecionar a unidade de destino da conversão.
              DropdownButtonFormField<String>(
                value: _selectedUnit,
                // Valor atualmente selecionado no dropdown.
                items: ['Fahrenheit', 'Kelvin'] // Lista de opções disponíveis.
                    .map((unit) => DropdownMenuItem(
                          value: unit, // Define o valor da opção.
                          child: Text(
                              unit), // Define o texto exibido para a opção.
                        ))
                    .toList(),
                // Converte a lista de strings em uma lista de DropdownMenuItem.
                onChanged: (value) {
                  setState(() {
                    _selectedUnit =
                        value!; // Atualiza a unidade selecionada quando o usuário escolhe uma opção diferente.
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Unidade de Destino', // Rótulo do dropdown.
                  border:
                      OutlineInputBorder(), // Define uma borda ao redor do dropdown.
                ),
              ),
              const SizedBox(height: 16.0),
              // Espaçamento vertical entre os widgets.

              // Botão para realizar a conversão da temperatura.
              ElevatedButton(
                onPressed: () => _navigateToResult(context),
                // Chama a função para navegar para a tela de resultado quando pressionado.
                child: const Text('Converter'), // Texto exibido no botão.
              ),
            ],
          ),
        ),
      ),
    );
  }
}
