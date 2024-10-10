// Importa o pacote material do Flutter para acessar widgets padrão.
import 'package:flutter/material.dart';

// Define a tela de resultado como um StatelessWidget, já que não necessita de estado mutável.
class ResultScreen extends StatelessWidget {
  final double celsius; // Temperatura em Celsius recebida da tela anterior.
  final String targetUnit; // Unidade de destino selecionada pelo usuário.

  // Construtor que recebe os parâmetros necessários para a conversão.
  const ResultScreen(
      {super.key, required this.celsius, required this.targetUnit});

  // Função que realiza a conversão de temperatura com base na unidade de destino.
  double _convertTemperature() {
    if (targetUnit == 'Fahrenheit') {
      return (celsius * 9 / 5) +
          32; // Se a unidade de destino é Fahrenheit, aplica a fórmula correspondente.
    } else if (targetUnit == 'Kelvin') {
      return celsius +
          273.15; // Se a unidade de destino é Kelvin, aplica a fórmula correspondente.
    }
    return celsius; // Retorna Celsius se nenhuma unidade válida for selecionada (caso padrão).
  }

  @override
  Widget build(BuildContext context) {
    double result =
        _convertTemperature(); // Chama a função de conversão e armazena o resultado.

    // Retorna a estrutura básica da tela com AppBar e corpo.
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Resultado da Conversão'), // Define o título na barra superior.
      ),
      body: Center(
        // Centraliza o conteúdo tanto horizontal quanto verticalmente.
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          // Adiciona espaçamento ao redor do conteúdo.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // Centraliza os widgets verticalmente.
            children: [
              // Exibe a temperatura original em Celsius formatada com duas casas decimais.
              Text(
                '${celsius.toStringAsFixed(2)} °C =',
                // Formata o número com duas casas decimais.
                style:
                    const TextStyle(fontSize: 24), // Define o tamanho da fonte.
              ),
              const SizedBox(height: 8.0),
              // Espaçamento vertical entre os widgets.

              // Exibe o resultado da conversão com a unidade correta.
              Text(
                '${result.toStringAsFixed(2)} ${targetUnit == 'Kelvin' ? 'K' : '°F'}',
                // Formata o resultado com duas casas decimais e adiciona a unidade apropriada.
                style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold), // Define o estilo do texto.
              ),
              const SizedBox(height: 24.0),
              // Espaçamento vertical entre os widgets.

              // Botão para voltar à tela de entrada e converter outra temperatura.
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                // Volta para a tela anterior quando pressionado.
                child: const Text(
                    'Converter Outra Temperatura'), // Texto exibido no botão.
              ),
            ],
          ),
        ),
      ),
    );
  }
}
