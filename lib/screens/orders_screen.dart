import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int _cartItemCount = 2;
  int _expandedOrderIndex = -1;

  final List<Map<String, dynamic>> orders = [
    {
      'orderNumber': '116452',
      'branch': 'Sucursal: Hiper del 2do anillo',
      'requestDate': '15-10-2025',
      'deliveryDate': '08-11-2025',
      'deliveryTime': '17:00',
      'products': [
        {
          'name': 'Coca Cola 3 lts',
          'price': 'Bs. 45',
          'weight': '15 bs',
          'quantity': 3,
        },
        {
          'name':
              'Papel Higiénico Scott de 3 Capas\nFull algodón de 6 unidades',
          'price': 'Bs. 30',
          'weight': '15 bs',
          'quantity': 2,
        },
      ],
      'totalPartial': 'Bs. 75',
      'shippingCost': 'Bs. 10',
      'totalCost': 'Bs. 85',
    },
    {
      'orderNumber': '116452',
      'branch': 'Sucursal: Hiper del 2do anillo',
      'requestDate': '08-09-2025',
      'deliveryDate': '10-09-2025',
      'deliveryTime': '09:30',
      'products': [
        {
          'name': 'Leche Pil 1L',
          'price': 'Bs. 12',
          'weight': '10 bs',
          'quantity': 2,
        },
      ],
      'totalPartial': 'Bs. 24',
      'shippingCost': 'Bs. 8',
      'totalCost': 'Bs. 32',
    },
    {
      'orderNumber': '116452',
      'branch': 'Sucursal: Hiper del 2do anillo',
      'requestDate': '04-07-2025',
      'deliveryDate': '06-07-2025',
      'deliveryTime': '14:00',
      'products': [
        {
          'name': 'Arroz Superior 1kg',
          'price': 'Bs. 18',
          'weight': '12 bs',
          'quantity': 1,
        },
        {
          'name': 'Aceite 123 500ml',
          'price': 'Bs. 25',
          'weight': '8 bs',
          'quantity': 1,
        },
      ],
      'totalPartial': 'Bs. 43',
      'shippingCost': 'Bs. 12',
      'totalCost': 'Bs. 55',
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
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Center(
          child: Text(
            'Pedidos',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        actions: [
          Container(width: 48), // Para centrar el título
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            return _buildOrderCard(orders[index], index);
          },
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 10,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBottomNavItem(
                Icons.favorite_border,
                'Favoritos',
                false,
                () {
                  Navigator.pushReplacementNamed(context, '/favorites');
                },
              ),
              _buildBottomNavItem(Icons.motorcycle, 'Delivery', true, () {
                // Ya estamos en delivery/pedidos
              }),
              _buildBottomNavItem(
                Icons.shopping_cart_outlined,
                'Carrito',
                false,
                () {
                  Navigator.pushReplacementNamed(context, '/cart');
                },
                badge: _cartItemCount,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order, int index) {
    final isExpanded = _expandedOrderIndex == index;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header del pedido (siempre visible)
          GestureDetector(
            onTap: () {
              setState(() {
                _expandedOrderIndex = isExpanded ? -1 : index;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Nro: ${order['orderNumber']}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: Colors.black54,
                        size: 24,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    order['branch'],
                    style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Fecha de solicitud: ${order['requestDate']}',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              'Fecha de entrega: ${order['deliveryDate']}',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Hora de entrega: ${order['deliveryTime']}',
                        style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Contenido desplegable
          if (isExpanded) ...[
            const Divider(height: 1, color: Colors.grey),
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Iconos de estado
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatusIcon(Icons.shopping_cart, 'Pedido', true),
                      _buildStatusIcon(Icons.cached, 'Proceso', true),
                      _buildStatusIcon(Icons.local_shipping, 'Envío', true),
                      _buildStatusIcon(Icons.check_circle, 'Entregado', false),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Lista de productos
                  ...order['products']
                      .map<Widget>((product) => _buildProductItem(product))
                      .toList(),
                  const SizedBox(height: 16),
                  // Botón y totales
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Lógica para volver a pedir
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Volver a pedir',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.yellow[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Total Parcial: ${order['totalPartial']}',
                              style: const TextStyle(fontSize: 11),
                            ),
                            Text(
                              'Costo de envío: ${order['shippingCost']}',
                              style: const TextStyle(fontSize: 11),
                            ),
                            Text(
                              'Costo Total: ${order['totalCost']}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatusIcon(IconData icon, String label, bool isActive) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isActive ? Colors.red : Colors.grey[300],
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 20,
            color: isActive ? Colors.white : Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: isActive ? Colors.black87 : Colors.grey[600],
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildProductItem(Map<String, dynamic> product) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['name'],
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      'Precio: ${product['weight']}',
                      style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Cantidad: ${product['quantity']}',
                      style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            product['price'],
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(
    IconData icon,
    String label,
    bool isSelected,
    VoidCallback onTap, {
    int? badge,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.red : Colors.grey[200],
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey[600],
              size: 28,
            ),
            if (badge != null && badge > 0)
              Positioned(
                right: -8,
                top: -8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 20,
                    minHeight: 20,
                  ),
                  child: Center(
                    child: Text(
                      '$badge',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
