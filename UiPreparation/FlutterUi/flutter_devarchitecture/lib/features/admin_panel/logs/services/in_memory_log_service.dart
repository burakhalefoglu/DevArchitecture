import '/core/utilities/results.dart';

import '/features/admin_panel/logs/models/log_dto.dart';

import '../../../../core/services/base_services/in_memory_service.dart';
import '../models/log.dart';
import 'i_service.dart';

class InMemoryLogService extends InMemoryService<Log> implements ILogService {
  List<Log> _log = [
    Log(
        id: 1,
        level: "info",
        messageTemplate: "message",
        timeStamp: DateTime.now(),
        exception: ""),
  ];
  InMemoryLogService() {
    super.datas = _log.map((e) => e.toMap()).toList();
  }

  @override
  Future<IDataResult<List<LogDto>>> getLogs() async {
    return SuccessDataResult(
      _log
          .map((e) => LogDto.fromMap(e.toMap()))
          .toList()
          .reversed
          .toList()
          .cast<LogDto>(),
      "",
    );
  }
}
