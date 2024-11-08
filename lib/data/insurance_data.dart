import '../models/insurance_plan.dart';

final List<InsurancePlan> insurancePlans = [
  InsurancePlan(
    id: '1',
    name: 'Yaşıl Bakı',
    coverageAmount: 50000,
    monthlyPremium: 150,
    deductible: 1000,
    description: 'Yaşıl Bakı - daşınmaz və daşınar əmlakın icbari və könüllü sığorta məhsuludur.',
  ),
  InsurancePlan(
    id: '2',
    name: 'Yaxın Qonşu',
    coverageAmount: 100000,
    monthlyPremium: 250,
    deductible: 2000,
    description:
        '«Yaxın Qonşu» üçüncü tərəfin səhhətinə və ya əmlakına vura biləcəyiniz zərərə qarşı sığorta təminatını təqdim edən könüllü sığorta məhsuludur. ',
  ),
  InsurancePlan(
    id: '3',
    name: 'Səyahət zamanı',
    coverageAmount: 120000,
    monthlyPremium: 450,
    deductible: 3000,
    description: 'PAŞA Sığorta “Səyahət zamanı daşınmaz əmlakın sığortası” adlı yeni məhsulunu təqdim edirş',
  ),
];
