import 'package:flutter/material.dart'; // Importa os widgets do Flutter.

class ResultScreen extends StatelessWidget {
  final double celsius; // Temperatura em Celsius recebida da tela anterior.
  final String targetUnit; // Unidade de destino selecionada pelo usuário.

  const ResultScreen(
      {super.key,
      required this.celsius,
      required this.targetUnit}); // Construtor que recebe os parâmetros necessários.

  // Função que realiza a conversão de temperatura.
  double _convertTemperature() {
    if (targetUnit == 'Fahrenheit') {
      // Se a unidade de destino é Fahrenheit, aplica a fórmula correspondente.
      return (celsius * 9 / 5) + 32;
    } else if (targetUnit == 'Kelvin') {
      // Se a unidade de destino é Kelvin, aplica a fórmula correspondente.
      return celsius + 273.15;
    }
    // Caso contrário, retorna a temperatura em Celsius (padrão).
    return celsius;
  }

  @override
  Widget build(BuildContext context) {
    double result =
        _convertTemperature(); // Chama a função de conversão e armazena o resultado.

    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Resultado da Conversão'), // Define o título da AppBar.
      ),
      body: Center(
        // Centraliza o conteúdo horizontal e verticalmente.
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          // Adiciona espaçamento ao redor do conteúdo.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // Centraliza os widgets verticalmente.
            children: [
              // Exibe a temperatura original em Celsius.
              Text(
                '${celsius.toStringAsFixed(2)} °C =',
                // Formata o número com duas casas decimais.
                style:
                    const TextStyle(fontSize: 24), // Define o tamanho da fonte.
              ),
              const SizedBox(height: 8.0), // Espaçamento vertical.

              // Exibe o resultado da conversão com a unidade correta.
              Text(
                '${result.toStringAsFixed(2)} ${targetUnit == 'Kelvin' ? 'K' : '°F'}',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ), // Define o estilo do texto.
              ),
              const SizedBox(height: 24.0), // Espaçamento vertical.

              // Botão para voltar e converter outra temperatura.
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                // Volta para a tela anterior.
                child: const Text(
                    'Converter Outra Temperatura'), // Texto do botão.
              ),
            ],
          ),
        ),
      ),
    );
  }
}
