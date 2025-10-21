import 'package:flutter/material.dart';

/// Barra de navegación personalizada para la aplicación FastPedido.
/// Implementa "PreferredSizeWidget" para ser utilizada como AppBar.
/// 
/// Muestra:
/// - Botón de retroceso
/// - Logo de la aplicación
/// - Nombre de la aplicación
/// - Título de la sección actual

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;/// Título que se muestra en la parte derecha de la barra

  /// Callback opcional para el botón de retroceso
  /// Si no se proporciona, utilizará la navegación por defecto (Navigator.pop)
  final VoidCallback? onBack;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    /// Construye un AppBar personalizado con fondo gris claro y sin elevación
    /// Altura fija de 70 píxeles para acomodar el logo y el texto
    return AppBar(
      backgroundColor: const Color(0xFFF9F9F9),
      elevation: 0,
      toolbarHeight: 70,
      /// Botón de retroceso personalizado
      /// Usa el callback proporcionado o Navigator.pop por defecto
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black87),
        onPressed: onBack ?? () => Navigator.pop(context),
      ),
      titleSpacing: 0,
      /// Contenedor principal que organiza los elementos horizontalmente
      title: Row(
        children: [
          /// Logo de la aplicación
          /// Si no se encuentra la imagen, muestra un icono de delivery como fallback
          Image.asset(
            'assets/images/logo.png',
            height: 45,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.delivery_dining, color: Colors.white),
              );
            },
          ),
          const SizedBox(width: 8),
          const Text(
            'FastPedido',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              decoration: TextDecoration.underline,
              decorationColor: Colors.red,
              decorationThickness: 2.5,
            ),
          ),

          const Spacer(),

          Padding(
            padding: const EdgeInsets.only(right: 16), // espacio agregado
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
  /// Implementación requerida de "PreferredSizeWidget"
  /// Define la altura preferida de la barra de navegación
  @override
  Size get preferredSize => const Size.fromHeight(70);
}
