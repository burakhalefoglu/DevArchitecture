import 'package:flutter_devarchitecture/core/services/i_service.dart';
import 'package:flutter_devarchitecture/core/utilities/results.dart';

import '../../../../core/models/lookup.dart';

abstract class ILanguageService extends IService {
  Future<IDataResult<List<LookUp>>> getLanguageCodes(); // id is language code
  Future<IDataResult<List<LookUp>>> getLanguageLookups(); // id is number
}
