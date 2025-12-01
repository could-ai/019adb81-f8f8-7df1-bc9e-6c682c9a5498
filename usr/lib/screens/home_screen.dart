import 'package:flutter/material.dart';
import '../models/appointment.dart';
import '../widgets/logo.dart';
import 'booking_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Lista local de citas (en una app real, esto vendría de una base de datos)
  final List<Appointment> _appointments = [];

  void _addAppointment(Appointment appointment) {
    setState(() {
      _appointments.add(appointment);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Magic Hair"),
        centerTitle: true,
      ),
      body: _appointments.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const MagicHairLogo(),
                  const SizedBox(height: 40),
                  Text(
                    "No hay citas agendadas aún",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingScreen(
                            onBookingCreated: _addAppointment,
                          ),
                        ),
                      );
                    },
                    child: const Text("Agendar Primera Cita"),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _appointments.length,
              itemBuilder: (context, index) {
                final apt = _appointments[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                      child: Icon(Icons.person, color: Theme.of(context).colorScheme.primary),
                    ),
                    title: Text("${apt.firstName} ${apt.lastName}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Procedimiento: ${apt.procedure}", style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text("Tel: ${apt.phoneNumber}"),
                      ],
                    ),
                    trailing: const Icon(Icons.check_circle, color: Colors.green),
                  ),
                );
              },
            ),
      floatingActionButton: _appointments.isEmpty
          ? null
          : FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingScreen(
                      onBookingCreated: _addAppointment,
                    ),
                  ),
                );
              },
              label: const Text("Nueva Cita"),
              icon: const Icon(Icons.add),
            ),
    );
  }
}
