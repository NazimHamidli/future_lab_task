class InsurancePlan {
  final String id;
  final String name;
  final double coverageAmount;
  final double monthlyPremium;
  final double deductible;
  final String description;

  InsurancePlan({
    required this.id,
    required this.name,
    required this.coverageAmount,
    required this.monthlyPremium,
    required this.deductible,
    required this.description,
  });
}
