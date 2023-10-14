import 'package:point_marketing/src/features/admin/data/entity/company_entity.dart';
import 'package:point_marketing/src/features/admin/data/entity/employee_entity.dart';
import 'package:point_marketing/src/features/admin/data/entity/market_entity.dart';
import 'package:point_marketing/src/features/admin/data/entity/mission_entity.dart';
import 'package:point_marketing/src/features/admin/data/entity/product_entity.dart';
import 'package:point_marketing/src/features/admin/domain/i_admin_repository.dart';

class AdminRepository implements IAdminRepository {
  @override
  Future<void> createEmployee({required Employee employee}) {
    // TODO: implement createAgent
    throw UnimplementedError();
  }

  @override
  Future<void> createMission({required Mission mission}) {
    // TODO: implement createMission
    throw UnimplementedError();
  }

  @override
  Future<void> deleteEmployee({required Employee employee}) {
    // TODO: implement deleteAgent
    throw UnimplementedError();
  }

  @override
  Future<void> deleteMission({required Mission mission}) {
    // TODO: implement deleteMission
    throw UnimplementedError();
  }

  @override
  Future<List<Employee>> getEmployeeList() {
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

  @override
  Future<void> updateEmployee({required Employee employee}) {
    // TODO: implement updateAgent
    throw UnimplementedError();
  }

  @override
  Future<void> updateMission({required Mission mission}) {
    // TODO: implement updateMission
    throw UnimplementedError();
  }
}
