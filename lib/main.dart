import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 112, 160, 170),
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(
        title: 'Flutter Interface',
      ),
    );
  }
}

// Головний екран додатку. Оголошення StatefulWidget,
class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.title, super.key});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Color _submitButtonColor = Colors.blue; // Змінна для кольору кнопки
  final TextEditingController _controller = TextEditingController();
// Метод для збільшення лічильника на 1.
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _handleInput() {
    final String input = _controller.text.trim();
    // Перевірка на спеціальне слово "NU LP"
    setState(() {
      if (input == 'NU LP') {
        _counter = 0;
        _submitButtonColor =
            Colors.blue; // Повертаємо колір кнопки на початковий
      } else if (RegExp(r'^[a-zA-Z\s]+$').hasMatch(input)) {
        _counter = 0; // Скидає лічильник, якщо введено текст
      } else {
        // Якщо введено число.
        final int? number = int.tryParse(input);
        if (number != null) {
          _counter += number;
          _submitButtonColor =
              Colors.primaries[number % Colors.primaries.length];
          // Змінює колір кнопки на основі введеного числа
        }
      }
      _controller.clear(); // Очищує текстове поле після обробки вводу
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Побудова інтерфейсу екрану.
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(
          child: Text(widget.title),
        ),
      ),
      body: Center(
        // Основний вміст екрану розміщений по центру.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_counter', // Відображає значення лічильника.
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _controller, // Контролер, що відстежує ввід юзера
                decoration: const InputDecoration(
                  border: OutlineInputBorder(), // Окреслення текстового поля.
                  labelText: 'Enter a number or text',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _handleInput, // Викликає метод _handleInput
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _submitButtonColor, // встановлення кольору кноп
              ),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter, // Викликає метод _incrementCount
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
