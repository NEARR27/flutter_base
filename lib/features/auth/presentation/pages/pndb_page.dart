import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ModelPage extends StatefulWidget {
  static const String id = "Model_Page";
  const ModelPage({super.key});

  @override
  State<ModelPage> createState() => _ModelPageState();
}

class _ModelPageState extends State<ModelPage> {
  final _formKey = GlobalKey<FormState>();
  String _respuesta = '';
  double? age, hba1c, birthWeight, insulinLevel;
  bool geneticInfo = false, familyHistory = false, developmentalDelay = false;

  TextEditingController _ageController = TextEditingController();
  TextEditingController _hba1cController = TextEditingController();
  TextEditingController _birthWeightController = TextEditingController();
  TextEditingController _insulinLevelController = TextEditingController();

  @override
  void dispose() {
    _ageController.dispose();
    _hba1cController.dispose();
    _birthWeightController.dispose();
    _insulinLevelController.dispose();
    super.dispose();
  }

  Future<void> _consultarModelo() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final url = Uri.parse('https://pndb-model-nearr27-service-nearr27.cloud.okteto.net/predict');
      final response = await http.post(
        url,
        body: json.encode({
          "Age": age,
          "HbA1c": hba1c,
          "Genetic_Info": geneticInfo ? 1 : 0,
          "Family_History": familyHistory ? 1 : 0,
          "Birth_Weight": birthWeight,
          "Developmental_Delay": developmentalDelay ? 1 : 0,
          "Insulin_Level": insulinLevel,
        }),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final int prediction = jsonResponse['prediction'];
        setState(() {
          if (prediction == 0) {
            _respuesta = 'Negative for PNDM';
          } else if (prediction == 1) {
            _respuesta = 'Positive for PNDM';
          } else {
            _respuesta = 'Unexpected result: $prediction';
          }
        });
      } else {
        // Handle other status codes appropriately
        setState(() {
          _respuesta = 'Error al obtener respuesta: ${response.statusCode}';
        });
      }

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta de Modelo'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                onSaved: (value) => age = double.tryParse(value ?? ''),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the age';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _hba1cController,
                decoration: const InputDecoration(labelText: 'HbA1c'),
                keyboardType: TextInputType.number,
                onSaved: (value) => hba1c = double.tryParse(value ?? ''),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the HbA1c value';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _birthWeightController,
                decoration: const InputDecoration(labelText: 'Birth Weight'),
                keyboardType: TextInputType.number,
                onSaved: (value) => birthWeight = double.tryParse(value ?? ''),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the birth weight';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _insulinLevelController,
                decoration: const InputDecoration(labelText: 'Insulin Level'),
                keyboardType: TextInputType.number,
                onSaved: (value) => insulinLevel = double.tryParse(value ?? ''),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the insulin level';
                  }
                  return null;
                },
              ),
              SwitchListTile(
                title: const Text('Genetic Info'),
                value: geneticInfo,
                onChanged: (bool value) {
                  setState(() {
                    geneticInfo = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Family History'),
                value: familyHistory,
                onChanged: (bool value) {
                  setState(() {
                    familyHistory = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Developmental Delay'),
                value: developmentalDelay,
                onChanged: (bool value) {
                  setState(() {
                    developmentalDelay = value;
                  });
                },
              ),
              ElevatedButton(
                onPressed: _consultarModelo,
                child: const Text('Consultar Modelo'),
              ),
              Text(_respuesta), // Mostrar la respuesta de la API aquí
            ],
          ),
        ),
      ),
    );
  }


}
