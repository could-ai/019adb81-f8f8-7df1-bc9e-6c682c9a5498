import 'package:flutter/material.dart';
import '../models/appointment.dart';
import '../widgets/logo.dart';

class BookingScreen extends StatefulWidget {
  final Function(Appointment) onBookingCreated;

  const BookingScreen({super.key, required this.onBookingCreated});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Controladores de texto
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  
  String? _selectedProcedure;
  
  final List<String> _procedures = [
    'Corte de Cabello',
    'Tinte / Coloración',
    'Alisado Permanente',
    'Manicura / Pedicura',
    'Maquillaje',
    'Tratamiento Capilar',
  ];

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newAppointment = Appointment(
        id: DateTime.now().toString(),
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        phoneNumber: _phoneController.text,
        procedure: _selectedProcedure!,
        date: DateTime.now(),
      );

      widget.onBookingCreated(newAppointment);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('¡Cita agendada con éxito!'),
          backgroundColor: Colors.green,
        ),
      );

      // Limpiar formulario
      _firstNameController.clear();
      _lastNameController.clear();
      _phoneController.clear();
      setState(() {
        _selectedProcedure = null;
      });
      
      // Volver a la pantalla anterior
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agendar Cita"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const MagicHairLogo(size: 80),
              const SizedBox(height: 30),
              
              // Nombre
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  labelText: "Nombre",
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // Apellido
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  labelText: "Apellido",
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el apellido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // Teléfono
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Número de Teléfono",
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el teléfono';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // Procedimiento (Dropdown)
              DropdownButtonFormField<String>(
                value: _selectedProcedure,
                decoration: const InputDecoration(
                  labelText: "Procedimiento",
                  prefixIcon: Icon(Icons.content_cut),
                  border: OutlineInputBorder(),
                ),
                items: _procedures.map((String procedure) {
                  return DropdownMenuItem<String>(
                    value: procedure,
                    child: Text(procedure),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedProcedure = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Selecciona un procedimiento';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              
              // Botón de Acción
              FilledButton.icon(
                onPressed: _submitForm,
                icon: const Icon(Icons.calendar_check),
                label: const Text(
                  "CONFIRMAR RESERVACIÓN",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
