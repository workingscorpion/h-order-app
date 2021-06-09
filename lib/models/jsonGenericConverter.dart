import 'package:h_order/models/billModel.dart';
import 'package:h_order/models/historyModel.dart';
import 'package:h_order/models/noticeModel.dart';
import 'package:json_annotation/json_annotation.dart';

class JsonGenericConverter<T> implements JsonConverter<T, Object> {
  const JsonGenericConverter();

  @override
  T fromJson(Object json) {
    switch (T) {
      case List:
        final list = json as List;
        return list.map((e) => fromJson(e)).toList() as T;

      case HistoryModel:
        return HistoryModel.fromJson(json) as T;
      case BillModel:
        return BillModel.fromJson(json) as T;
      case NoticeModel:
        return NoticeModel.fromJson(json) as T;
    }

    return json as T;
  }

  @override
  Object toJson(T object) {
    return object;
  }
}
