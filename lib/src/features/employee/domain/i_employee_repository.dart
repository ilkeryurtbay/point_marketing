import '../../admin/data/entity/employee_entity.dart';

abstract class IEmployeeRepository {
  Future<void> createEmployee({required Employee employee});
  Future<void> updateEmployee({required Employee employee});
  Future<void> deleteEmployee({required Employee employee});
}
