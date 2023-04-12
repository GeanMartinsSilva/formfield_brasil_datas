import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brasil Field Nova Data',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myController = TextEditingController();
  final newdata = TextEditingController();
  final data = TextEditingController();
  final hora = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: newdata,
                decoration: const InputDecoration(
                  label: Text(
                    'Data - Novo Formatter',
                  ),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  NewDataInputFormatter(),
                ],
              ),
              TextFormField(
                controller: data,
                decoration: const InputDecoration(
                  label: Text(
                    'Data - Formatter do Package',
                  ),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  DataInputFormatter(),
                ],
              ),
              TextFormField(
                controller: hora,
                decoration: const InputDecoration(
                  label: Text(
                    'Hora',
                  ),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  HoraInputFormatter(),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var data0 = DateFormat('yyyy-MM-dd').format(DateTime.now());
          print(data0);
          var data1 = DateFormat('HH:mm').format(DateTime.now());
          print(data1);
          var data2 = DateFormat.Hms().format(DateTime.now());
          print(data2);
          print('${data0}T$data1');
          print(DateTime.now());
          print('==================');
          //print(data0);
          //print(DateFormat('yyyy-MM-dd').format(DateTime.now()));
          print(DateFormat('dd/MM/yyyy').format(DateTime.now()));
          //print(DateFormat('HH:mm:ss').parse(hora.text));
          print('object');
          //print(DateFormat('dd/MM/yyyy').parse(newdata.text));

          print(DateFormat('yyyy/MM/dd').parse(newdata.text));
          print(DateFormat('yyyy/MM/dd').parse('2020/04/03'));
          print('========= PEGANDO O CONTROLLER =========');
          print(data.text.length);
          print(hora.text.length);
          var dataConvertida = DateFormat('dd/MM/yyyy').parse(newdata.text);
          var datafinal = DateFormat('yyyy-MM-dd').format(dataConvertida);
          var horafinal = DateFormat.Hms().format(DateTime.now());
          //print(DateFormat('dd/MM/yyyy').parse(data.text));
          //print(DateFormat('yyyy-MM-dd').parse(data.text));
          print('==========INPUT ORIGINAL========');
          print(newdata.text);
          print(data.text);
          print(hora.text);
          print('${dataConvertida}T${hora.text}:00');
          print('${datafinal}T${hora.text}:00');
        },
      ),
    );
  }
}

class RowFormatters extends StatelessWidget {
  final String label;
  final TextInputFormatter formatter;

  const RowFormatters(
      {super.key, required this.label, required this.formatter});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(label: Text(label)),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        formatter,
      ],
    );
  }
}

class NewDataInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newValueLength = newValue.text.length;

    // Verifica o tamanho máximo do campo.
    if (newValueLength > 8) {
      return oldValue;
    }

    var selectionIndex = newValue.selection.end;
    var substrIndex = 0;
    final newText = StringBuffer();

    switch (newValueLength) {
      case 1:
        final dia = int.parse(newValue.text.substring(0, 1));
        if (dia >= 4) return oldValue;
        print(newValue.text.substring(0, 1));
        break;

      case 2:
        final dia = int.parse(newValue.text.substring(0, 2));
        if (dia >= 32 || dia < 01) return oldValue;
        print(newValue.text.substring(0, 2));

        break;

      case 3:
        final mes = int.parse(newValue.text.substring(2, 3));
        if (mes >= 2) return oldValue;
        newText.write('${newValue.text.substring(0, substrIndex = 2)}/');
        if (newValue.selection.end >= 2) selectionIndex++;
        print(newValue.text.substring(2, 3));

        break;

      case 4:
        final mes = int.parse(newValue.text.substring(2, 4));
        if (mes >= 13 || mes < 01) return oldValue;
        newText.write('${newValue.text.substring(0, substrIndex = 2)}/');
        if (newValue.selection.end >= 2) selectionIndex++;
        print(newValue.text.substring(2, 4));

        break;

      case 5:
        final ano = int.parse(newValue.text.substring(4, 5));
        if (ano >= 3 || ano <= 1) return oldValue;

        if (newValueLength >= 5) {
          newText.write(
              '${newValue.text.substring(0, substrIndex = 2)}/${newValue.text.substring(2, substrIndex = 4)}/');
          selectionIndex = 7;
        }
        break;

      case 6:
        final ano = int.parse(newValue.text.substring(4, 6));
        if (ano >= 21 || ano <= 19) return oldValue;
        if (newValueLength >= 6) {
          newText.write(
              '${newValue.text.substring(0, substrIndex = 2)}/${newValue.text.substring(2, substrIndex = 4)}/');
          selectionIndex = 8;
        }
        break;

      case 7:
        final ano = int.parse(newValue.text.substring(4, 7));
        if (ano >= 203 || ano <= 201) return oldValue;

        if (newValueLength >= 7) {
          newText.write(
              '${newValue.text.substring(0, substrIndex = 2)}/${newValue.text.substring(2, substrIndex = 4)}/');
          selectionIndex = 9;
        }
        break;

      case 8:
        final ano = int.parse(newValue.text.substring(4, 8));
        if (ano <= 2022) return oldValue;

        if (newValueLength >= 8) {
          newText.write(
              '${newValue.text.substring(0, substrIndex = 2)}/${newValue.text.substring(2, substrIndex = 4)}/');
          selectionIndex = 10;
        }
        break;
    }

    if (newValueLength >= substrIndex) {
      newText.write(newValue.text.substring(substrIndex));
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
