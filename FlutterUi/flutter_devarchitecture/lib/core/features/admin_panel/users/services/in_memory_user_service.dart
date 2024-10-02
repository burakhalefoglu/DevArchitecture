import '../../../../services/base_services/in_memory_service.dart';
import '../models/user.dart';
import 'i_user_service.dart';

class InMemoryUserService extends InMemoryService<User>
    implements IUserService {
  List<User> _users = [
    User(
      id: 1,
      userId: 1,
      fullName: 'John Doe',
      email: 'john.doe@example.com',
      address: '123 Main St',
      notes: 'Test user',
      status: true,
      mobilePhones: '555-1234',
    ),
    User(
      id: 2,
      userId: 2,
      fullName: 'Jane Smith',
      email: 'jane.smith@example.com',
      address: '456 Elm St',
      notes: 'Another test user',
      status: true,
      mobilePhones: '555-5678',
    ),
  ];

  InMemoryUserService() {
    super.datas = _users.map((e) => e.toMap()).toList();
  }
}
