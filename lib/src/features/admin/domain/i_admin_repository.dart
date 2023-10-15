import 'package:point_marketing/src/features/admin/domain/entity/employee_entity.dart';
import 'package:point_marketing/src/features/admin/domain/entity/product_entity.dart';

import '../domain/entity/company_entity.dart';
import '../domain/entity/market_entity.dart';

abstract class IAdminRepository {
  Future<List<Market>> getMarketList();
  Future<List<Company>> getCompanyList();
  Future<List<Product>> getProductList();
  Future<List<Employee>> getAgentList();
}
