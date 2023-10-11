import '../../admin/domain/entity/employee_entity.dart';

abstract class IAgentRepository {
  Future<void> createAgent({required Employee agent});
  Future<void> updateAgent({required Employee agent});
  Future<void> deleteAgent({required Employee agent});
}
