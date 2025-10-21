import 'package:flutter/material.dart';

/// Widget que representa una tarjeta de oferta de producto.
/// Muestra la imagen, precio, descuento, controles de cantidad y botón de favorito.
class OfferCard extends StatelessWidget {
  final Map<String, dynamic> product;  /// Información del producto (nombre, precio, imagen, descuento, etc.)
  final bool isFavorite;/// Indica si el producto está marcado como favorito
  final int quantity;  /// Cantidad actual del producto seleccionada
  final VoidCallback? onAdd;/// Callback ejecutado cuando se presiona el botón de añadir
  final VoidCallback? onRemove;/// Callback ejecutado cuando se presiona el botón de remover
  final VoidCallback? onToggleFavorite;/// Callback ejecutado cuando se presiona el botón de favorito

  const OfferCard({
    super.key,
    required this.product,
    this.isFavorite = false,
    this.quantity = 0,
    this.onAdd,
    this.onRemove,
    this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    /// Determina si se deben mostrar los controles de cantidad
    /// Se muestran solo cuando hay al menos un item seleccionado
    final showQuantityControls = quantity > 0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Sección superior: Imagen del producto con badge de descuento
          /// La imagen se ajusta al contenedor manteniendo su proporción
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                  child: Image.asset(
                    product['image'],
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.shopping_bag, size: 60, color: Colors.grey),
                  ),
                ),
                if (product.containsKey('discount'))
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '-${product['discount']}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 6),

          /// Sección de precios: Muestra el precio actual en rojo
          /// y el precio original tachado (si existe)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  product['price'],
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 6),
                if (product.containsKey('originalPrice'))
                  Flexible(
                    child: Text(
                      product['originalPrice'],
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
            ),
          ),

          /// Nombre del producto: Limitado a 2 líneas con ellipsis
          /// si el texto es demasiado largo
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Text(
              product['name'],
              style: const TextStyle(
                fontSize: 11,
                color: Colors.black87,
                height: 1.2,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          /// Sección inferior: Controles de cantidad y botón de favorito
          /// Muestra controles +/- si hay items seleccionados, o botón de añadir si no hay items
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (showQuantityControls)
                  Row(
                    children: [
                      GestureDetector(
                        onTap: onRemove,
                        child: const Icon(Icons.remove_circle_outline,
                            size: 18, color: Colors.red),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Text('$quantity',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14)),
                      ),
                      GestureDetector(
                        onTap: onAdd,
                        child: const Icon(Icons.add_circle_outline,
                            size: 18, color: Colors.red),
                      ),
                    ],
                  )
                else
                  GestureDetector(
                    onTap: onAdd,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.add_shopping_cart,
                          size: 14, color: Colors.white),
                    ),
                  ),
                GestureDetector(
                  onTap: onToggleFavorite,
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
