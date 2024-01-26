import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Importe a classe IMC
import 'imc.dart';

class CalculaImc extends StatefulWidget {
  const CalculaImc({Key? key}) : super(key: key);

  @override
  State<CalculaImc> createState() => _CalculaImcState();
}

class _CalculaImcState extends State<CalculaImc> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  String resultado = "";
  String grauObesidade = "";

  static const String imcBoxName = 'imcBox';

  // Adicione uma variável para armazenar a lista de IMCs
  late Box<IMC> imcBox;

  @override
  void initState() {
    super.initState();
    // Inicialize o Hive
    Hive.initFlutter();
    // Abra a caixa Hive
    _openBox();
  }

  void _openBox() async {
    imcBox = await Hive.openBox<IMC>(imcBoxName);
  }

  void calcularIMC() {
    double peso = double.tryParse(pesoController.text) ?? 0;
    double altura = double.tryParse(alturaController.text) ?? 0;

    if (peso > 0 && altura > 0) {
      double imc = peso / (altura * altura);

      // Crie uma instância de IMC
      IMC novoImc = IMC(
        peso: peso,
        altura: altura,
        data: DateTime.now(),
      );

      // Salve o IMC na caixa Hive
      imcBox.add(novoImc);

      setState(() {
        resultado = "Seu IMC é ${imc.toStringAsFixed(2)}";
        grauObesidade = _calcularGrauObesidade(imc);
      });
    } else {
      setState(() {
        resultado = "Por favor, insira valores válidos.";
        grauObesidade = '';
      });
    }
  }

  String _calcularGrauObesidade(double imc) {
    if (imc < 18.5) {
      grauObesidade = "Abaixo do Peso";
    } else if (imc >= 18.5 && imc <= 25) {
      grauObesidade = "Peso Normal";
    } else if (imc > 25.0 && imc <= 30) {
      grauObesidade = "Sobrepeso";
    } else if (imc > 30.0 && imc <= 35) {
      grauObesidade = "Obesidade Grau I";
    } else if (imc > 35.0 && imc <= 39.9) {
      grauObesidade = "Obesidade Grau II";
    } else {
      grauObesidade = "Obesidade Grau III";
    }

    return "Grau de Obesidade";
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hintText,
    IconData prefixIcon,
  ) {
    return TextField(
      style: GoogleFonts.amita(
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
      controller: controller,
      onChanged: (value) {},
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(bottom: 2, top: 13),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 209, 209, 209)),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 209, 209, 209)),
        ),
        hintText: hintText,
        hintStyle:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        prefixIcon: Icon(
          prefixIcon,
          color: Colors.black,
          size: prefixIcon == Icons.balance ? 35 : 40,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
          child: Container(
            width: double.infinity,
            color: const Color.fromARGB(255, 245, 240, 225),
            child: Column(
              children: [
                const SizedBox(height: 80),
                _buildTextField(
                  pesoController,
                  "Peso",
                  Icons.balance,
                ),
                const SizedBox(height: 60),
                _buildTextField(
                  alturaController,
                  "Altura em metros",
                  Icons.height,
                ),
                const SizedBox(height: 60),
                TextButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(255, 209, 209, 209),
                    ),
                  ),
                  onPressed: () {
                    calcularIMC();
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: const Text(
                    'Calcular IMC',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Text(
                  resultado,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  grauObesidade,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 50),
                // Exiba a lista de IMCs
                _buildIMCList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIMCList() {
    return ValueListenableBuilder(
      valueListenable: imcBox.listenable(),
      builder: (context, Box<IMC> box, _) {
        return Expanded(
          child: ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              IMC imc = box.getAt(index)!;
              return ListTile(
                title: Text("IMC: ${imc.peso / (imc.altura * imc.altura)}"),
                subtitle: Text("Data: ${imc.data}"),
              );
            },
          ),
        );
      },
    );
  }
}
