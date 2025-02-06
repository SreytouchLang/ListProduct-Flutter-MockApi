// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';
import 'product_detail_screen.dart'; // Import the new detail screen

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = ApiService().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product List")),
      body: FutureBuilder<List<Product>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No products available"));
          } else {
            List<Product> products = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(10.0),  // Add padding around the entire GridView
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns in the grid
                  crossAxisSpacing: 10, // Horizontal space between items
                  mainAxisSpacing: 10, // Vertical space between items
                  childAspectRatio: 0.75, // Aspect ratio of each grid item
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  Product product = products[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigate to the product detail screen when tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(product: product),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 5, // Optional: Add a shadow effect to each card
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Image.network(
                                product.image,
                                height: 120, // Set a fixed height for images
                                fit: BoxFit.cover, // Ensure the image fits well
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              product.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '\$${product.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700], // Use a lighter color for price
                              ),
                            ),

                            SizedBox(height: 4),
                            Text(
                              product.description,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700], // Use a lighter color for description
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            );
          }
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import '../models/product.dart';
// import '../services/api_service.dart';

// class ProductListScreen extends StatefulWidget {
//   const ProductListScreen({super.key});

//   @override
//   _ProductListScreenState createState() => _ProductListScreenState();
// }

// class _ProductListScreenState extends State<ProductListScreen> {
//   late Future<List<Product>> futureProducts;

//   @override
//   void initState() {
//     super.initState();
//     futureProducts = ApiService().fetchProducts();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Product List")),
//       body: FutureBuilder<List<Product>>(
//         future: futureProducts,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text("Error: ${snapshot.error}"));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text("No products available"));
//           } else {
//             List<Product> products = snapshot.data!;
//             return ListView.builder(
//               itemCount: products.length,
//               itemBuilder: (context, index) {
//                 Product product = products[index];
//                 return ListTile(
//                   leading: Image.network(product.image, width: 90),
//                   title: Text(
//                     product.title,
//                     maxLines: 1,                          // Limit the description to 3 lines
//                     overflow: TextOverflow.ellipsis,    
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,    // Makes the text bold
//                       fontSize: 16,                   // Optional: Adjust font size as needed
//                       color: Colors.black,            // Optional: Set the text color
//                     ),
//                   ),
//                   subtitle: Text(
//                     product.description,
//                     maxLines: 3,                          // Limit the description to 3 lines
//                     overflow: TextOverflow.ellipsis,      // Show '...' if the text exceeds 3 lines
//                     style: TextStyle(
//                       fontSize: 14,                       // Optional: You can style the text as needed
//                       color: Colors.black,                // Optional: Set the text color
//                     ),
//                   ),
//                 ); 
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
