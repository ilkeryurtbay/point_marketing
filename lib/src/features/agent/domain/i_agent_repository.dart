import '../../admin/data/entity/agent_entity.dart';

abstract class IAgentRepository {
  Future<void> createAgent({required Agent agent});
  Future<void> updateAgent({required Agent agent});
  Future<void> deleteAgent({required Agent agent});
}
