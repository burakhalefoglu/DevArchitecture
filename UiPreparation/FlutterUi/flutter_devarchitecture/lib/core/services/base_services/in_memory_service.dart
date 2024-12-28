import 'package:collection/collection.dart';
import '../../constants/temp/messages.dart';
import '../../utilities/results.dart';
import '../../../core/services/i_service.dart';
import '../../models/i_entity.dart';

class InMemoryService<T extends IEntity> implements IService {
  List<Map<String, dynamic>> datas = [];

  @override
  Future<IDataResult<Map<String, dynamic>>> create(Map<String, dynamic> body) {
    this.datas.add(body);
    return Future.value(SuccessDataResult(body, ""));
  }

  @override
  Future<IResult> delete(id) {
    datas.removeWhere((element) => element["id"] == id.toString());
    return Future.value(SuccessResult(Messages.customerDefaultSuccessMessage));
  }

  @override
  Future<IDataResult<List<Map<String, dynamic>>>> getAll() {
    return Future.value(SuccessDataResult(datas, ""));
  }

  @override
  Future<IDataResult<Map<String, dynamic>>> getById(int id) {
    return Future.value(SuccessDataResult(datas.firstWhereOrNull((element) {
      return element["id"] == id;
    }), ""));
  }

  @override
  Future<IResult> update(id, Map<String, dynamic> body) {
    datas.removeWhere((element) => element["id"] == id.toString());
    datas.add(body);
    return Future.value(SuccessResult(Messages.customerDefaultSuccessMessage));
  }

  @override
  Future<IResult> createMany(List<Map<String, dynamic>> body) {
    for (var element in body) {
      this.datas.add(element);
    }
    return Future.value(SuccessResult(Messages.customerDefaultSuccessMessage));
  }

  @override
  Future<IDataResult<Map<String, dynamic>>> getByName(String name) {
    return Future.value(SuccessDataResult(
        datas.firstWhere((element) {
          return element["name"] == name;
        }, orElse: () => {}),
        ""));
  }
}
