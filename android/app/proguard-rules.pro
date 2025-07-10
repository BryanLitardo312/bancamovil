# Mantén las clases necesarias para Flutter y Play Core
-keep class io.flutter.** { *; }
-keep class com.google.android.play.core.** { *; }
-keep class com.google.android.play.core.splitinstall.** { *; }
-keep class com.google.android.play.core.tasks.** { *; }

# Evita advertencias relacionadas con Play Core
-dontwarn com.google.android.play.core.**
-dontwarn com.google.android.play.core.splitinstall.**
-dontwarn com.google.android.play.core.tasks.**

# Mantén las clases necesarias para JSON y serialización
-keepattributes Signature
-keepattributes *Annotation*
-keep class kotlin.** { *; }
-keep class com.google.gson.** { *; }