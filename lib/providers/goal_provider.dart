import 'package:firebase_auth/firebase_auth.dart';
import '../exported.dart';

class GoalProvider extends ChangeNotifier {
  final _instance = FirebaseFirestore.instance;
  final _collection = FirebaseAuth.instance.currentUser?.phoneNumber;

  //! CREATE GOAL
  bool isLoadingForCreateGoal = false;
  Future<bool> createGoal(GoalModel goal) async {
    if (_collection == null) return false; // this will newer run, but safety purpose

    try {
      isLoadingForCreateGoal = true;
      notifyListeners();
      final ref = _instance.collection(_collection).doc();
      final json = goal.copy(ref.id).toJson();
      debugPrint('json : $json');
      await ref.set(json);
      isLoadingForCreateGoal = false;
      notifyListeners();
      return true;
    } on FirebaseException catch (error) {
      Fluttertoast.showToast(msg: error.message ?? 'Failed to create record');
      isLoadingForCreateGoal = false;
      notifyListeners();
      return false;
    } catch (e) {
      Fluttertoast.showToast(msg: 'Something went wrong');
      isLoadingForCreateGoal = false;
      notifyListeners();
      return false;
    }
  }

  //! READ GOAL
  bool isLoadingForReadRecord = false;
  bool isRefreshForReadRecord = true;
  List<GoalModel> myGoals = <GoalModel>[];
  Future<List<GoalModel>?> readGoal() async {
    debugPrint('------> Read Goal');
    if (_collection == null) return null; // this will newer run, but safety purpose
    isLoadingForReadRecord = true;
    notifyListeners();
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _instance.collection(_collection).orderBy('completion_date', descending: false).get();
      final goals = querySnapshot.docs.map((e) => GoalModel.fromJson(e.data())).toList();
      myGoals = goals;
      isLoadingForReadRecord = false;
      isRefreshForReadRecord = false;
      notifyListeners();
      return myGoals;
    } on FirebaseException catch (error) {
      Fluttertoast.showToast(msg: error.message ?? 'Failed to get record');
      debugPrint('readRecord FirebaseError code : ${error.code}');
      debugPrint('readRecord FirebaseError message : ${error.message}');
      debugPrint('readRecord FirebaseError error : ${error.toString()}');

      isLoadingForReadRecord = false;
      notifyListeners();
      return null;
    } catch (e) {
      Fluttertoast.showToast(msg: 'Something went wrong');
      isLoadingForReadRecord = false;
      notifyListeners();
      return null;
    }
  }

  //! ADD Instalment

  bool isLoadingForAddInstalment = false;

  Future<bool> addInstalment({
    required InstalmentModel instalment,
    required String docID,
  }) async {
    if (_collection == null) return false; // this will newer run, but safety purpose

    try {
      isLoadingForAddInstalment = true;
      notifyListeners();
      final collection = _instance.collection(_collection);
      final doc = collection.doc(docID);
      await doc.update(
        {
          'instalment': FieldValue.arrayUnion([instalment.toJson()]),
        },
      );

      isLoadingForAddInstalment = false;
      notifyListeners();

      return true;
    } on FirebaseException catch (error) {
      Fluttertoast.showToast(msg: error.message ?? 'Failed to add instalment');
      debugPrint('addInstalment FirebaseError code : ${error.code}');
      debugPrint('addInstalment FirebaseError message : ${error.message}');
      debugPrint('addInstalment FirebaseError error : ${error.toString()}');
      isLoadingForAddInstalment = false;
      notifyListeners();
      return false;
    } catch (e) {
      Fluttertoast.showToast(msg: 'Something went wrong');
      isLoadingForAddInstalment = false;
      notifyListeners();
      return false;
    }
  }
}



/*

db.collection('users').doc('random-id').set({
  "friends": {
    "friend-uid-3": true
  }
},{merge:true})

*/
