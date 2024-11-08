import 'package:flutter_test/flutter_test.dart';
import 'package:future_lab_task/models/insurance_plan.dart';

void main() {
  group('InsurancePlan Model Tests', () {
    test('should create InsurancePlan instance with correct values', () {
      final plan = InsurancePlan(
        id: '1',
        name: 'Test Plan',
        coverageAmount: 500000,
        monthlyPremium: 150,
        deductible: 1000,
        description: 'Test description',
      );

      expect(plan.id, '1');
      expect(plan.name, 'Test Plan');
      expect(plan.coverageAmount, 500000);
      expect(plan.monthlyPremium, 150);
      expect(plan.deductible, 1000);
      expect(plan.description, 'Test description');
    });
  });
}
