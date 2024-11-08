import 'package:flutter_test/flutter_test.dart';
import 'package:future_lab_task/data/insurance_data.dart';

void main() {
  group('Sample Data Tests', () {
    test('sample plans should not be empty', () {
      expect(insurancePlans, isNotEmpty);
    });

    test('sample plans should have valid data', () {
      for (var plan in insurancePlans) {
        expect(plan.id, isNotEmpty);
        expect(plan.name, isNotEmpty);
        expect(plan.coverageAmount, isPositive);
        expect(plan.monthlyPremium, isPositive);
        expect(plan.deductible, isPositive);
        expect(plan.description, isNotEmpty);
      }
    });
  });
}
