import 'package:point_marketing/src/features/admin/data/entity/agent_entity.dart';

abstract class IemployeRepository {
  Future<void> createemploye({required employe employe});
  Future<void> updateemploye({required employe employe});
  Future<void> deleteemploye({required employe employe});
}
