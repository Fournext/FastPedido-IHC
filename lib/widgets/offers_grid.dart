import 'package:flutter/material.dart';
import 'offer_card.dart';

/// Widget que muestra una cuadrícula de tarjetas de ofertas.
/// Permite la interacción con cada oferta (añadir/remover del carrito, marcar como favorito).
class OffersGrid extends StatelessWidget {
  final List<Map<String, dynamic>> offers;  /// Lista de productos en oferta
  final Set<String> favorites;  /// Conjunto de IDs de productos marcados como favoritos
  final Map<String, int> quantities;  /// Mapa de cantidades seleccionadas por producto
  /// La clave es el ID del producto (nombre_precio)

  final void Function(String id) onAdd;  /// Callback cuando se añade un producto al carrito
  final void Function(String id) onRemove;  /// Callback cuando se remueve un producto del carrito  
  final void Function(String id) onToggleFavorite;/// Callback cuando se toggle el estado de favorito

  const OffersGrid({
    super.key,
    required this.offers,
    required this.favorites,
    required this.quantities,
    required this.onAdd,
    required this.onRemove,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: offers.length,
      itemBuilder: (context, i) {
        final offer = offers[i];
        final id = '${offer['name']}_${offer['price']}';
        final isFav = favorites.contains(id);
        final qty = quantities[id] ?? 0;

        return OfferCard(
          product: offer,
          isFavorite: isFav,
          quantity: qty,
          onAdd: () => onAdd(id),
          onRemove: () => onRemove(id),
          onToggleFavorite: () => onToggleFavorite(id),
        );
      },
    );
  }
}
