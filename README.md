# bugs_scanner

A new flutter plugin project.

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Note: During generation using ffigen. extern "C" __attribute__((visibility("default"))) __attribute__((used)) needs to be removed from .hpp file
the attribute is not required in the .cpp file but needs to be readded to .hpp file after ffigen is done with binding generation
