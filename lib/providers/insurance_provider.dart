import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/insurance_plan.dart';
import '../shared/navigating/app_route.dart';

class InsuranceProvider with ChangeNotifier {
  InsurancePlan? _selectedPlan;

  InsurancePlan? get selectedPlan => _selectedPlan;

  void selectPlan(InsurancePlan plan, BuildContext context) {
    _selectedPlan = plan;
    if (context.mounted) {
      context.pushNamed(AppRoute.detailScreen.name);
    }
    notifyListeners();
  }
}
