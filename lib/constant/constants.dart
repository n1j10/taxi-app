import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

FirebaseStorage storage = FirebaseStorage.instance;
final picker = ImagePicker();
DatabaseReference realTimeDatabaseRef = FirebaseDatabase.instance.ref();
FirebaseAuth auth = FirebaseAuth.instance;
// PersistentTabController partnerBottomNavbarController = PersistentTabController(initialIndex: 0);
// AudioPlayer audioPlayer = AudioPlayer();
