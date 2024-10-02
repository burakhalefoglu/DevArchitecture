import '../../../../services/base_services/in_memory_service.dart';
import '../models/group.dart';
import 'i_group.dart';

class InMemoryGroupService extends InMemoryService<Group>
    implements IGroupService {
  List<Group> _group = [Group(id: 1, groupName: "deneme1")];
  InMemoryGroupService() {
    super.datas = _group.map((e) => e.toMap()).toList();
  }
}
