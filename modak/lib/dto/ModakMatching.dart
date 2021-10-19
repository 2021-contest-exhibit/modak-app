

import 'package:modak/dto/Matching.dart';
import 'package:modak/rest/Content.dart';

class ModakMatching {
  Matching? matching;
  Content? content;
  String? uid;
  String? email;
  String? matchingId;

  ModakMatching({this.matching, this.content, this.uid, this.email, this.matchingId});
}