import 'package:flutter_devarchitecture/core/services/i_service.dart';
import 'package:flutter_devarchitecture/core/utilities/results.dart';

import '../../user-claims/models/lookup.dart';

abstract class ILanguageService extends IService {
  Future<IDataResult<List<LookUp>>> getLanguages();
}
