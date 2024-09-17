import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ahmedadmin/models/delivery.dart';
import 'package:ahmedadmin/models/expense.dart';
import 'package:ahmedadmin/models/product.dart';
import 'package:ahmedadmin/models/purchase.dart';
import 'package:ahmedadmin/models/sale.dart';
import 'package:ahmedadmin/screens/balance_sheet_page.dart';
import 'package:ahmedadmin/screens/delivery_table_page.dart';
import 'package:ahmedadmin/screens/expense_table_page.dart';
import 'package:ahmedadmin/screens/forms/damaged_product_form.dart';
import 'package:ahmedadmin/screens/forms/delivery_form.dart';
import 'package:ahmedadmin/screens/forms/expense_form.dart';
import 'package:ahmedadmin/screens/forms/purchase_form.dart';
import 'package:ahmedadmin/screens/forms/sales_form.dart';
import 'package:ahmedadmin/screens/purchase_table_page.dart';
import 'package:ahmedadmin/screens/sale_table_page.dart';
import 'package:ahmedadmin/screens/stock_remaining_detail_page.dart';
import 'package:ahmedadmin/services/delivery_service.dart';
import 'package:ahmedadmin/services/expense_service.dart';
import 'package:ahmedadmin/services/product_service.dart';
import 'package:ahmedadmin/services/purchase_service.dart';
import 'package:ahmedadmin/services/sales_service.dart';

class MobileReportPage extends StatelessWidget {
  MobileReportPage({super.key});
  final ProductService productService = ProductService();
  final SalesService salesService = SalesService();
  final ExpenseService expenseService = ExpenseService();
  final DeliveryService deliveryService = DeliveryService();
  final PurchaseService purchaseService = PurchaseService();

  double _calculateSalesTotalValue(List<Sale> sales) {
    return sales.fold(
        0, (sum, sale) => sum + (sale.pricePerUnit * sale.quantity));
  }

  double _calculatePurchasesTotalValue(List<Purchase> purchases) {
    return purchases.fold(0,
        (sum, purchase) => sum + (purchase.pricePerUnit * purchase.quantity));
  }

  int _countDeliveriesByStatus(List<Delivery> deliveries, String status) {
    return deliveries.where((delivery) => delivery.status == status).length;
  }

  double _calculateExpensesTotalValue(List<Expense> expenses) {
    return expenses.fold(0, (sum, expense) => sum + expense.amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ResponsiveGridView(
          children: [
            _buildBalanceSheetCard(context),
            _buildPurchaseCard(context),
            _buildSaleCard(context),
            _buildExpenseCard(context),
            _buildDeliveryCard(context),
            _buildStockRemainCard(context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        onPressed: () => _showBottomSheet(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBalanceSheetCard(BuildContext context) {
    return StreamBuilder<List<Sale>>(
      stream: salesService.getSales(),
      builder: (context, salesSnapshot) {
        return StreamBuilder<List<Expense>>(
          stream: expenseService.getExpenses(),
          builder: (context, expenseSnapshot) {
            if (salesSnapshot.connectionState == ConnectionState.waiting ||
                expenseSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (salesSnapshot.hasError || expenseSnapshot.hasError) {
              return Center(
                child: Text(
                  'Failed to load data: Sales: ${salesSnapshot.error}, Expenses: ${expenseSnapshot.error}',
                ),
              );
            }

            final sales = salesSnapshot.data ?? [];
            final expenses = expenseSnapshot.data ?? [];
            final totalSalesValue = _calculateSalesTotalValue(sales);
            final totalExpensesValue = _calculateExpensesTotalValue(expenses);
            final netAmount = totalSalesValue - totalExpensesValue;

            return BalanceSheetCard(
              color: netAmount > 0
                  ? Colors.green.withOpacity(0.7)
                  : netAmount < 0
                      ? Colors.red.withOpacity(0.7)
                      : Colors.grey,
              value: netAmount,
              icon: Icons.account_balance,
              title: 'ከወጪ ቀሪ',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BalanceSheetPage(
                      sales: sales,
                      expenses: expenses,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildPurchaseCard(BuildContext context) {
    return StreamBuilder<List<Purchase>>(
      stream: purchaseService.getPurchases(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
              child: Text('Failed to load purchases: ${snapshot.error}'));
        }

        final purchases = snapshot.data ?? [];
        final totalValue = _calculatePurchasesTotalValue(purchases);

        return DashboardCard(
          title: 'ግዢ',
          value: totalValue,
          icon: Icons.shopping_cart,
          color: Colors.orange.withOpacity(0.7),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PurchaseTablePage(
                  title: 'ግዢ',
                  purchases: purchases,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSaleCard(BuildContext context) {
    return StreamBuilder<List<Sale>>(
      stream: salesService.getSales(),
      builder: (context, salesSnapshot) {
        if (salesSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (salesSnapshot.hasError) {
          return Center(
              child: Text('Failed to load sales: ${salesSnapshot.error}'));
        }

        final sales = salesSnapshot.data ?? [];
        final totalValue = _calculateSalesTotalValue(sales);

        return StreamBuilder<List<Product>>(
          stream: productService.getProducts(),
          builder: (context, productSnapshot) {
            if (productSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (productSnapshot.hasError) {
              return Center(
                  child: Text(
                      'Failed to load products: ${productSnapshot.error}'));
            }

            final products = productSnapshot.data ?? [];

            return DashboardCard(
              title: 'ሽያጭ',
              value: totalValue,
              icon: Icons.sell,
              color: Colors.purple.withOpacity(0.7),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SaleTablePage(
                      title: 'ሽያጭ',
                      sales: sales,
                      products: products,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildExpenseCard(BuildContext context) {
    return StreamBuilder<List<Expense>>(
      stream: expenseService.getExpenses(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
              child: Text('Failed to load expenses: ${snapshot.error}'));
        }

        final expenses = snapshot.data ?? [];
        final totalValue = _calculateExpensesTotalValue(expenses);

        return DashboardCard(
          title: 'ወጪ',
          value: totalValue,
          icon: Icons.monetization_on,
          color: Colors.pink.withOpacity(0.7),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ExpenseTablePage(
                  expenses: expenses,
                  title: 'ወጪ',
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDeliveryCard(BuildContext context) {
    return StreamBuilder<List<Delivery>>(
      stream: deliveryService.getDeliveries(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
              child: Text('Failed to load deliveries: ${snapshot.error}'));
        }

        final deliveries = snapshot.data ?? [];

        return DeliveryCard(
          title: 'መኪናዎች',
          value: deliveries.length,
          icon: Icons.local_shipping,
          color: Colors.blue.withOpacity(0.7),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DeliveryTablePage(
                  deliveries: deliveries,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildStockRemainCard(BuildContext context) {
    return StreamBuilder<List<Product>>(
      stream: productService.getProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
              child: Text('Failed to load products: ${snapshot.error}'));
        }

        final products = snapshot.data ?? [];

        return StockRemain(
          title: 'መጋዘን ውስጥ የቀረ',
          icon: Icons.inventory,
          color: Colors.teal.withOpacity(0.7),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StockRemainingDetailPage(
                  products: products,
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'ማስገባት የሚፈልጉትን ይምረጡ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildBottomSheetButton(context, 'ግዢ አስገባ', () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PurchaseForm()),
                );
              }),
              _buildBottomSheetButton(context, 'ሽያጭ አስገባ', () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SalesForm()),
                );
              }),
              _buildBottomSheetButton(context, 'ወጪ አስገባ', () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ExpenseForm()),
                );
              }),
              _buildBottomSheetButton(context, 'የጫነ መኪና አስገባ', () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DeliveryForm()),
                );
              }),
              _buildBottomSheetButton(context, 'የተበላሸ እቃ አስገባ', () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DamagedProductForm()),
                );
              }),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomSheetButton(
      BuildContext context, String title, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}

class ResponsiveGridView extends StatelessWidget {
  final List<Widget> children;

  const ResponsiveGridView({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWideScreen = constraints.maxWidth > 800;
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isWideScreen ? 3 : 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: isWideScreen ? 1.5 : 0.8,
          ),
          itemCount: children.length,
          itemBuilder: (context, index) {
            return children[index];
          },
        );
      },
    );
  }
}

// Card Widgets
class BalanceSheetCard extends StatelessWidget {
  final String title;
  final double value;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const BalanceSheetCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, size: 36, color: Colors.white),
              const SizedBox(height: 16),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                NumberFormat.currency(
                  locale: 'en_US',
                  symbol: 'ETB ',
                ).format(value),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              const Icon(Icons.chevron_right, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final double value;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, size: 36, color: Colors.white),
              const SizedBox(height: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      NumberFormat.currency(
                        locale: 'en_US',
                        symbol: 'ETB ',
                      ).format(value),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

class StockRemainCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const StockRemainCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, size: 36, color: Colors.white),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              const Icon(Icons.chevron_right, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

class DeliveryCard extends StatelessWidget {
  final String title;
  final int value;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const DeliveryCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, size: 36, color: Colors.white),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                NumberFormat.compact().format(value),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              const Icon(Icons.chevron_right, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

class StockRemain extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const StockRemain({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, size: 36, color: Colors.white),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              const Icon(Icons.chevron_right, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
