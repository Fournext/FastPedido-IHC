import 'package:flutter/material.dart';
import 'package:fast_pedido/widgets/product_card.dart';

/// Pantalla que muestra los productos recomendados en una cuadrícula.
/// Permite buscar productos, filtrarlos, añadirlos al carrito y marcarlos como favoritos.
class RecommendedScreen extends StatefulWidget {
  /// Título de la sección de recomendados
  final String title;

  /// Lista de productos recomendados con sus detalles
  /// Cada producto es un Map que contiene nombre, precio, imagen, etc.
  final List<Map<String, dynamic>> products;

  const RecommendedScreen({
    super.key,
    required this.title,
    required this.products,
  });

  @override
  State<RecommendedScreen> createState() => _RecommendedScreenState();
}

class _RecommendedScreenState extends State<RecommendedScreen> {
  /// Conjunto que almacena los IDs de los productos marcados como favoritos
  /// El ID se forma concatenando el nombre y precio del producto
  Set<String> _favoriteProducts = {};

  /// Mapa que almacena la cantidad seleccionada de cada producto
  /// La clave es el ID del producto (nombre_precio)
  /// El valor es la cantidad seleccionada
  Map<String, int> _productQuantities = {};

  /// Lista de productos visibles en la pantalla
  /// Se inicializa con todos los productos disponibles
  late List<Map<String, dynamic>> _visible;

  @override
  void initState() {
    super.initState();
    _visible = List.from(widget.products); //  muestra todos los productos
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 70,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 45,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.delivery_dining,
                    color: Colors.white,
                    size: 24,
                  ),
                );
              },
            ),
            const SizedBox(width: 10),
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
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Barra de búsqueda
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Buscar productos...',
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
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
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
                ],
              ),
              const SizedBox(height: 16),

              // Título “Productos Recomendados”
              const Text(
                'Productos Recomendados',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),

              // Grid con todos los productos
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemCount: _visible.length,
                itemBuilder: (context, index) {
                  final product = _visible[index];
                  final productId = '${product['name']}_${product['price']}';
                  final isFavorite = _favoriteProducts.contains(productId);
                  final quantity = _productQuantities[productId] ?? 0;

                  /// Renderiza una tarjeta de producto con sus controles
                  /// - Muestra imagen, nombre y precio del producto
                  /// - Permite añadir/quitar del carrito
                  /// - Permite marcar/desmarcar como favorito
                  return ProductCard(
                    product: product,
                    fullWidth: false,
                    quantity: quantity,
                    isFavorite: isFavorite,
                    /// Callback cuando se añade un producto al carrito
                    /// Incrementa la cantidad y muestra una notificación
                    onAdd: () {
                      setState(() {
                        _productQuantities[productId] = quantity + 1;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${product['name']} agregado al carrito',
                          ),
                          duration: const Duration(seconds: 1),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                    /// Callback cuando se remueve un producto del carrito
                    /// Decrementa la cantidad o remueve el producto si la cantidad es 1
                    onRemove: () {
                      setState(() {
                        if (quantity > 1) {
                          _productQuantities[productId] = quantity - 1;
                        } else {
                          _productQuantities.remove(productId);
                        }
                      });
                    },
                    /// Callback para alternar el estado de favorito del producto
                    /// Añade o remueve el producto del conjunto de favoritos
                    onToggleFavorite: () {
                      setState(() {
                        if (isFavorite) {
                          _favoriteProducts.remove(productId);
                        } else {
                          _favoriteProducts.add(productId);
                        }
                      });
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ProductCard is used from widgets/product_card.dart
}
