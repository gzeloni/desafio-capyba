import 'package:flutter/material.dart';

/// Essa GlobalKey torna possível o uso do ScaffoldMessenger
/// em qualquer tela, tem precisar passar um context
final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();
