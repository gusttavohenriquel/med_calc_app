import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: PaginaMorse(),
  ));
}

class PaginaMorse extends StatefulWidget {
  const PaginaMorse({super.key});

  @override
  _PaginaMorseState createState() => _PaginaMorseState();
}

class _PaginaMorseState extends State<PaginaMorse> {
  String _resultadoFinal = "";
  // Tornando os valores nulos inicialmente para permitir validação do formulário
  int? _valorHistoriaQueda;
  int? _valorDiagnostico;
  int? _valorAmbulacao;
  int? _valorTerapia;
  int? _valorMarcha;
  int? _valorMental;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double _score = 0.0;

  double calcularMorse(double historiaQueda, double secundariaDiagnostico, double ambulacaoAuxilio, double terapiaEndovenosa, double marcha, double mental) {
    return (historiaQueda + secundariaDiagnostico + ambulacaoAuxilio + terapiaEndovenosa + marcha + mental).toDouble();
  }

  String classificarRisco(double score) {
    if (score >= 45) {
      return "Alto risco";
    } else if (score >= 25) {
      return "Risco moderado";
    } else {
      return "Baixo risco";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Exibe resultado dentro de um Card quando houver resultado
            if (_resultadoFinal.isNotEmpty)
              Card(
                color: Colors.grey[100],
                margin: const EdgeInsets.only(bottom: 12.0),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Score: ${_score.toInt()}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 6),
                      Text(_resultadoFinal, style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
            if (_resultadoFinal.isEmpty)
              Text('Insira os dados do Paciente:'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("1. Histórico de Quedas:", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    DropdownButtonFormField<int>(
                      decoration: InputDecoration(border: OutlineInputBorder(), contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
                      initialValue: _valorHistoriaQueda,
                      items: [
                        DropdownMenuItem(value: 0, child: Text("Sem histórico")),
                        DropdownMenuItem(value: 25, child: Text("Com histórico (últimos 3 meses)")),
                      ],
                      onChanged: (novoValor) {
                        setState(() {
                          _valorHistoriaQueda = novoValor;
                        });
                      },
                      validator: (v) => v == null ? 'Selecione uma opção' : null,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: DropdownButtonFormField<int>(
                  decoration: InputDecoration(labelText: 'Diagnóstico secundário', border: OutlineInputBorder()),
                  initialValue: _valorDiagnostico,
                  items: [
                    DropdownMenuItem(value: 0, child: Text("Sem diagnóstico secundário")),
                    DropdownMenuItem(value: 15, child: Text("Com diagnóstico secundário")),
                  ],
                  onChanged: (novoValor) {
                    setState(() {
                      _valorDiagnostico = novoValor;
                    });
                  },
                  validator: (v) => v == null ? 'Selecione uma opção' : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: DropdownButtonFormField<int>(
                  decoration: InputDecoration(labelText: 'Ambulação/Auxílio', border: OutlineInputBorder()),
                  initialValue: _valorAmbulacao,
                  items: [
                    DropdownMenuItem(value: 0, child: Text("Nenhum/Acamado/Cadeira de rodas")),
                    DropdownMenuItem(value: 15, child: Text("Muleta/Bengala/Andador")),
                    DropdownMenuItem(value: 30, child: Text("Mobiliário")),
                  ],
                  onChanged: (novoValor) {
                    setState(() {
                      _valorAmbulacao = novoValor;
                    });
                  },
                  validator: (v) => v == null ? 'Selecione uma opção' : null,
                ),
              ),
          
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: DropdownButtonFormField<int>(
                  decoration: InputDecoration(labelText: 'Terapia endovenosa', border: OutlineInputBorder()),
                  initialValue: _valorTerapia,
                  items: [
                    DropdownMenuItem(value: 0, child: Text("Sem terapia endovenosa")),
                    DropdownMenuItem(value: 20, child: Text("Com terapia endovenosa")),
                  ],
                  onChanged: (novoValor) {
                    setState(() {
                      _valorTerapia = novoValor;
                    });
                  },
                  validator: (v) => v == null ? 'Selecione uma opção' : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: DropdownButtonFormField<int>(
                  decoration: InputDecoration(labelText: 'Marcha', border: OutlineInputBorder()),
                  initialValue: _valorMarcha,
                  items: [
                    DropdownMenuItem(value: 0, child: Text("Normal/Acamado")),
                    DropdownMenuItem(value: 10, child: Text("Fraca")),
                    DropdownMenuItem(value: 20, child: Text("Comprometida")),
                  ],
                  onChanged: (novoValor) {
                    setState(() {
                      _valorMarcha = novoValor;
                    });
                  },
                  validator: (v) => v == null ? 'Selecione uma opção' : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: DropdownButtonFormField<int>(
                  decoration: InputDecoration(labelText: 'Estado mental', border: OutlineInputBorder()),
                  initialValue: _valorMental,
                  items: [
                    DropdownMenuItem(value: 0, child: Text("Orientado/Conhece Limitações")),
                    DropdownMenuItem(value: 15, child: Text("Supereestima capacidade ou Esquece limitações")),
                  ],
                  onChanged: (novoValor) {
                    setState(() {
                      _valorMental = novoValor;
                    });
                  },
                  validator: (v) => v == null ? 'Selecione uma opção' : null,
                ),
              ),
                  // Aqui entrarão os campos de entrada depois!
              ElevatedButton(
                onPressed: () {
                  // Valida o formulário antes de calcular
                  if (!_formKey.currentState!.validate()) return;
                  double score = calcularMorse(
                    _valorHistoriaQueda!.toDouble(),
                    _valorDiagnostico!.toDouble(),
                    _valorAmbulacao!.toDouble(),
                    _valorTerapia!.toDouble(),
                    _valorMarcha!.toDouble(),
                    _valorMental!.toDouble(),
                  );
                  setState(() {
                    _score = score;
                    _resultadoFinal = classificarRisco(score);
                  });
                },
                child: Text("Calcular"),
              ),
            ],
          ),
        ),
      )
    );
  }
}