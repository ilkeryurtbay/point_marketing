import 'package:point_marketing/src/features/admin/data/entity/employe_entity.dart';
import 'package:point_marketing/src/features/admin/data/entity/company_entity.dart';
import 'package:point_marketing/src/features/admin/data/entity/market_entity.dart';
import 'package:point_marketing/src/features/admin/data/entity/mission_entity.dart';
import 'package:point_marketing/src/features/admin/data/entity/product_entity.dart';
import 'package:point_marketing/src/features/admin/domain/i_admin_repository.dart';

class AdminRepository implements IAdminRepository {
  @override
  Future<void> createemploye({required employe employe}) {
    // TODO: implement createemploye
    throw UnimplementedError();
  }

  @override
  Future<void> createMission({required Mission mission}) {
    // TODO: implement createMission
    throw UnimplementedError();
  }

  @override
  Future<void> deleteemploye({required employe employe}) {
    // TODO: implement deleteemploye
    throw UnimplementedError();
  }

  @override
  Future<void> deleteMission({required Mission mission}) {
    // TODO: implement deleteMission
    throw UnimplementedError();
  }

  @override
  Future<List<employe>> getemployeList() {
    // TODO: implement getemployeList
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
  Future<void> updateemploye({required employe employe}) {
    // TODO: implement updateemploye
    throw UnimplementedError();
  }

  @override
  Future<void> updateMission({required Mission mission}) {
    // TODO: implement updateMission
    throw UnimplementedError();
  }
}
