import 'package:flutter/material.dart';

/// Widget que representa una barra de búsqueda con botón de filtro.
/// Incluye un campo de texto para búsqueda y un botón de filtro adicional.
class SearchBarWidget extends StatelessWidget {
  final String hintText;/// Texto que se muestra como placeholder en el campo de búsqueda
  final ValueChanged<String>? onChanged;/// Callback que se ejecuta cada vez que cambia el texto de búsqueda
  final VoidCallback? onFilterPressed;  /// Callback que se ejecuta cuando se presiona el botón de filtro

  const SearchBarWidget({
    super.key,
    this.hintText = 'Buscar...',
    this.onChanged,
    this.onFilterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Campo de búsqueda: Ocupa el espacio disponible y tiene un fondo gris claro
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 13,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey[400],
                  size: 22,
                ),
                filled: true,
                fillColor: Colors.transparent,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        /// Botón de filtro: Contenedor cuadrado con icono de filtro
        GestureDetector(
          onTap: onFilterPressed,
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.filter_list,
              color: Colors.grey,
              size: 22,
            ),
          ),
        ),
      ],
    );
  }
}
