import 'package:point_marketing/src/features/admin/domain/entity/company_entity.dart';
import 'package:point_marketing/src/features/admin/domain/entity/employee_entity.dart';
import 'package:point_marketing/src/features/admin/domain/entity/market_entity.dart';
import 'package:point_marketing/src/features/admin/domain/entity/product_entity.dart';
import 'package:point_marketing/src/features/admin/domain/i_admin_repository.dart';
import 'package:point_marketing/src/features/mission/domain/mission_entity.dart';

class AdminRepository implements IAdminRepository {
  @override
  Future<void> createAgent({required Employee agent}) {
    // TODO: implement createAgent
    throw UnimplementedError();
  }

  @override
  Future<void> createMission({required Mission mission}) {
    // TODO: implement createMission
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAgent({required Employee agent}) {
    // TODO: implement deleteAgent
    throw UnimplementedError();
  }

  @override
  Future<void> deleteMission({required Mission mission}) {
    // TODO: implement deleteMission
    throw UnimplementedError();
  }

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

  @override
  Future<void> updateAgent({required Employee agent}) {
    // TODO: implement updateAgent
    throw UnimplementedError();
  }

  @override
  Future<void> updateMission({required Mission mission}) {
    // TODO: implement updateMission
    throw UnimplementedError();
  }
}
