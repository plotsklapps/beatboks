import 'package:beatboks/firebase/firebase_service.dart';
import 'package:signals/signals.dart';

final Signal<String?> sEmail = signal<String?>(FirebaseService().email ?? '');

final Signal<bool?> sEmailVerified =
    signal<bool?>(FirebaseService().emailVerified ?? false);
