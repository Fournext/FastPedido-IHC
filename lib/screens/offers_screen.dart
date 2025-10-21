import 'package:flutter/material.dart';
import 'package:fast_pedido/data/products_data.dart';
import 'package:fast_pedido/widgets/custom_appbar.dart';
import 'package:fast_pedido/widgets/offer_header.dart';
import 'package:fast_pedido/widgets/offers_grid.dart';
import 'package:fast_pedido/widgets/search_bar.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  final Set<String> _favorites = {};
  final Map<String, int> _quantities = {};
  final offers = ProductsData.allOffers;

  String _query = '';

  @override
  Widget build(BuildContext context) {
    final filteredOffers = offers
        .where((p) =>
            p['name'].toString().toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: const CustomAppBar(title: 'Ofertas'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Barra de búsqueda reutilizable con icono de filtro
            SearchBarWidget(
              hintText: 'Buscar ofertas...',
              onChanged: (text) => setState(() => _query = text),
              onFilterPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Filtros disponibles próximamente'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),

            const OfferHeader(
              title: '¡Ofertas Increíbles!',
              subtitle: 'Descuentos de hasta 23%',
            ),
            const SizedBox(height: 16),

            //  Grid de ofertas filtradas
            Expanded(
              child: OffersGrid(
                offers: filteredOffers,
                favorites: _favorites,
                quantities: _quantities,
                onAdd: (id) => setState(() {
                  _quantities[id] = (_quantities[id] ?? 0) + 1;
                }),
                onRemove: (id) => setState(() {
                  final current = _quantities[id] ?? 0;
                  if (current > 0) _quantities[id] = current - 1;
                }),
                onToggleFavorite: (id) => setState(() {
                  _favorites.contains(id)
                      ? _favorites.remove(id)
                      : _favorites.add(id);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
