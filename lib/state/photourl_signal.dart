import 'package:beatboks/firebase/firebase_service.dart';
import 'package:signals/signals.dart';

final Signal<String?> sPhotoURL =
    signal<String?>(FirebaseService().photoURL ?? '');
