import '../../configs/app_config.dart';
import '../../utilities/results.dart';
import '../../di/core_initializer.dart';
import '../i_service.dart';

abstract class ApiService<T> implements IService {
  late String url;

  init(String method) {
    url = appConfig.apiUrl + method;
  }

  ApiService({required String method}) {
    init(method);
  }

  @override
  Future<IResult> create(Map<String, dynamic> body) async {
    await CoreInitializer().coreContainer.http.post(url, body);
    return Future.value(SuccessResult("Tüm Veriler Eklendi!"));
  }

  @override
  Future<IResult> delete(int id) async {
    await CoreInitializer().coreContainer.http.delete("$url/$id");
    return Future.value(SuccessResult("Veri Silindi"));
  }

  @override
  Future<IDataResult<List<Map<String, dynamic>>>> getAll() async {
    var result = await CoreInitializer().coreContainer.http.get(url);
    var data =
        (result["data"] as List).map((e) => e as Map<String, dynamic>).toList();

    return Future.value(SuccessDataResult(data, ""));
  }

  @override
  Future<IDataResult<Map<String, dynamic>>> getById(int id) async {
    var result = await CoreInitializer().coreContainer.http.get("$url/$id");
    var data = result["data"] as Map<String, dynamic>;
    return Future.value(SuccessDataResult(data, ""));
  }

  @override
  Future<IDataResult<Map<String, dynamic>>> getByName(String name) async {
    var result =
        await CoreInitializer().coreContainer.http.get("$url/name?name=$name");
    var data = result["data"] as Map<String, dynamic>;
    return Future.value(SuccessDataResult(data, ""));
  }

  @override
  Future<IResult> update(id, Map<String, dynamic> body) async {
    await CoreInitializer().coreContainer.http.put(url, body);
    return Future.value(SuccessResult("Veri Güncellendi !"));
  }

  @override
  Future<IResult> createMany(List<Map<String, dynamic>> body) async {
    for (var element in body) {
      await CoreInitializer().coreContainer.http.post(url, element);
    }
    return Future.value(SuccessResult("Tüm Veriler Eklendi!"));
  }
}
