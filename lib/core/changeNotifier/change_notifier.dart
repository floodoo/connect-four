import 'package:connect_four/core/audio/audio.controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final audioController = ChangeNotifierProvider((ref) => AudioController());
