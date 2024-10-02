import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        emitFailState(result.message);
        return;
      }
      print(result.data);
      emit(BlocSuccess<List<Map<String, dynamic>>>(result.data!));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emitFailState(e.toString());
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
        emitFailState(result.message);
        return;
      }
      emit(BlocAdded());
      getAll();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emitFailState(e.toString());
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
        emitFailState(result.message);
        return;
      }
      emit(BlocUpdated());
      getAll();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emitFailState(e.toString());
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
        emitFailState(result.message);
        return;
      }
      emit(BlocDeleted());
      getAll();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emitFailState(e.toString());
    }
  }

  void emitLoadingState() {
    emit(BlocLoading("Yükleniyor!"));
  }

  void emitCheckingState() {
    emit(BlocChecking("Veriler Kontrol Ediliyor!"));
  }

  void emitFailState(String message) {
    emit(BlocFailed(message));
  }
}
