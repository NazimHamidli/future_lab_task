import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/insurance_provider.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final plan = context.watch<InsuranceProvider>().selectedPlan;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Plan Detalı'),
      ),
      body: plan == null
          ? const Center(child: Text('Heç bir plan seçilməyib'))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            plan.name,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 16),
                          _buildDetailRow('Təminat', '${plan.coverageAmount.toStringAsFixed(0)} AZN'),
                          _buildDetailRow('Aylıq', '${plan.monthlyPremium.toStringAsFixed(0)} AZN'),
                          _buildDetailRow('Çıxılabilən', '${plan.deductible.toStringAsFixed(0)} AZN'),
                          const SizedBox(height: 16),
                          Text(
                            'Plan İzahı',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            plan.description,
                            style: Theme.of(context).textTheme.bodyLarge,
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
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}
