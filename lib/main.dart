import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Lista de ícones
  List<Offset> iconPositions = [];

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    // Defina a largura e altura da imagem como proporção da tela
    double imageWidth = screenSize.width * 0.8;
    double imageHeight = screenSize.height * 0.6;

    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTapUp: (TapUpDetails details) {
            // Obter a posição do clique
            Offset position = details.localPosition;
            // Converter a posição do clique para proporções
            double xPosition = position.dx / imageWidth;
            double yPosition = position.dy / imageHeight;
            // Imprimir as proporções
            print('Clique na proporção: ($xPosition, $yPosition)');
            // Faça o que for necessário com as proporções clicadas
            // Por exemplo, destaque ou grave a posição
            setState(() {
              iconPositions.add(details.localPosition);
            });
          },
          child: Stack(
            children: [
              Positioned.fill(
                // width: imageWidth,
                // height: imageHeight,
                child: Image.asset(
                  'assets/map.jpg',
                  fit: BoxFit.contain,
                ),
              ),
              // Ícones nas posições clicadas
              ...iconPositions.asMap().entries.map((entry) {
                final index = entry.key;
                final position = entry.value;
                return Positioned(
                  left: position.dx - 12, // Ajusta a posição do ícone
                  top: position.dy - 12, // Ajusta a posição do ícone
                  child: GestureDetector(
                    onTap: () {
                      // Remove o ícone da posição clicada
                      setState(() {
                        iconPositions.removeAt(index);
                      });
                    },
                    child: const Icon(
                      Icons.star,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
