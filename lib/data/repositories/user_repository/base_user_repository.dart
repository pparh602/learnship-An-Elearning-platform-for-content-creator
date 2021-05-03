import 'package:learnship/data/models/models.dart';
import 'package:meta/meta.dart';

abstract class BaseUserRepository {
  Future<void> getUserWithId({@required String userId});
  Future<void> updateUser({User user});
}
