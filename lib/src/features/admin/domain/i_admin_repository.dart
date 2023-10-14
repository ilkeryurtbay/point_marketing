import 'package:point_marketing/src/features/admin/data/entity/employe_entity.dart';
import 'package:point_marketing/src/features/admin/data/entity/product_entity.dart';

import '../data/entity/company_entity.dart';
import '../data/entity/market_entity.dart';

abstract class IAdminRepository {
  Future<List<Market>> getMarketList();
  Future<List<Company>> getCompanyList();
  Future<List<Product>> getProductList();
  Future<List<employe>> getemployeList();
}
