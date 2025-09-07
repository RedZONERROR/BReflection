# BReflection - Java Reflection Library

![](https://img.shields.io/badge/language-java-brightgreen.svg)
![](https://img.shields.io/badge/gradle-8.12-blue.svg)
![](https://img.shields.io/badge/java-17-orange.svg)
![](https://img.shields.io/badge/android--gradle--plugin-8.7.3-green.svg)

## About This Fork

BReflection is a modern Java reflection library, forked and completely rewritten from the original BlackReflection. This version has been modernized for current development needs with removed external dependencies and significant improvements while maintaining core functionality.

### Original Project Credits
- **Original Author**: [Milk (CodingGay)](https://github.com/CodingGay)
- **Original Repository**: [BlackReflection](https://github.com/CodingGay/BlackReflection)
- **Original License**: Apache License 2.0

### Why BReflection?

The original BlackReflection used the package name `top.niunaijun.blackreflection`, which is widely used across many projects. To avoid conflicts and provide better isolation, BReflection provides:

- **Custom package name**: `red.blackreflection` (avoiding conflicts with the original)
- **Modern toolchain**: Updated to latest Gradle, Java 17, and Android tools
- **Independent development**: No external dependencies or JitPack requirements
- **Local library support**: Easy to integrate as local JAR files

## Major Changes in BReflection

### 🔄 Package Rename
- **Old Package**: `top.niunaijun.blackreflection`
- **New Package**: `red.blackreflection`
- **Reason**: Avoid conflicts with the widely-used original package

### 🚀 Toolchain Upgrades
- **Gradle**: 7.6 → **8.12**
- **Android Gradle Plugin**: 4.2.0 → **8.7.3**
- **Java Version**: 8 → **17**
- **Compile SDK**: 30 → **35**
- **Target SDK**: 30 → **35**
- **Dependencies**: Updated all to latest versions

### 🏗️ Build System Improvements
- **Configuration Cache**: Enabled for faster builds
- **Parallel Builds**: Enabled for better performance
- **Build Cache**: Enabled for incremental builds
- **Memory Optimization**: Increased JVM heap to 4GB

### 📦 Distribution Method
- **Removed JitPack dependency**: No longer requires external repository
- **Local library support**: Build script creates local JAR files
- **Maven Local**: Publishes to local Maven repository
- **Standalone**: Can be used without internet connection

## Installation & Usage

### Method 1: Using JitPack (Recommended)

Add JitPack repository to your root `build.gradle`:
```gradle
allprojects {
    repositories {
        google()
        mavenCentral()
        maven { url 'https://jitpack.io' }
    }
}
```

Add dependencies to your app `build.gradle`:
```gradle
dependencies {
    implementation 'com.github.redzonerror.BReflection:core:1.0.0'
    annotationProcessor 'com.github.redzonerror.BReflection:compiler:1.0.0'
}
```

### Method 2: Using GitHub Releases

1. Download JAR files from [Releases](https://github.com/redzonerror/BReflection/releases)
2. Copy to your project's `app/libs/` directory
3. Add to your `app/build.gradle`:
```gradle
dependencies {
    implementation files('libs/core-1.0.0.jar')
    annotationProcessor files('libs/compiler-1.0.0.jar')
}
```

### Method 3: Build from Source

1. Clone the repository:
   ```bash
   git clone https://github.com/redzonerror/BReflection.git
   ```

2. Build and publish to local Maven:
   ```bash
   ./gradlew publishToMavenLocal
   ```

3. Add to your `build.gradle`:
   ```gradle
   repositories {
       mavenLocal()
   }
   
   dependencies {
       implementation 'red.blackreflection:core:1.0.0'
       annotationProcessor 'red.blackreflection:compiler:1.0.0'
   }
   ```

### Demo
#### 1. If you need to reflect the methods of red.app.bean.TestReflection, please refer to：[MainActivity.java](https://github.com/CodingGay/BlackReflection/blob/main/app/src/main/java/top/niunaijun/app/MainActivity.java)
```java
public class TestReflection {
    public static final String TAG = "TestConstructor";

    public String mContextValue = "context value";
    public static String sStaticValue = "static value";

    public TestReflection(String a) {
        Log.d(TAG, "Constructor called :" + a);
    }

    public TestReflection(String a, String b) {
        Log.d(TAG, "Constructor called : a = " + a + ", b = " + b);
    }

    public String testContextInvoke(String a, int b) {
        Log.d(TAG, "Context invoke: a = " + a + ", b = " + b);
        return a + b;
    }

    public static String testStaticInvoke(String a, int b) {
        Log.d(TAG, "Static invoke: a = " + a + ", b = " + b);
        return a + b;
    }

    public static String testParamClassName(String a, int b) {
        Log.d(TAG, "testParamClassName: a = " + a + ", b = " + b);
        return a + b;
    }
}

```
You can write an interface like this:
```java
@BClass(red.app.bean.TestReflection.class)
public interface TestReflection {

    @BConstructor
    red.app.bean.TestReflection _new(String a, String b);

    @BConstructor
    red.app.bean.TestReflection _new(String a);

    @BMethod
    String testContextInvoke(String a, int b);

    @BStaticMethod
    String testStaticInvoke(String a, int b);

    @BStaticMethod
    String testParamClassName(@BParamClassName("java.lang.String") Object a, int b);

    @BField
    String mContextValue();

    @BStaticField
    String sStaticValue();
}

```
#### 2. Build your project, it will generate the code automatically.

#### 3. Write the code heartily!
Constructor:
```java
TestReflection testReflection = BRTestReflection.get()._new("a");
TestReflection testReflection = BRTestReflection.get()._new("a", "b");
```

Reflect Methods:
```java
// Static Method
BRTestReflection.get().testStaticInvoke("static", 0);

// Non-static Method
BRTestReflection.get(testReflection).testContextInvoke("context", 0);
```

Reflect Fields:
```java
// Static Field
String staticValue = BRTestReflection.get().sStaticValue();

// Non-static Field
String contextValue = BRTestReflection.get(testReflection).mContextValue();
```

Set the value of Fields:
```java
// Static Field
BRTestReflection.get()._set_sStaticValue(staticValue + " changed");

// Non-static Field
BRTestReflection.get(testReflection)._set_mContextValue(contextValue + " changed");
```
BRTestReflection is a class which generated by the program automatically.
Generation rule: BR + ClassName
- BRTestReflection.get() ------> It is used to invoke static method
- BRTestReflection.get(caller) ------> It is used to invoke non-static method
#### Annotation API

Annotation | Target | Description
---|---|---
@BClass | Type(Class) | Assign the class which you want to manipulate
@BClassName | Type(Class) | Assign the class which you want to manipulate
@BConstructor | Method | Assign the constructor
@BStaticMethod | Method | Assign the static method
@BMethod | Method | Assign the non-static method
@BStaticField | Method | Assign the static field
@BField | Method | Assign the non-static field
@BParamClass | Parameter | Assign the class of parameter
@BParamClassName | Parameter | Assign the class of parameter

## Building from Source

### Prerequisites
- **Java 17** or higher
- **Gradle 8.12** (included via wrapper)
- **Android SDK** (for demo app)

### Build Commands
```bash
# Clean and build all modules
./gradlew clean build

# Publish to local Maven repository
./gradlew publishToMavenLocal

# Build and copy libraries to local-libs folder
.\build-and-copy-libs.bat
```

### Project Structure
```
BReflection/
├── app/                    # Android demo application
├── core/                   # Runtime library (annotations & utilities)
├── compiler/               # Annotation processor
├── local-libs/             # Generated local library files
├── build-and-copy-libs.bat # Build script for local libraries
└── README.md              # This file
```

## Author

**S Kumar** (redzonerror)
- GitHub: [@redzonerror](https://github.com/redzonerror)
- Email: redzonerror@gmail.com

## ProGuard/R8 Rules

**Important**: Update your ProGuard rules to use the new package name:

```proguard
-keep class red.blackreflection.** {*; }
-keep @red.blackreflection.annotation.BClass class * {*;}
-keep @red.blackreflection.annotation.BClassName class * {*;}
-keep @red.blackreflection.annotation.BClassNameNotProcess class * {*;}
-keepclasseswithmembernames class * {
    @red.blackreflection.annotation.BField.* <methods>;
    @red.blackreflection.annotation.BFieldNotProcess.* <methods>;
    @red.blackreflection.annotation.BFieldSetNotProcess.* <methods>;
    @red.blackreflection.annotation.BFieldCheckNotProcess.* <methods>;
    @red.blackreflection.annotation.BMethod.* <methods>;
    @red.blackreflection.annotation.BStaticField.* <methods>;
    @red.blackreflection.annotation.BStaticMethod.* <methods>;
    @red.blackreflection.annotation.BMethodCheckNotProcess.* <methods>;
    @red.blackreflection.annotation.BConstructor.* <methods>;
    @red.blackreflection.annotation.BConstructorNotProcess.* <methods>;
}
```

## Migration from Original BlackReflection

If you're migrating from the original BlackReflection:

1. **Update package imports**:
   ```java
   // Old
   import top.niunaijun.blackreflection.annotation.*;
   
   // New
   import red.blackreflection.annotation.*;
   ```

2. **Update ProGuard rules** (see above)

3. **Change dependency declaration** (see Installation section)

## Changelog

### Version 1.0.0 (BReflection)
- 🔄 **Package renamed** from `top.niunaijun.blackreflection` to `red.blackreflection`
- 🚀 **Upgraded to Gradle 8.12** with configuration cache support
- ☕ **Updated to Java 17** for better performance and modern features
- 📱 **Updated Android target SDK to 35** with latest dependencies
- 🏗️ **Improved build system** with parallel builds and caching
- 📦 **Added local library build script** for easy distribution
- 🔧 **Modernized project structure** and build configurations
- 📚 **Updated documentation** with migration guide and new usage instructions

## Contributing

BReflection is maintained by S Kumar (redzonerror). Contributions are welcome! Please feel free to submit issues and pull requests.

For the original BlackReflection project, visit the [original repository](https://github.com/CodingGay/BlackReflection).

## Acknowledgments

Special thanks to **Milk (CodingGay)** for creating the original BlackReflection library that inspired this fork. The core reflection concepts and annotation-based approach remain true to the original vision.
## License

This fork maintains the same Apache License 2.0 as the original project:

```
Copyright 2022 Milk (Original BlackReflection)
Copyright 2025 S Kumar (BReflection)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

---

**Note**: BReflection is an independent project based on BlackReflection. For the original project, visit: https://github.com/CodingGay/BlackReflection
