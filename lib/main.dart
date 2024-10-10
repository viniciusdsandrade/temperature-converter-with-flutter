import 'package:flutter/material.dart'; // Importa o pacote material do Flutter, que fornece widgets e temas padrão.
import 'screens/input_screen.dart'; // Importa a tela de entrada que será definida em outro arquivo.

// Função principal que é o ponto de entrada do aplicativo Flutter.
void main() {
  runApp(const TemperaturaConverterApp()); // Inicializa o aplicativo com o widget TemperaturaConverterApp.
}

// Define o widget principal do aplicativo como um StatefulWidget para gerenciar o estado do tema.
class TemperaturaConverterApp extends StatefulWidget {
  const TemperaturaConverterApp({super.key}); // Construtor constante que aceita uma chave opcional.

  @override
  TemperaturaConverterAppState createState() => TemperaturaConverterAppState(); // Cria o estado associado a este widget.
}

// Estado associado ao TemperaturaConverterApp que gerencia o modo de tema.
class TemperaturaConverterAppState extends State<TemperaturaConverterApp> {
  ThemeMode _themeMode = ThemeMode.system; // Variável que armazena o modo de tema atual, iniciando com o modo do sistema.

  // Função que alterna entre os modos de tema claro e escuro.
  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Retorna o widget MaterialApp que configura o aplicativo.
    return MaterialApp(
      title: 'Conversor de Temperatura', // Define o título do aplicativo.
      theme: ThemeData.light(), // Define o tema claro do aplicativo.
      darkTheme: ThemeData.dark(), // Define o tema escuro do aplicativo.
      themeMode: _themeMode, // Aplica o modo de tema atual (claro, escuro ou sistema).
      debugShowCheckedModeBanner: false, // Remove a tag 'debug' do canto superior direito.
      home: InputScreen(toggleTheme: _toggleTheme), // Define a tela inicial do aplicativo e passa a função de alternar tema.
    );
  }
}
