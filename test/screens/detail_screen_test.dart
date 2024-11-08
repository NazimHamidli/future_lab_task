import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:future_lab_task/models/insurance_plan.dart';
import 'package:future_lab_task/providers/insurance_provider.dart';
import 'package:future_lab_task/screens/detail_screen.dart';
import 'package:provider/provider.dart';

class TestInsuranceProvider extends ChangeNotifier implements InsuranceProvider {
  InsurancePlan? _selectedPlan;

  @override
  InsurancePlan? get selectedPlan => _selectedPlan;

  @override
  void selectPlan(InsurancePlan plan, BuildContext context) {
    _selectedPlan = plan;
    notifyListeners();
  }

  void setSelectedPlanForTest(InsurancePlan plan) {
    _selectedPlan = plan;
    notifyListeners();
  }

  void clearSelectedPlan() {
    _selectedPlan = null;
    notifyListeners();
  }
}

void main() {
  late TestInsuranceProvider testProvider;

  setUp(() {
    testProvider = TestInsuranceProvider();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: ChangeNotifierProvider<InsuranceProvider>.value(
        value: testProvider,
        child: const DetailScreen(),
      ),
    );
  }

  testWidgets('Should display no plan selected message when selectedPlan is null', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Heç bir plan seçilməyib'), findsOneWidget);
    expect(find.byType(Card), findsNothing);
  });

  testWidgets('Should display plan details when plan is selected', (WidgetTester tester) async {
    final testPlan = InsurancePlan(
      name: 'Test Plan',
      coverageAmount: 100000,
      monthlyPremium: 150,
      deductible: 1000,
      description: 'Test Description',
      id: '1',
    );

    await tester.pumpWidget(createWidgetUnderTest());
    testProvider.setSelectedPlanForTest(testPlan);
    await tester.pump();

    expect(find.text('Test Plan'), findsOneWidget);
    expect(find.text('${testPlan.coverageAmount.toStringAsFixed(0)} AZN'), findsOneWidget);
    expect(find.text('${testPlan.monthlyPremium.toStringAsFixed(0)} AZN'), findsOneWidget);
    expect(find.text('${testPlan.deductible.toStringAsFixed(0)} AZN'), findsOneWidget);
    expect(find.text('Test Description'), findsOneWidget);
  });

  testWidgets('Should display all detail rows with correct labels', (WidgetTester tester) async {
    final testPlan = InsurancePlan(
      name: 'Test Plan',
      coverageAmount: 100000,
      monthlyPremium: 150,
      deductible: 1000,
      description: 'Test Description',
      id: '1',
    );

    await tester.pumpWidget(createWidgetUnderTest());
    testProvider.setSelectedPlanForTest(testPlan);
    await tester.pump();

    expect(find.text('Təminat'), findsOneWidget);
    expect(find.text('Aylıq'), findsOneWidget);
    expect(find.text('Çıxılabilən'), findsOneWidget);
    expect(find.text('Plan İzahı'), findsOneWidget);
  });

  testWidgets('Should scroll when content overflows', (WidgetTester tester) async {
    final testPlan = InsurancePlan(
      name: 'Test Plan',
      coverageAmount: 100000,
      monthlyPremium: 150,
      deductible: 1000,
      description: 'Test Description' * 100,
      id: '1',
    );

    await tester.pumpWidget(createWidgetUnderTest());
    testProvider.setSelectedPlanForTest(testPlan);
    await tester.pump();

    expect(find.byType(SingleChildScrollView), findsOneWidget);

    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -500));
    await tester.pump();
  });

  testWidgets('Should update UI when plan changes', (WidgetTester tester) async {
    final initialPlan = InsurancePlan(
      name: 'Initial Plan',
      coverageAmount: 100000,
      monthlyPremium: 150,
      deductible: 1000,
      description: 'Initial Description',
      id: '1',
    );

    final updatedPlan = InsurancePlan(
      name: 'Updated Plan',
      coverageAmount: 200000,
      monthlyPremium: 250,
      deductible: 2000,
      description: 'Updated Description',
      id: '1',
    );

    await tester.pumpWidget(createWidgetUnderTest());
    testProvider.setSelectedPlanForTest(initialPlan);
    await tester.pump();

    expect(find.text('Initial Plan'), findsOneWidget);
    expect(find.text('${initialPlan.coverageAmount.toStringAsFixed(0)} AZN'), findsOneWidget);

    testProvider.setSelectedPlanForTest(updatedPlan);
    await tester.pump();

    expect(find.text('Updated Plan'), findsOneWidget);
    expect(find.text('${updatedPlan.coverageAmount.toStringAsFixed(0)} AZN'), findsOneWidget);
  });

  testWidgets('Should have correct text styles', (WidgetTester tester) async {
    final testPlan = InsurancePlan(
      name: 'Test Plan',
      coverageAmount: 100000,
      monthlyPremium: 150,
      deductible: 1000,
      description: 'Test Description',
      id: '1',
    );

    await tester.pumpWidget(createWidgetUnderTest());
    testProvider.setSelectedPlanForTest(testPlan);
    await tester.pump();

    final planNameFinder = find.text('Test Plan');
    final Text planNameWidget = tester.widget(planNameFinder);
    expect(planNameWidget.style?.fontSize, Theme.of(tester.element(find.byType(MaterialApp))).textTheme.headlineMedium?.fontSize);

    final labelFinders = [find.text('Təminat'), find.text('Aylıq'), find.text('Çıxılabilən')];

    for (final finder in labelFinders) {
      final Text labelWidget = tester.widget(finder);
      expect(labelWidget.style?.fontWeight, FontWeight.bold);
    }
  });

  testWidgets('Should select plan with context', (WidgetTester tester) async {
    final testPlan = InsurancePlan(
      name: 'Test Plan',
      coverageAmount: 100000,
      monthlyPremium: 150,
      deductible: 1000,
      description: 'Test Description',
      id: '1',
    );

    await tester.pumpWidget(createWidgetUnderTest());

    final BuildContext context = tester.element(find.byType(DetailScreen));
    testProvider.selectPlan(testPlan, context);
    await tester.pump();

    expect(find.text('Test Plan'), findsOneWidget);
    expect(find.text('${testPlan.coverageAmount.toStringAsFixed(0)} AZN'), findsOneWidget);
  });
}
