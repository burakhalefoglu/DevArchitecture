import '../../../../core/services/base_services/in_memory_service.dart';
import '../models/user.dart';
import 'i_user_service.dart';

class InMemoryUserService extends InMemoryService<User>
    implements IUserService {
  List<User> _users = [
    User(
      userId: 1,
      fullName: 'John Doe',
      email: 'john.doe@example.com',
      address: '123 Main St',
      notes: 'Test user',
      status: true,
      mobilePhones: '555-1234',
    ),
    User(
      userId: 2,
      fullName: 'Jane Smith',
      email: 'jane.smith@example.com',
      address: '456 Elm St',
      notes: 'Another test user',
      status: true,
      mobilePhones: '555-5678',
    ),
  ];

  Future<List<User>> getAllUsers() async {
    return _users;
  }

  Future<void> cre(User user) async {
    _users.add(user);
  }

  Future<void> updateUser(User updatedUser) async {
    final index =
        _users.indexWhere((user) => user.userId == updatedUser.userId);
    if (index != -1) {
      _users[index] = updatedUser;
    }
  }

  Future<void> deleteUser(int userId) async {
    _users.removeWhere((user) => user.userId == userId);
  }
}
