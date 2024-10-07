import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_devarchitecture/core/helpers/exceptions.dart';
import 'base_state.dart';
import '../models/i_entity.dart';
import '../services/i_service.dart';

class BaseCubit<T extends IEntity> extends Cubit<BaseState> {
  late IService service;
  BaseCubit() : super(const BlocInitial());

  @override
  void emit(BaseState state) {
    if (isClosed) return;
    super.emit(state);
  }

  Future<void> getAll() async {
    try {
      emit(BlocLoading("Veriler Getiriliyor..."));
      var result = await service.getAll();
      if (!result.isSuccess) {
        if (kDebugMode) {
          print(result.message);
        }
        emitFailState(message: result.message);
        return null;
      }

      emit(BlocSuccess<List<Map<String, dynamic>>>(result.data!));
    } on Exception catch (e) {
      emitFailState(e: e);
    }
  }

  Future<void> add(T body) async {
    try {
      emit(BlocSending("Veri Ekleniyor"));
      var result = await service.create(body.toMap());
      if (!result.isSuccess) {
        if (kDebugMode) {
          print(result.message);
        }
        emitFailState(message: result.message);
        return;
      }
      emit(BlocAdded());
      getAll();
    } on Exception catch (e) {
      emitFailState(e: e);
    }
  }

  Future<void> update(T body) async {
    try {
      emit(BlocSending("Veri güncelleniyor"));
      var result = await service.update(body.id, body.toMap());
      if (!result.isSuccess) {
        if (kDebugMode) {
          print(result.message);
        }
        emitFailState(
          message: result.message,
        );
        return;
      }
      emit(BlocUpdated());
      getAll();
    } on Exception catch (e) {
      emitFailState(e: e);
    }
  }

  Future<void> delete(dynamic id) async {
    try {
      emit(BlocSending("Veri siliniyor"));
      var result = await service.delete(id);
      if (!result.isSuccess) {
        if (kDebugMode) {
          print(result.message);
        }
        emitFailState(
          message: result.message,
        );
        return;
      }
      emit(BlocDeleted());
      getAll();
    } on Exception catch (e) {
      emitFailState(e: e);
    }
  }

  void emitLoadingState() {
    emit(BlocLoading("Yükleniyor!"));
  }

  void emitCheckingState() {
    emit(BlocChecking("Veriler Kontrol Ediliyor!"));
  }

  void emitFailState({String? message, Exception? e}) {
    if (kDebugMode) {
      print(message);
    }

    if (e != null) {
      if (kDebugMode) {
        print(e);
      }
      if (e is BadRequestException) {
        emit(BlocFailed(400, e.message));
      }
      if (e is UnauthorizedException) {
        emit(BlocFailed(401, e.message));
      }
      if (e is ForbiddenException) {
        emit(BlocFailed(403, e.message));
      }
      if (e is NotFoundException) {
        emit(BlocFailed(404, e.message));
      }
      if (e is InternalServerErrorException) {
        emit(BlocFailed(500, e.message));
      }
    }
    emit(
        BlocFailed(500, "Beklenmeyen Hata olustu: ${message ?? e.toString()}"));
  }
}
