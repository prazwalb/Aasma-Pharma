import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;

// Medicine Data Model
class Medicine {
  final String id;
  final String name;
  final String genericName;
  final double price;
  final String imageUrl;
  final String category;
  final double rating;
  final bool isPrescriptionRequired;
  final bool inStock;
  final String manufacturer;
  final String description;
  final String dosage;
  final int quantity;

  Medicine({
    required this.id,
    required this.name,
    required this.genericName,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.rating = 0.0,
    this.isPrescriptionRequired = false,
    this.inStock = true,
    required this.manufacturer,
    required this.description,
    required this.dosage,
    this.quantity = 1,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      genericName: json['genericName']?.toString() ?? json['generic_name']?.toString() ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      imageUrl: json['imageUrl']?.toString() ?? json['image']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      isPrescriptionRequired: json['isPrescriptionRequired'] ?? json['prescription_required'] ?? false,
      inStock: json['inStock'] ?? json['in_stock'] ?? true,
      manufacturer: json['manufacturer']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      dosage: json['dosage']?.toString() ?? '',
      quantity: json['quantity'] ?? 1,
    );
  }

  Medicine copyWith({int? quantity}) {
    return Medicine(
      id: id,
      name: name,
      genericName: genericName,
      price: price,
      imageUrl: imageUrl,
      category: category,
      rating: rating,
      isPrescriptionRequired: isPrescriptionRequired,
      inStock: inStock,
      manufacturer: manufacturer,
      description: description,
      dosage: dosage,
      quantity: quantity ?? this.quantity,
    );
  }
}

// Cart Item Model
class CartItem {
  final Medicine medicine;
  int quantity;

  CartItem({required this.medicine, this.quantity = 1});

  double get totalPrice => medicine.price * quantity;
}

// User Profile Model
class UserProfile {
  final String name;
  final String email;
  final String phone;
  final String address;
  final String emergencyContact;

  UserProfile({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.emergencyContact,
  });
}

// Main App
class PharmaApp extends StatefulWidget {
  const PharmaApp({Key? key}) : super(key: key);

  @override
  State<PharmaApp> createState() => _PharmaAppState();
}

class _PharmaAppState extends State<PharmaApp> {
  int _currentIndex = 0;
  List<CartItem> _cartItems = [];
  UserProfile _userProfile = UserProfile(
    name: 'John Doe',
    email: 'john.doe@email.com',
    phone: '+1 234 567 8900',
    address: '123 Main St, City, State 12345',
    emergencyContact: '+1 234 567 8901',
  );

  void _addToCart(Medicine medicine) {
    setState(() {
      final existingItemIndex = _cartItems.indexWhere((item) => item.medicine.id == medicine.id);
      
      if (existingItemIndex >= 0) {
        _cartItems[existingItemIndex].quantity++;
      } else {
        _cartItems.add(CartItem(medicine: medicine));
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${medicine.name} added to cart'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _removeFromCart(String medicineId) {
    setState(() {
      _cartItems.removeWhere((item) => item.medicine.id == medicineId);
    });
  }

  void _updateCartQuantity(String medicineId, int quantity) {
    setState(() {
      final itemIndex = _cartItems.indexWhere((item) => item.medicine.id == medicineId);
      if (itemIndex >= 0) {
        if (quantity <= 0) {
          _cartItems.removeAt(itemIndex);
        } else {
          _cartItems[itemIndex].quantity = quantity;
        }
      }
    });
  }

  double get _cartTotal {
    return _cartItems.fold(0.0, (total, item) => total + item.totalPrice);
  }

  int get _cartItemCount {
    return _cartItems.fold(0, (total, item) => total + item.quantity);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(onAddToCart: _addToCart),
      CartPage(
        cartItems: _cartItems,
        onRemoveFromCart: _removeFromCart,
        onUpdateQuantity: _updateCartQuantity,
        cartTotal: _cartTotal,
      ),
      ProfilePage(userProfile: _userProfile),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue[600],
        unselectedItemColor: Colors.grey,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                const Icon(Icons.shopping_cart),
                if (_cartItemCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                      child: Text(
                        '$_cartItemCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// Home Page
class HomePage extends StatefulWidget {
  final Function(Medicine) onAddToCart;

  const HomePage({Key? key, required this.onAddToCart}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<Medicine> _filteredMedicines = [];
  List<Medicine> _medicines = [];
  bool _isLoading = true;
  String? _errorMessage;

  final List<String> _categories = [
    'All',
    'Pain Relief',
    'Antibiotics',
    'Vitamins',
    'Heart',
    'Diabetes',
    'Skin Care',
  ];

  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    _loadMedicines();
  }

  Future<void> _loadMedicines() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      // Sample pharma data - replace with your API/JSON
      final List<Medicine> medicines = [
        Medicine(
          id: '1',
          name: 'Paracetamol 500mg',
          genericName: 'Acetaminophen',
          price: 5.99,
          imageUrl: 'https://via.placeholder.com/150x150/4285F4/FFFFFF?text=PAR',
          category: 'Pain Relief',
          rating: 4.5,
          manufacturer: 'PharmaCorp',
          description: 'Effective pain relief and fever reducer',
          dosage: '500mg - Take 1-2 tablets every 4-6 hours',
        ),
        Medicine(
          id: '2',
          name: 'Amoxicillin 250mg',
          genericName: 'Amoxicillin',
          price: 12.99,
          imageUrl: 'https://via.placeholder.com/150x150/34A853/FFFFFF?text=AMX',
          category: 'Antibiotics',
          rating: 4.3,
          isPrescriptionRequired: true,
          manufacturer: 'MediPharm',
          description: 'Antibiotic for bacterial infections',
          dosage: '250mg - Take 3 times daily with food',
        ),
        Medicine(
          id: '3',
          name: 'Vitamin D3 1000IU',
          genericName: 'Cholecalciferol',
          price: 8.99,
          imageUrl: 'https://via.placeholder.com/150x150/EA4335/FFFFFF?text=VD3',
          category: 'Vitamins',
          rating: 4.7,
          manufacturer: 'HealthPlus',
          description: 'Essential vitamin for bone health',
          dosage: '1000IU - Take 1 tablet daily',
        ),
        Medicine(
          id: '4',
          name: 'Lisinopril 10mg',
          genericName: 'Lisinopril',
          price: 15.99,
          imageUrl: 'https://via.placeholder.com/150x150/FBBC04/FFFFFF?text=LIS',
          category: 'Heart',
          rating: 4.2,
          isPrescriptionRequired: true,
          manufacturer: 'CardioMed',
          description: 'ACE inhibitor for high blood pressure',
          dosage: '10mg - Take once daily',
        ),
        Medicine(
          id: '5',
          name: 'Metformin 500mg',
          genericName: 'Metformin HCl',
          price: 18.99,
          imageUrl: 'https://via.placeholder.com/150x150/9C27B0/FFFFFF?text=MET',
          category: 'Diabetes',
          rating: 4.4,
          isPrescriptionRequired: true,
          manufacturer: 'DiabetesCare',
          description: 'Type 2 diabetes management',
          dosage: '500mg - Take twice daily with meals',
        ),
        Medicine(
          id: '6',
          name: 'Hydrocortisone Cream',
          genericName: 'Hydrocortisone',
          price: 7.99,
          imageUrl: 'https://via.placeholder.com/150x150/FF9800/FFFFFF?text=HYD',
          category: 'Skin Care',
          rating: 4.1,
          manufacturer: 'DermaCare',
          description: 'Topical steroid for skin inflammation',
          dosage: 'Apply thin layer 2-3 times daily',
        ),
      ];

      setState(() {
        _medicines = medicines;
        _filteredMedicines = medicines;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error loading medicines: $e';
        _isLoading = false;
      });
    }
  }

  void _filterMedicines() {
    setState(() {
      _filteredMedicines = _medicines.where((medicine) {
        final matchesCategory = _selectedCategory == 'All' || 
                               medicine.category == _selectedCategory;
        final matchesSearch = medicine.name.toLowerCase()
                             .contains(_searchController.text.toLowerCase()) ||
                             medicine.genericName.toLowerCase()
                             .contains(_searchController.text.toLowerCase());
        return matchesCategory && matchesSearch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        elevation: 0,
        title: const Text(
          'PharmaStore',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.favorite_outline, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blue[600],
            child: TextField(
              controller: _searchController,
              onChanged: (value) => _filterMedicines(),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search medicines...',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                prefixIcon: Icon(Icons.search, color: Colors.white.withOpacity(0.7)),
                filled: true,
                fillColor: Colors.white.withOpacity(0.2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          
          // Categories
          Container(
            height: 50,
            color: Colors.white,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = category == _selectedCategory;
                
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategory = category;
                    });
                    _filterMedicines();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 12, top: 8, bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue[600] : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? Colors.blue[600]! : Colors.grey[300]!,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Medicines Grid
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _errorMessage != null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error_outline, size: 48, color: Colors.red[300]),
                            const SizedBox(height: 16),
                            Text(_errorMessage!, textAlign: TextAlign.center),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: _loadMedicines,
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      )
                    : _filteredMedicines.isEmpty
                        ? const Center(child: Text('No medicines found'))
                        : RefreshIndicator(
                            onRefresh: _loadMedicines,
                            child: GridView.builder(
                              padding: const EdgeInsets.all(16),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.7,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                              ),
                              itemCount: _filteredMedicines.length,
                              itemBuilder: (context, index) {
                                final medicine = _filteredMedicines[index];
                                return _buildMedicineCard(medicine);
                              },
                            ),
                          ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicineCard(Medicine medicine) {
    return GestureDetector(
      onTap: () => _showMedicineDetails(medicine),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Medicine Image
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      image: DecorationImage(
                        image: NetworkImage(medicine.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (medicine.isPrescriptionRequired)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Rx',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  if (!medicine.inStock)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                        ),
                        child: const Center(
                          child: Text(
                            'OUT OF STOCK',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            
            // Medicine Info
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      medicine.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      medicine.genericName,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[600],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      medicine.manufacturer,
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.grey[500],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${medicine.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.blue,
                          ),
                        ),
                        if (medicine.inStock)
                          GestureDetector(
                            onTap: () => widget.onAddToCart(medicine),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.blue[600],
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 16,
                              ),
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
      ),
    );
  }

  void _showMedicineDetails(Medicine medicine) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Medicine Image
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(medicine.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Medicine Details
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                medicine.name,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                medicine.genericName,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (medicine.isPrescriptionRequired)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.red[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Prescription Required',
                              style: TextStyle(
                                color: Colors.red[700],
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Price and Stock
                    Row(
                      children: [
                        Text(
                          '\$${medicine.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: medicine.inStock ? Colors.green[100] : Colors.red[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            medicine.inStock ? 'In Stock' : 'Out of Stock',
                            style: TextStyle(
                              color: medicine.inStock ? Colors.green[700] : Colors.red[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Manufacturer
                    _buildDetailRow('Manufacturer', medicine.manufacturer),
                    _buildDetailRow('Dosage', medicine.dosage),
                    
                    if (medicine.rating > 0) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text('Rating: ', style: TextStyle(fontWeight: FontWeight.w500)),
                          Icon(Icons.star, color: Colors.amber, size: 20),
                          Text(' ${medicine.rating}'),
                        ],
                      ),
                    ],
                    
                    const SizedBox(height: 16),
                    
                    // Description
                    const Text(
                      'Description',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      medicine.description,
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Add to Cart Button
                    if (medicine.inStock)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            widget.onAddToCart(medicine);
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[600],
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Add to Cart',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

// Cart Page
class CartPage extends StatelessWidget {
  final List<CartItem> cartItems;
  final Function(String) onRemoveFromCart;
  final Function(String, int) onUpdateQuantity;
  final double cartTotal;

  const CartPage({
    Key? key,
    required this.cartItems,
    required this.onRemoveFromCart,
    required this.onUpdateQuantity,
    required this.cartTotal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        title: const Text(
          'Shopping Cart',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Your cart is empty',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Add some medicines to get started',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartItems[index];
                      return _buildCartItem(context, cartItem);
                    },
                  ),
                ),
                _buildCartSummary(context),
              ],
            ),
    );
  }

  Widget _buildCartItem(BuildContext context, CartItem cartItem) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Medicine Image
          Container(
            width: 80,

            // ...continuation of CartPage widget...

            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(cartItem.medicine.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.medicine.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  cartItem.medicine.genericName,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => onUpdateQuantity(
                          cartItem.medicine.id, cartItem.quantity - 1),
                      icon: const Icon(Icons.remove_circle_outline),
                    ),
                    Text(
                      cartItem.quantity.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () => onUpdateQuantity(
                          cartItem.medicine.id, cartItem.quantity + 1),
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                '\$${cartItem.totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () => onRemoveFromCart(cartItem.medicine.id),
                icon: const Icon(Icons.delete_outline, color: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCartSummary(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Total',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              Text(
                '\$${cartTotal.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Checkout functionality coming soon!'),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[600],
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Checkout',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Profile Page (basic implementation)
class ProfilePage extends StatelessWidget {
  final UserProfile userProfile;

  const ProfilePage({Key? key, required this.userProfile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileItem('Name', userProfile.name),
            _buildProfileItem('Email', userProfile.email),
            _buildProfileItem('Phone', userProfile.phone),
            _buildProfileItem('Address', userProfile.address),
            _buildProfileItem('Emergency Contact', userProfile.emergencyContact),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
