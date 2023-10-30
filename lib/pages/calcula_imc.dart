import 'package:flutter/material.dart';

class CalculaImc extends StatefulWidget {
  const CalculaImc({Key? key}) : super(key: key);

  @override
  State<CalculaImc> createState() => _CalculaImcState();
}

class _CalculaImcState extends State<CalculaImc> {
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
                const SizedBox(
                  height: 80,
                ),
                TextField(
                  onChanged: (ValueKey) {},
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 9),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 209, 209, 209))),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 209, 209, 209))),
                      hintText: "Peso",
                      hintStyle: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w700),
                      prefixIcon: Icon(
                        Icons.balance,
                        color: Colors.black,
                        size: 35,
                      )),
                ),
                const SizedBox(
                  height: 100,
                ),
                TextField(
                  onChanged: (ValueKey) {},
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 9),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 209, 209, 209))),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 209, 209, 209))),
                      hintText: "Altura",
                      hintStyle: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w700),
                      prefixIcon: Icon(
                        Icons.height,
                        color: Colors.black,
                        size: 40,
                      )),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
