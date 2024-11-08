import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:future_lab_task/models/insurance_plan.dart';
import 'package:future_lab_task/providers/insurance_provider.dart';
import 'package:future_lab_task/screens/home_screen.dart';
import 'package:provider/provider.dart';

class TestInsuranceProvider extends ChangeNotifier implements InsuranceProvider {
  InsurancePlan? selectedPlan;
  BuildContext? lastContext;

  @override
  void selectPlan(InsurancePlan plan, BuildContext context) {
    selectedPlan = plan;
    lastContext = context;
    notifyListeners();
  }
}

void main() {
  late List<InsurancePlan> testPlans;
  late TestInsuranceProvider testProvider;

  setUp(() {
    testPlans = [
      InsurancePlan(
        id: '1',
        name: 'Basic Plan',
        coverageAmount: 50000,
        monthlyPremium: 100,
        deductible: 350,
        description: 'Basic Plan',
      ),
      InsurancePlan(
        id: '2',
        name: 'Premium Plan',
        coverageAmount: 100000,
        monthlyPremium: 200,
        deductible: 500,
        description: 'Premium Plan',
      ),
    ];

    testProvider = TestInsuranceProvider();
  });

  Widget createHomeScreen({double width = 800, double height = 600}) {
    return MaterialApp(
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<InsuranceProvider>(
            create: (_) => testProvider,
          ),
        ],
        child: Builder(
          builder: (context) => MediaQuery(
            data: MediaQueryData(
              size: Size(width, height),
              padding: EdgeInsets.zero,
            ),
            child: HomeScreen(insurancePlans: testPlans),
          ),
        ),
      ),
    );
  }

  testWidgets('HomeScreen renders GridView on wide screen', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1024, 768);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(createHomeScreen());
    await tester.pumpAndSettle();

    expect(find.byType(GridView), findsOneWidget);

    for (var plan in testPlans) {
      expect(find.text(plan.name), findsOneWidget);
      expect(find.text('Təminat: ${plan.coverageAmount.toStringAsFixed(0)} AZN'), findsOneWidget);
      expect(find.text('Aylıq: ${plan.monthlyPremium.toStringAsFixed(0)} AZN'), findsOneWidget);
    }
  });

  testWidgets('HomeScreen renders ListView on narrow screen', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(createHomeScreen(width: 400));
    await tester.pumpAndSettle();

    expect(find.byType(ListView), findsOneWidget);

    for (var plan in testPlans) {
      expect(find.text(plan.name), findsOneWidget);
      expect(find.text('Təminat: ${plan.coverageAmount.toStringAsFixed(0)} AZN'), findsOneWidget);
      expect(find.text('Aylıq: ${plan.monthlyPremium.toStringAsFixed(0)} AZN'), findsOneWidget);
    }
  });

  testWidgets('Plan card tap selects correct plan', (WidgetTester tester) async {
    await tester.pumpWidget(createHomeScreen());

    expect(testProvider.selectedPlan, null);

    await tester.tap(find.text('Basic Plan'));
    await tester.pump();

    expect(testProvider.selectedPlan, equals(testPlans[0]));
    expect(testProvider.selectedPlan?.name, equals('Basic Plan'));
  });

  testWidgets('HomeScreen displays correct number of plans', (WidgetTester tester) async {
    await tester.pumpWidget(createHomeScreen());

    expect(find.byType(Card), findsNWidgets(testPlans.length));
  });

  testWidgets('HomeScreen handles empty plan list', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider<InsuranceProvider>(
              create: (_) => testProvider,
            ),
          ],
          child: const HomeScreen(insurancePlans: []),
        ),
      ),
    );

    expect(find.byType(Card), findsNothing);
  });

  testWidgets('GridView has correct properties', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1024, 768);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(createHomeScreen());
    await tester.pumpAndSettle();

    final GridView gridView = tester.widget(find.byType(GridView));
    final SliverGridDelegateWithFixedCrossAxisCount gridDelegate = gridView.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;

    expect(gridDelegate.crossAxisCount, 2);
    expect(gridDelegate.childAspectRatio, 1.5);
  });

  testWidgets('Card styling has correct margins and paddings', (WidgetTester tester) async {
    await tester.pumpWidget(createHomeScreen());

    // Get the first card and its internal padding widget
    final Card card = tester.widget(find.byType(Card).first);
    final Padding contentPadding = tester.widget(find
        .descendant(
          of: find.byType(Card).first,
          matching: find.byType(Padding),
        )
        .first);

    expect(card.margin, const EdgeInsets.all(8.0));
    expect(contentPadding.padding, const EdgeInsets.all(8.0));
  });

  testWidgets('Text styling matches theme', (WidgetTester tester) async {
    await tester.pumpWidget(createHomeScreen());

    final Finder titleFinder = find.text('Basic Plan');
    final Text titleWidget = tester.widget(titleFinder);
    final BuildContext context = tester.element(titleFinder);
    final TextStyle? expectedStyle = Theme.of(context).textTheme.titleLarge;

    expect(titleWidget.style?.fontSize, expectedStyle?.fontSize);
  });
}
