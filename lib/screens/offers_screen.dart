import 'package:flutter/material.dart';
import 'package:fast_pedido/data/products_data.dart';
import 'package:fast_pedido/widgets/custom_appbar.dart';
import 'package:fast_pedido/widgets/offer_header.dart';
import 'package:fast_pedido/widgets/offers_grid.dart';
import 'package:fast_pedido/widgets/search_bar.dart';
import 'package:fast_pedido/widgets/bottom_menu.dart';
import 'package:fast_pedido/screens/dashboard_screen.dart';

/// Pantalla que muestra las ofertas disponibles en la aplicación.
/// Permite a los usuarios ver, buscar, añadir al carrito y marcar ofertas como favoritas.
class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  final Set<String> _favorites = {};/// Conjunto de IDs de productos marcados como favoritos

  /// Mapa que almacena la cantidad seleccionada de cada producto
  /// La clave es el ID del producto (nombre_precio)
  /// El valor es la cantidad seleccionada
  final Map<String, int> _quantities = {};

  final offers = ProductsData.allOffers;/// Lista de todas las ofertas disponibles

  String _query = '';  /// Texto actual en la barra de búsqueda
  String _selectedMenu = '';/// Ítem seleccionado en el menú inferior

  /// Calcula el número total de items en el carrito
  /// Suma todas las cantidades de productos seleccionados
  int get _cartItemCount =>
      _quantities.values.fold(0, (sum, qty) => sum + qty);

  @override
  Widget build(BuildContext context) {
    /// Filtra las ofertas basado en el texto de búsqueda
    /// Convierte tanto el nombre del producto como la búsqueda a minúsculas
    /// para hacer la búsqueda insensible a mayúsculas/minúsculas
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

       //  Menú inferior funcional
      bottomNavigationBar: BottomMenu(
        selected: _selectedMenu,
        /// Muestra el número de items en el carrito como badge
        /// Si no hay items, no muestra ningún badge (null)
        cartBadge: _cartItemCount > 0 ? _cartItemCount : null,

        /// Navega a la pantalla de favoritos y pasa los productos marcados
        /// como favoritos como argumentos
        onFavorites: () {
          setState(() => _selectedMenu = 'favorites');
          Navigator.pushNamed(context, '/favorites', arguments: {
            'dashboardFavorites': _favorites.toList(),
            'dashboardFavoriteProducts': offers
                .where((p) => _favorites
                    .contains('${p['name']}_${p['price']}'))
                .toList(),
          });
        },

        /// Navega al dashboard principal (pantalla de delivery)
        /// Usa pushReplacement para reemplazar la pantalla actual en el stack
        /// de navegación
        onDelivery: () {
          setState(() => _selectedMenu = 'delivery');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const DashboardScreen()),
          );
        },

        /// Navega a la pantalla del carrito y pasa los productos seleccionados
        /// como argumentos, incluyendo sus cantidades
        onCart: () {
          setState(() => _selectedMenu = 'cart');
          final cartProducts = offers
              .where((p) =>
                  (_quantities['${p['name']}_${p['price']}'] ?? 0) > 0)
              .map((p) => {
                    'name': p['name'],
                    'price': p['price'],
                    'image': p['image'],
                    'quantity': _quantities['${p['name']}_${p['price']}'],
                  })
              .toList();
          Navigator.pushNamed(context, '/cart', arguments: {
            'dashboardProducts': cartProducts,
            'dashboardFavoriteProducts': [],
            'currentPoints': 0,
          });
        },

        /// Navega a la pantalla de perfil del usuario
        onProfile: () {
          setState(() => _selectedMenu = 'profile');
          Navigator.pushNamed(context, '/profile');
        },
      ),
    );
  }
}
