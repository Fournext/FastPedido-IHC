import 'package:flutter/material.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  Set<String> _favoriteProducts = {};
  Map<String, int> _productQuantities = {};

  // Lista extendida de ofertas (puedes agregar más productos aquí)
  final List<Map<String, dynamic>> allOffers = [
    {
      'name': 'Carne molida\nde segunda',
      'price': 'Bs. 48.38',
      'originalPrice': 'Bs. 59.00',
      'discount': '18%',
      'image': 'assets/images/ofertas/carnemolidasegunda.png',
    },
    {
      'name': 'Cereal Chocapic \nNestle Cja 540G',
      'price': 'Bs. 73.60',
      'originalPrice': 'Bs. 92.00',
      'discount': '20%',
      'image': 'assets/images/ofertas/chocapic400.png',
    },
    {
      'name': 'Gaseosa Coca Cola \nOriginal 2 L',
      'price': 'Bs. 12.33',
      'originalPrice': 'Bs. 13.70',
      'discount': '10%',
      'image': 'assets/images/ofertas/cocacola2l.png',
    },
    // Puedes agregar más ofertas aquí
    {
      'name': 'Aceite Oliva Kris \nExtra Virgen 1 L',
      'price': 'Bs. 186.44',
      'originalPrice': 'Bs. 236.00',
      'discount': '21%',
      'image': 'assets/images/ofertas/aceiteolivia.png', // Usar imagen temporal
    },
    {
      'name': 'Arroz Caisy \nGrano de Oro 5 kg',
      'price': 'Bs. 59,28',
      'originalPrice': 'Bs. 76.00',
      'discount': '23%',
      'image': 'assets/images/ofertas/arroz.png', // Usar imagen temporal
    },
    {
      'name': 'Pasta Dental Colgate \nCarbon Activado \n150 ml',
      'price': 'Bs. 35.99',
      'originalPrice': 'Bs. 43.90',
      'discount': '18%',
      'image': 'assets/images/ofertas/pastadental.png', // Usar imagen temporal
    },
  ];

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
            const Text(
              'Ofertas',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Barra de búsqueda
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Row(
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
                          hintText: 'Buscar ofertas...',
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
                    child: Center(
                      child: Icon(
                        Icons.filter_list,
                        color: Colors.grey[600],
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Header con información de ofertas
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red.shade400, Colors.red.shade600],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Icon(Icons.local_offer, color: Colors.white, size: 40),
                  const SizedBox(height: 12),
                  const Text(
                    '¡Ofertas Increíbles!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Descuentos de hasta 23% en productos seleccionados',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // Grid de productos en oferta
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: allOffers.length,
                itemBuilder: (context, index) {
                  return _buildOfferCard(allOffers[index]);
                },
              ),
            ),

            // Espaciado inferior para evitar que el último elemento quede pegado al borde
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildOfferCard(Map<String, dynamic> product) {
    final productId = '${product['name']}_${product['price']}';
    final isFavorite = _favoriteProducts.contains(productId);
    final quantity = _productQuantities[productId] ?? 0;
    final showQuantityControls = quantity > 0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen del producto con badge de descuento
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: Container(
                    width: double.infinity,
                    color: const Color.fromARGB(255, 254, 254, 254),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Image.asset(
                        product['image'],
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.shopping_bag,
                            size: 60,
                            color: Colors.grey[400],
                          );
                        },
                      ),
                    ),
                  ),
                ),
                // Badge de descuento
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
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

          // Información del producto
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Precios
                  Row(
                    children: [
                      Text(
                        product['price'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        product['originalPrice'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Nombre del producto
                  Expanded(
                    child: Text(
                      product['name'],
                      style: TextStyle(
                        fontSize: 11,
                        height: 1.2,
                        color: Colors.grey[800],
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Controles de cantidad y favorito
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (showQuantityControls)
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (quantity > 0) {
                                    _productQuantities[productId] =
                                        quantity - 1;
                                  }
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                child: const Icon(
                                  Icons.remove_circle_outline,
                                  size: 18,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '$quantity',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 6),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _productQuantities[productId] = quantity + 1;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                child: const Icon(
                                  Icons.add_circle_outline,
                                  size: 18,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        )
                      else
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _productQuantities[productId] = 1;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.red.withOpacity(0.3),
                                  spreadRadius: 0,
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.add_shopping_cart,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),

                      // Botón de favorito
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isFavorite) {
                              _favoriteProducts.remove(productId);
                            } else {
                              _favoriteProducts.add(productId);
                            }
                          });
                        },
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 20,
                          color: isFavorite ? Colors.red : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
