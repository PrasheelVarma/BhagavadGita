import 'dart:io';

void main() {
  final pkgConfigFile = File('.dart_tool/package_config.json');
  final content = pkgConfigFile.readAsStringSync();
  final match = RegExp(r'"name": "just_audio",\s+"rootUri": "([^"]+)"').firstMatch(content);
  if (match != null) {
    final uri = Uri.parse(match.group(1)!);
    final filePath = uri.toFilePath() + '/lib/just_audio.dart';
    final file = File(filePath);
    if (file.existsSync()) {
      final code = file.readAsStringSync();
      var idx = 0;
      while ((idx = code.indexOf('playCompleter', idx)) != -1) {
        print('---');
        print(code.substring(idx - 50, idx + 200));
        idx += 'playCompleter'.length;
      }
    }
  }
}
