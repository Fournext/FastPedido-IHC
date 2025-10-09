import 'package:flutter/material.dart';

class CreditCardScreen extends StatefulWidget {
  const CreditCardScreen({super.key});

  @override
  State<CreditCardScreen> createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends State<CreditCardScreen> {
  final TextEditingController _cardHolderController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _securityCodeController = TextEditingController();
  bool _saveCard = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 70,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Tarjeta Crédito / Débito',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Campo Nombre del Titular
            _buildTextField(
              controller: _cardHolderController,
              label: 'Nombre del Titular de la tarjeta *',
              hintText: 'Ingresa el nombre completo',
            ),
            const SizedBox(height: 20),

            // Campo Número de Tarjeta
            _buildTextField(
              controller: _cardNumberController,
              label: 'Número de la Tarjeta *',
              hintText: 'XXXX XXXX XXXX XXXX',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),

            // Campo Fecha de Vencimiento
            _buildTextField(
              controller: _expiryDateController,
              label: 'Fecha de Vencimiento *',
              hintText: 'MM/YY',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),

            // Campo Código de Seguridad
            _buildTextField(
              controller: _securityCodeController,
              label: 'Código de Seguridad *',
              hintText: 'XXX',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 30),

            // Checkbox para guardar tarjeta
            Row(
              children: [
                Checkbox(
                  value: _saveCard,
                  onChanged: (value) {
                    setState(() {
                      _saveCard = value ?? false;
                    });
                  },
                  activeColor: Colors.red,
                ),
                const Expanded(
                  child: Text(
                    'Quiero guardar esta tarjeta para mi próxima compra',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ),
              ],
            ),

            const Spacer(),

            // Botón Pagar
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _processPayment();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Pagar',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 14, color: Colors.grey[400]),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }

  void _processPayment() {
    // Validar campos
    if (_cardHolderController.text.isEmpty ||
        _cardNumberController.text.isEmpty ||
        _expiryDateController.text.isEmpty ||
        _securityCodeController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Campos Requeridos'),
            content: const Text(
              'Por favor, completa todos los campos requeridos.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    // Simular procesamiento de pago
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Procesando pago...'),
            ],
          ),
        );
      },
    );

    // Simular delay de procesamiento
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pop(); // Cerrar diálogo de carga
      _showPaymentSuccess();
    });
  }

  void _showPaymentSuccess() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¡Pago Exitoso!'),
          content: const Text(
            'Tu pago ha sido procesado exitosamente.\nTu pedido ha sido confirmado.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Navegar a Orders
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/orders',
                  (route) => route.settings.name == '/',
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Ver Pedidos'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _cardHolderController.dispose();
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _securityCodeController.dispose();
    super.dispose();
  }
}
