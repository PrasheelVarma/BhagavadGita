import 'url_launcher_stub.dart'
    if (dart.library.html) 'url_launcher_web.dart';

/// Opens an external URL in a new browser tab on Web, safely no-ops on other platforms.
void launchUrlSafely(String url) {
  openExternalUrl(url);
}
