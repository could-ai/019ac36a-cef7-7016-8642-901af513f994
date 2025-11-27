import 'package:flutter/material.dart';
import 'package:supermarket_app/models/product_model.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final List<Product> _products = [
    Product(id: '1', name: 'Apple', price: 1.5, quantity: 100, qrCode: '123456789'),
    Product(id: '2', name: 'Banana', price: 0.5, quantity: 150),
    Product(id: '3', name: 'Milk', price: 2.5, quantity: 50, qrCode: '987654321'),
    Product(id: '4', name: 'Bread', price: 2.0, quantity: 75),
  ];

  void _showProductDialog({Product? product}) {
    final nameController = TextEditingController(text: product?.name);
    final priceController = TextEditingController(text: product?.price.toString());
    final quantityController = TextEditingController(text: product?.quantity.toString());
    final qrController = TextEditingController(text: product?.qrCode);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(product == null ? 'Add Product' : 'Edit Product'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Product Name')),
                TextField(controller: priceController, decoration: const InputDecoration(labelText: 'Price'), keyboardType: TextInputType.number),
                TextField(controller: quantityController, decoration: const InputDecoration(labelText: 'Quantity'), keyboardType: TextInputType.number),
                TextField(controller: qrController, decoration: const InputDecoration(labelText: 'QR Code (Optional)')),
                IconButton(
                  icon: const Icon(Icons.qr_code_scanner),
                  onPressed: () {
                    // QR scanner logic goes here
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('QR Scanner not implemented yet.')),
                    );
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (product == null) {
                    _products.add(Product(
                      id: DateTime.now().toString(),
                      name: nameController.text,
                      price: double.tryParse(priceController.text) ?? 0.0,
                      quantity: int.tryParse(quantityController.text) ?? 0,
                      qrCode: qrController.text.isNotEmpty ? qrController.text : null,
                    ));
                  } else {
                    product.name = nameController.text;
                    product.price = double.tryParse(priceController.text) ?? 0.0;
                    product.quantity = int.tryParse(quantityController.text) ?? 0;
                  }
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteProduct(String id) {
    setState(() {
      _products.removeWhere((p) => p.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('Price: \$${product.price.toStringAsFixed(2)} - Quantity: ${product.quantity}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _showProductDialog(product: product),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteProduct(product.id),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showProductDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
