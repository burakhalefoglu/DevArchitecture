import 'package:flutter_devarchitecture/core/utilities/results.dart';

import '../../../../core/services/base_services/in_memory_service.dart';
import '../models/translate.dart';
import '../models/translate_dto.dart';
import 'i_translate_service.dart';

class InMemoryTranslateService extends InMemoryService<Translate>
    implements ITranslateService {
  List<Map<String, dynamic>> _translations = [
    Map<String, dynamic>.from({
      "welcome": "Merhaba",
    })
  ];
  List<Translate> _translates = [
    Translate(id: 1, langId: 1, code: "test", value: "test"),
  ];

  InMemoryTranslateService() {
    super.datas = _translates.map((e) => e.toMap()).toList();
  }

  @override
  Future<IDataResult<List<TranslateDto>>> getTranslates() async {
    return SuccessDataResult(
      _translates.map((e) => TranslateDto.fromMap(e.toMap())).toList(),
      "",
    );
  }

  @override
  Future<IDataResult<List<Map<String, dynamic>>>> getTranslatesByCode(
      String code) async {
    return SuccessDataResult(_translations, "");
  }
}
