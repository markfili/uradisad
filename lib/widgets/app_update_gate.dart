import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_app_update/in_app_update.dart';

/// Play priority (0–5, set on upload via `fastlane android production priority:N`)
/// at or above which the update blocks the app instead of downloading in the background.
const _immediateUpdatePriority = 4;

/// Checks Google Play for a newer version once per launch (Android release builds only).
///
/// Normal updates download in the background and then offer a restart; high-priority
/// updates use Play's full-screen immediate flow.
class AppUpdateGate extends StatefulWidget {
  final Widget child;

  const AppUpdateGate({super.key, required this.child});

  @override
  State<AppUpdateGate> createState() => _AppUpdateGateState();
}

class _AppUpdateGateState extends State<AppUpdateGate> {
  @override
  void initState() {
    super.initState();
    final supported = !kIsWeb && kReleaseMode && defaultTargetPlatform == TargetPlatform.android;
    if (supported) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _checkForUpdate());
    }
  }

  Future<void> _checkForUpdate() async {
    try {
      final info = await InAppUpdate.checkForUpdate();

      // Downloaded in an earlier session but never installed.
      if (info.installStatus == InstallStatus.downloaded) {
        _offerRestart();
        return;
      }

      // An immediate update was interrupted (e.g. app killed) — Play requires resuming it.
      if (info.updateAvailability == UpdateAvailability.developerTriggeredUpdateInProgress) {
        await InAppUpdate.performImmediateUpdate();
        return;
      }

      if (info.updateAvailability != UpdateAvailability.updateAvailable) return;

      if (info.updatePriority >= _immediateUpdatePriority && info.immediateUpdateAllowed) {
        await InAppUpdate.performImmediateUpdate();
      } else if (info.flexibleUpdateAllowed) {
        // Completes once the download has finished.
        final result = await InAppUpdate.startFlexibleUpdate();
        if (result == AppUpdateResult.success) _offerRestart();
      }
    } on PlatformException {
      // Not installed from Play, no Play Store, offline, etc. — nothing to do.
    }
  }

  void _offerRestart() {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Nova verzija je preuzeta.'),
        duration: const Duration(days: 1),
        action: SnackBarAction(
          label: 'Ponovno pokreni',
          onPressed: () => InAppUpdate.completeFlexibleUpdate(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
