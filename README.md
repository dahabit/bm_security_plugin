# bm_security_plugin

Flutter root and jailbreak detection plugin. This plugin is a wrapper for Rootbeer (Android) and IOSSecuritySuite (iOS).

## Getting Started

1. Add this to pubspec.yaml:

```Dart
bm_security_plugin: any
```

2. Import package
```Dart
import 'package:bm_security_plugin/bm_security_plugin.dart';
```

3. Check for Jailbreak / Root
```Dart
await BMSecurityPlugin.deviceIsJailbroken;
```
