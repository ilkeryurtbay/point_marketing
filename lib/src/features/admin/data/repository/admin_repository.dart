import 'package:point_marketing/src/features/admin/domain/entity/company_entity.dart';
import 'package:point_marketing/src/features/admin/domain/entity/employee_entity.dart';
import 'package:point_marketing/src/features/admin/domain/entity/market_entity.dart';
import 'package:point_marketing/src/features/admin/domain/entity/product_entity.dart';
import 'package:point_marketing/src/features/admin/domain/i_admin_repository.dart';

class AdminRepository implements IAdminRepository {
  @override
  Future<List<Employee>> getAgentList() {
    // TODO: implement getAgentList
    throw UnimplementedError();
  }

  @override
  Future<List<Company>> getCompanyList() {
    // TODO: implement getCompanyList
    throw UnimplementedError();
  }

  @override
  Future<List<Market>> getMarketList() {
    // TODO: implement getMarketList
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getProductList() {
    // TODO: implement getProductList
    throw UnimplementedError();
  }
}
