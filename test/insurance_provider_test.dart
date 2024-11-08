import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:future_lab_task/models/insurance_plan.dart';
import 'package:future_lab_task/shared/navigating/app_route.dart';

class TestBuildContext extends Fake implements BuildContext {
  String? lastPushedNamedRoute;

  void pushNamed(String name) {
    lastPushedNamedRoute = name;
  }
}

class NavigatorHelper {
  static void pushNamed(BuildContext context, String name) {
    if (context is TestBuildContext) {
      context.pushNamed(name);
    }
  }
}

class TestableInsuranceProvider extends ChangeNotifier {
  InsurancePlan? _selectedPlan;
  InsurancePlan? get selectedPlan => _selectedPlan;

  void selectPlan(InsurancePlan plan, BuildContext context) {
    _selectedPlan = plan;
    NavigatorHelper.pushNamed(context, AppRoute.detailScreen.name);
    notifyListeners();
  }
}

void main() {
  group('InsuranceProvider Tests', () {
    late TestableInsuranceProvider provider;
    late TestBuildContext testContext;

    setUp(() {
      provider = TestableInsuranceProvider();
      testContext = TestBuildContext();
    });

    test('Initial selected plan should be null', () {
      expect(provider.selectedPlan, isNull);
    });

    test('selectPlan should update selected plan', () {
      final testPlan = InsurancePlan(
        id: '1',
        name: 'Plan 1',
        coverageAmount: 5000,
        monthlyPremium: 50,
        deductible: 100,
        description: 'Plan 1 test',
      );

      provider.selectPlan(testPlan, testContext);

      expect(provider.selectedPlan, equals(testPlan));
    });

    test('selectPlan should trigger navigation', () {
      final testPlan = InsurancePlan(
        id: '1',
        name: 'Plan 1',
        coverageAmount: 5000,
        monthlyPremium: 50,
        deductible: 100,
        description: 'Plan 1 test',
      );

      provider.selectPlan(testPlan, testContext);

      expect(testContext.lastPushedNamedRoute, equals(AppRoute.detailScreen.name));
    });

    test('selectPlan should notify listeners', () {
      final testPlan = InsurancePlan(
        id: '1',
        name: 'Plan 1',
        coverageAmount: 5000,
        monthlyPremium: 50,
        deductible: 100,
        description: 'Plan 1 test',
      );

      var notificationCount = 0;
      provider.addListener(() {
        notificationCount++;
      });

      provider.selectPlan(testPlan, testContext);

      expect(notificationCount, 1);
    });

    test('selecting different plans updates the selected plan', () {
      final testPlan1 = InsurancePlan(
        id: '1',
        name: 'Plan 1',
        coverageAmount: 5000,
        monthlyPremium: 50,
        deductible: 100,
        description: 'Plan 1 test',
      );

      final testPlan2 = InsurancePlan(
        id: '1',
        name: 'Plan 1',
        coverageAmount: 5000,
        monthlyPremium: 50,
        deductible: 100,
        description: 'Plan 1 test',
      );

      provider.selectPlan(testPlan1, testContext);
      expect(provider.selectedPlan, equals(testPlan1));

      provider.selectPlan(testPlan2, testContext);
      expect(provider.selectedPlan, equals(testPlan2));
    });

    test('selectPlan with same plan should still navigate', () {
      final testPlan = InsurancePlan(
        id: '1',
        name: 'Plan 1',
        coverageAmount: 5000,
        monthlyPremium: 50,
        deductible: 100,
        description: 'Plan 1 test',
      );

      // Select plan first time
      provider.selectPlan(testPlan, testContext);
      expect(provider.selectedPlan, equals(testPlan));

      // Reset navigation tracking
      testContext.lastPushedNamedRoute = null;

      // Select same plan again
      provider.selectPlan(testPlan, testContext);

      // Should still navigate
      expect(testContext.lastPushedNamedRoute, equals(AppRoute.detailScreen.name));
    });
  });
}
