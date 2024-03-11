import 'package:signals/signals.dart';

final Signal<String?> sEmail = signal<String?>('JohnDoe@email.com');

final Signal<bool?> sEmailVerified = signal<bool?>(false);
