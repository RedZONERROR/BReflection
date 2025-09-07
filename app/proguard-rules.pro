# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile
-keep class red.blackreflection.** {*; }
-keep @red.blackreflection.annotation.BClass class * {*;}
-keep @red.blackreflection.annotation.BClassName class * {*;}
-keep @red.blackreflection.annotation.BClassNameNotProcess class * {*;}
-keepclasseswithmembernames class * {
    @red.blackreflection.annotation.BField.* <methods>;
    @red.blackreflection.annotation.BFieldNotProcess.* <methods>;
    @red.blackreflection.annotation.BFieldSetNotProcess.* <methods>;
    @red.blackreflection.annotation.BMethod.* <methods>;
    @red.blackreflection.annotation.BStaticField.* <methods>;
    @red.blackreflection.annotation.BStaticMethod.* <methods>;
}