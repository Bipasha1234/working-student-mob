import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/entity/batch_entity.dart';

@JsonSerializable()
class BatchApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? batchId;
  final String batchName;

  const BatchApiModel({
    this.batchId,
    required this.batchName,
  });

  const BatchApiModel.empty()
      : batchId = '',
        batchName = '';

  factory BatchApiModel.fromJson(Map<String, dynamic> json) {
    return BatchApiModel(
      batchId: json['_id'],
      batchName: json['batchName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'batchName': batchName,
    };
  }

  BatchEntity toEntity() {
    return BatchEntity(
      batchId: batchId,
      batchName: batchName,
    );
  }

  factory BatchApiModel.fromEntity(BatchEntity entity) {
    return BatchApiModel(
      batchId: entity.batchId,
      batchName: entity.batchName,
    );
  }

  static List<BatchEntity> toEntityList(List<BatchApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [batchId, batchName];
}
