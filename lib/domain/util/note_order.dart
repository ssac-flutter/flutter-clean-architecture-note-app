import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:note_app/domain/util/order_type.dart';

part 'note_order.freezed.dart';

@freezed
abstract class NoteOrder with _$NoteOrder {
  const factory NoteOrder.title(OrderType orderType) = NoteOrderTitle;
  const factory NoteOrder.date(OrderType orderType) = NoteOrderDate;
  const factory NoteOrder.color(OrderType orderType) = NoteOrderColor;
}

