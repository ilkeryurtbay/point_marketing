import 'mission_entity.dart';

abstract class IMissionRepository {
  Future<void> createMission({required Mission mission});
  Future<void> updateMission({required Mission mission});
  Future<void> deleteMission({required Mission mission});
}
