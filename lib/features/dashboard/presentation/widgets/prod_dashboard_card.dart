
import 'package:flutter/material.dart';

class ProdDashboardCard extends StatelessWidget {
  final String title;
  final String lastUpdated;
  final Widget? child;
  final bool isLoading;
  final Color color;

  const ProdDashboardCard({
    super.key,
    required this.title,
    required this.lastUpdated,
    required this.color,
    this.child,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    var border = const BorderRadius.all(Radius.circular(20.0));
    return Card(
      margin: const EdgeInsets.all(2),
      elevation: 6,
      shadowColor: color,
      shape: RoundedRectangleBorder(borderRadius: border),
      child: Container(
        decoration: BoxDecoration(borderRadius: border,border: Border.all(color: Colors.black.withOpacity(0.4),width: 0.5)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(context),
               Divider(
              height: 0, 
              thickness: 0.5,
              color: Colors.black54.withOpacity(0.4),
            ),
            const SizedBox(height: 10),
            if (isLoading)
              const Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              )
            else
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: child ?? const Text("No chart data available"),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius:  BorderRadius.circular(20)
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.black)),
          Text(
            lastUpdated,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color: Colors.black),
          ),
      
        ],
      ),
    );
  }
}
