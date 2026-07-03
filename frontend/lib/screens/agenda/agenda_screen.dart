import 'package:flutter/material.dart';
import '../../models/evento_model.dart';
import '../../services/evento_service.dart';

class AgendaScreen extends StatefulWidget {
  const AgendaScreen({super.key});

  @override
  State<AgendaScreen> createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  bool showCalendar = false;
  int currentMonth = DateTime.now().month - 1;

  String selectedFilter = "Todos";

  final EventoService _service = EventoService();
  late Future<List<EventoModel>> _future;

  @override
  void initState() {
    super.initState();
    _future = _service.listar();
  }

  final List<String> months = const [
    "Janeiro","Fevereiro","Março","Abril","Maio","Junho",
    "Julho","Agosto","Setembro","Outubro","Novembro","Dezembro",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1E293B),
        title: const Text("Agenda"),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: () {
              setState(() {
                showCalendar = true;
                currentMonth = DateTime.now().month - 1;
              });
            },
          )
        ],
      ),

      body: Stack(
        children: [

        
          Padding(
            padding: const EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Text(
                  "Sessões e eventos da Câmara",
                  style: TextStyle(color: Colors.white70),
                ),

                const SizedBox(height: 12),

                const Text(
                  "Próximos Eventos",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _filterTab("Todos"),
                      _filterTab("Sessão"),
                      _filterTab("Comissão"),
                      _filterTab("Audiência"),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

               
                Expanded(
                  child: FutureBuilder<List<EventoModel>>(
                    future: _future,
                    builder: (context, snap) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snap.hasError) {
                        return Center(
                          child: Text(
                            "Erro ao carregar eventos:\n${snap.error}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.redAccent),
                          ),
                        );
                      }
                      final eventos = (snap.data ?? [])
                          .where((e) =>
                              selectedFilter == "Todos" ||
                              e.tipoLabel == selectedFilter)
                          .toList();
                      if (eventos.isEmpty) {
                        return const Center(
                          child: Text("Nenhum evento agendado.",
                              style: TextStyle(color: Colors.white54)),
                        );
                      }
                      return ListView(children: eventos.map(_eventoCard).toList());
                    },
                  ),
                ),

               
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      "Solicitar Reunião com Gabinete",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

        
          if (showCalendar)
            Positioned.fill(
              child: GestureDetector(
                onTap: () => setState(() => showCalendar = false),
                child: Container(
                  color: Colors.black54,
                  child: Center(
                    child: Container(
                      width: 420,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E293B),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          const Text(
                            "Calendário",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 14),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              IconButton(
                                icon: const Icon(Icons.chevron_left,
                                    color: Colors.white),
                                onPressed: () {
                                  setState(() {
                                    if (currentMonth > 0) currentMonth--;
                                  });
                                },
                              ),

                              Text(
                                months[currentMonth],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),

                              IconButton(
                                icon: const Icon(Icons.chevron_right,
                                    color: Colors.white),
                                onPressed: () {
                                  setState(() {
                                    if (currentMonth < 11) currentMonth++;
                                  });
                                },
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          Row(
                            children: const [
                              _weekday("Dom"),
                              _weekday("Seg"),
                              _weekday("Ter"),
                              _weekday("Qua"),
                              _weekday("Qui"),
                              _weekday("Sex"),
                              _weekday("Sáb"),
                            ],
                          ),

                          const SizedBox(height: 12),

                          SizedBox(
                            height: 300,
                            child: GridView.builder(
                              itemCount: _daysInMonth(currentMonth) +
                                  _firstWeekdayOfMonth(currentMonth),

                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 7,
                                crossAxisSpacing: 6,
                                mainAxisSpacing: 6,
                              ),

                              itemBuilder: (context, index) {
                                final firstWeek =
                                    _firstWeekdayOfMonth(currentMonth);
                                final days = _daysInMonth(currentMonth);

                                final day = index - firstWeek + 1;
                                final valid = day > 0 && day <= days;

                                return Container(
                                  decoration: BoxDecoration(
                                    color: valid
                                        ? const Color(0xFF0F172A)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      valid ? "$day" : "",
                                      style: const TextStyle(
                                          color: Colors.white),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }


  Widget _filterTab(String label) {
    final selected = selectedFilter == label;

    return GestureDetector(
      onTap: () => setState(() => selectedFilter = label),

      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14),

        decoration: BoxDecoration(
          color: selected ? Colors.indigo : const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(20),
        ),

        child: Center(
          child: Text(
            label,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }


  Widget _eventoCard(EventoModel e) {
    const meses = [
      "Jan", "Fev", "Mar", "Abr", "Mai", "Jun",
      "Jul", "Ago", "Set", "Out", "Nov", "Dez"
    ];
    final d = e.dataHora;
    final hora =
        "${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}";
    return _evento(
      dia: d.day.toString(),
      mes: meses[d.month - 1],
      titulo: e.titulo,
      tipo: e.tipoLabel,
      hora: hora,
      local: e.local ?? "—",
      participantes: e.status,
    );
  }


  int _daysInMonth(int month) {
    final year = DateTime.now().year;
    return DateTime(year, month + 2, 0).day;
  }

  int _firstWeekdayOfMonth(int month) {
    final year = DateTime.now().year;
    return DateTime(year, month + 1, 1).weekday % 7;
  }
}



class _evento extends StatefulWidget {
  final String dia;
  final String mes;
  final String titulo;
  final String tipo;
  final String hora;
  final String local;
  final String participantes;

  const _evento({
    required this.dia,
    required this.mes,
    required this.titulo,
    required this.tipo,
    required this.hora,
    required this.local,
    required this.participantes,
  });

  @override
  State<_evento> createState() => _EventoState();
}

class _EventoState extends State<_evento> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),

        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(14),

          boxShadow: hover
              ? [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                  )
                ]
              : [],
        ),

        child: Stack(
          children: [

            Row(
              children: [

                Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.indigo, Colors.purple],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.dia,
                          style: const TextStyle(color: Colors.white)),
                      Text(widget.mes,
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 10)),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(widget.titulo,
                          style: const TextStyle(color: Colors.white)),

                      const SizedBox(height: 6),

                      Row(
                        children: [
                          const Icon(Icons.access_time,
                              size: 14, color: Colors.white54),
                          const SizedBox(width: 5),
                          Text(widget.hora,
                              style: const TextStyle(color: Colors.white54)),
                        ],
                      ),

                      Text(widget.local,
                          style: const TextStyle(color: Colors.white54)),

                      Row(
                        children: [
                          const Icon(Icons.person,
                              size: 14, color: Colors.white54),
                          const SizedBox(width: 5),
                          Text(widget.participantes,
                              style: const TextStyle(color: Colors.white54)),
                        ],
                      ),

                      const SizedBox(height: 12),

                      const Text(
                        "Ver detalhes →",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: widget.tipo == "Sessão"
                      ? Colors.indigo
                      : widget.tipo == "Audiência"
                          ? Colors.purple
                          : Colors.teal,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  widget.tipo,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class _weekday extends StatelessWidget {
  final String label;

  const _weekday(this.label);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          label,
          style: const TextStyle(color: Colors.white54),
        ),
      ),
    );
  }
}