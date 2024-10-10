import 'package:flutter/material.dart'; // Importa os widgets e material design do Flutter.
import 'screens/input_screen.dart';     // Importa a tela de entrada do aplicativo.

void main() {
  runApp(const TemperaturaConverterApp()); // Função principal que inicia o aplicativo.
}

// Define a classe principal do aplicativo, que é um widget sem estado.
class TemperaturaConverterApp extends StatelessWidget {
  const TemperaturaConverterApp({super.key}); // Construtor da classe, aceita uma chave opcional.

  @override
  Widget build(BuildContext context) {
    // Metodo que constrói a interface do aplicativo.
    return MaterialApp(
      title: 'Conversor de Temperatura', // Título do aplicativo.
      theme: ThemeData.light(),          // Define o tema claro.
      darkTheme: ThemeData.dark(),       // Define o tema escuro.
      themeMode: ThemeMode.system,       // Altera o tema de acordo com as configurações do sistema do dispositivo.
      home: const InputScreen(),         // Define a tela inicial do aplicativo.
      debugShowCheckedModeBanner: false
    );
  }
}
