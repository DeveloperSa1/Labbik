import 'package:get/route_manager.dart';
import 'package:labbaik/app/1auth/model/admin.dart';
import 'package:labbaik/app/1auth/model/guardian.dart';
import 'package:labbaik/app/1auth/model/staff.dart';
import 'package:labbaik/app/1auth/model/student.dart';
import 'package:labbaik/app/1auth/ui/welcome.dart';
import 'package:labbaik/imports.dart';

// #TODO - CleanFile

enum UserRole { admin, guardian, staff }

class AuthServices with ChangeNotifier {
  StaffsModel? _staff;
  StaffsModel? get staff => _staff;
  AdminModel? _admin;
  AdminModel? get admin => _admin;
  GuardianModel? _guardian;
  GuardianModel? get guardian => _guardian;
  StudentModel? _student;
  StudentModel? get student => _student;

// ADMIN LOGIN
  Future<void> login(String email, String password, UserRole userRole) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      final user = FirebaseAuth.instance.currentUser!.uid;
      print('$user id');
      await getCurrentUser(userRole);
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("id", FirebaseAuth.instance.currentUser!.uid);
      pref.setString("user_type", 'admin');

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

// ############## HELPRES

  Future<bool> checkUser(UserRole role, String phone) async {
    String collection = role == UserRole.staff
        ? 'staff'
        : role == UserRole.guardian
            ? 'guardian'
            : 'admin';
    bool checkIfUserExist = await FirebaseFirestore.instance
        .collection(collection)
        .where("phone", isEqualTo: phone)
        .get()
        .then((QuerySnapshot snapshot) {
      if (snapshot.docs.isNotEmpty) {
        print('Show Success Here Phone Exist IN DB');
        return true;
      } else {
        print('Show Error Here Phone not EXIST');
        return false;
      }
    });
    if (checkIfUserExist) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> loginGuardian(
      String email, String password, UserRole userRole) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      final user = FirebaseAuth.instance.currentUser!.uid;
      print(user);
      await getCurrentUser(userRole);
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("id", FirebaseAuth.instance.currentUser!.uid);
      pref.setString("user_type", 'admin');

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove("id");
    pref.remove("user_type");
    FirebaseAuth _auth = FirebaseAuth.instance;

    await _auth.signOut().then((value) {
      Get.offAll(WelcomeScreen());
    });
    notifyListeners();
  }

//  #################################################### NEED TO CHECK LATER ##########################################################

  Future<void> getCurrentUser(UserRole userRole) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    print(uid);
    print('///// THE UID OF STAFF //////');
    if (userRole == UserRole.staff) {
      final requiredUser = await FirebaseFirestore.instance
          .collection('staff')
          .where('id', isEqualTo: uid)
          .get();

      final userData = StaffsModel.fromJson(requiredUser.docs.first);
      // if (!userData.enabled!) {
      //   Get.snackbar('Error', 'Your account is disabled',
      //       snackPosition: SnackPosition.BOTTOM,
      //       backgroundColor: Colors.red,
      //       icon: const Icon(
      //         Icons.error,
      //         color: Colors.white,
      //       ));
      //   await FirebaseAuth.instance.signOut();
      //   throw Exception('You are not an staff');
      // }

      if (requiredUser.docs.isEmpty) {
        print('${userData.id} is empty UNAUTHORIZED');
        // Get.snackbar('UNAUTHORIZED', 'You are not registered as a dog staff',
        //     snackPosition: SnackPosition.BOTTOM,
        //     backgroundColor: Colors.red,
        //     icon: const Icon(
        //       Icons.error,
        //       color: Colors.white,
        //     ));
        await FirebaseAuth.instance.signOut();
        throw Exception('You are not an staff');
      }
      _staff = userData;
    } else if (userRole == UserRole.guardian) {
      final requiredUser = await FirebaseFirestore.instance
          .collection('guardian')
          .where('uid', isEqualTo: uid)
          .get();

      final userData = GuardianModel.fromJson(requiredUser.docs.first);
      //  ############ STUDENT TRY TO FETCH IT ##################
      String student = userData.myChildren!.first;
      DocumentReference studentFirebase =
          await FirebaseFirestore.instance.collection('children').doc(student);
      String studentID = await studentFirebase.id;
      final requiredStudent = await FirebaseFirestore.instance
          .collection('children')
          .where('id', isEqualTo: studentID)
          .get();
      final studentData = StudentModel.fromJson(requiredStudent.docs.first);
// ################## END ##########################
      // if (!userData.enabled!) {
      //   Get.snackbar('Error', 'Your account is disabled',
      //       snackPosition: SnackPosition.BOTTOM,
      //       backgroundColor: Colors.red,
      //       icon: const Icon(
      //         Icons.error,
      //         color: Colors.white,
      //       ));
      //   await FirebaseAuth.instance.signOut();
      //   throw Exception('You are not an staff');
      // }
      if (requiredUser.docs.isEmpty) {
        // Get.snackbar('UNAUTHORIZED', 'You are not registered as guardian',
        //     snackPosition: SnackPosition.BOTTOM,
        //     backgroundColor: Colors.red,
        //     icon: const Icon(
        //       Icons.error,
        //       color: Colors.white,
        //     ));
        // print('${userData.userId} guardian is empty UNAUTHORIZED');

        await FirebaseAuth.instance.signOut();

        throw Exception('You are not an guardian');
      }
      _guardian = userData;
      _student = studentData;
    } else if (userRole == UserRole.admin) {
      print('yes im admin | why not getting field');
      final requiredUserDoc =
          FirebaseFirestore.instance.collection('admin').doc(uid);

      final requiredUser = await requiredUserDoc.get();

      final userData = AdminModel.fromJson(requiredUser);

      if (!requiredUser.exists) {
        print('${userData.userId} admin is empty UNAUTHORIZED');

        await FirebaseAuth.instance.signOut();

        throw Exception('You are not an admin');
      }
      _admin = userData;
    } else {}

    notifyListeners();
  }

  Future<UserRole> getUserType() async {
    try {
      await getCurrentUser(UserRole.staff);
      return UserRole.staff;
    } catch (error) {
      print(error);
      try {
        await getCurrentUser(UserRole.guardian);
        return UserRole.guardian;
      } catch (error) {
        print(error);

        await getCurrentUser(UserRole.admin);
        return UserRole.admin;
      }
    }
  }
}
