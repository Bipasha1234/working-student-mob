import 'package:json_annotation/json_annotation.dart';
import 'package:softwarica_student_management_bloc/features/course/data/model/course_api_model.dart';

part 'get_all_course_dto.g.dart';

@JsonSerializable()
class GetAllCourseDTO {
  final bool success;
  final int count;
  final List<CourseApiModel> data;

  GetAllCourseDTO({
    required this.success,
    required this.count,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAllCourseDTOToJson(this);

  factory GetAllCourseDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllCourseDTOFromJson(json);
}
