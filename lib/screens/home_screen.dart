import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/insurance_plan.dart';
import '../providers/insurance_provider.dart';

class HomeScreen extends StatelessWidget {
  final List<InsurancePlan> insurancePlans;

  const HomeScreen({super.key, required this.insurancePlans});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Əmlak Sığortası Könüllü Planları'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return _buildGridView();
          }
          return _buildListView();
        },
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: insurancePlans.length,
      itemBuilder: (context, index) {
        return _buildPlanCard(context, insurancePlans[index]);
      },
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
      ),
      itemCount: insurancePlans.length,
      itemBuilder: (context, index) {
        return _buildPlanCard(context, insurancePlans[index]);
      },
    );
  }

  Widget _buildPlanCard(BuildContext context, InsurancePlan plan) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          context.read<InsuranceProvider>().selectPlan(plan, context);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                plan.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Təminat: ${plan.coverageAmount.toStringAsFixed(0)} AZN',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                'Aylıq: ${plan.monthlyPremium.toStringAsFixed(0)} AZN',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
