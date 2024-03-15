import 'package:intl/intl.dart';
import 'package:signals/signals.dart';

final Signal<String> sCreationDate =
    signal<String>(DateFormat('dd-MM-yyyy').format(DateTime.now()));
