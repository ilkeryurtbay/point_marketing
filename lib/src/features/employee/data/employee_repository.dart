import 'package:point_marketing/src/features/employee/domain/i_employee_repository.dart';

import '../../admin/domain/entity/employee_entity.dart';

class EmployeeRepository implements IEmployeeRepository {
  @override
  Future<void> createEmployee({required Employee employee}) {
    // TODO: implement createAgent
    throw UnimplementedError();
  }

  @override
  Future<void> deleteEmployee({required Employee employee}) {
    // TODO: implement deleteAgent
    throw UnimplementedError();
  }

  @override
  Future<void> updateEmployee({required Employee employee}) {
    // TODO: implement updateAgent
    throw UnimplementedError();
  }
}
