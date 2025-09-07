# How to Use BlackReflection Libraries

## Files in this folder:
- `core-1.0.0.jar` - Runtime library with annotations and utilities
- `compiler-1.0.0.jar` - Annotation processor for code generation
- `*.pom` files - Maven metadata files

## Method 1: Using in Android Project with Gradle

Add to your `app/build.gradle`:

```gradle
dependencies {
    implementation files('libs/red/blackreflection/core-1.0.0.jar')
    annotationProcessor files('libs/red/blackreflection/compiler-1.0.0.jar')
}
```

## Method 2: Copy to libs folder

1. Copy the JAR files to your project's `app/libs/` directory
2. Add to your `app/build.gradle`:

```gradle
dependencies {
    implementation fileTree(dir: 'libs', include: ['*.jar'])
    annotationProcessor files('libs/compiler-1.0.0.jar')
}
```

## Method 3: Using Local Maven Repository

If you have published to local Maven repository, add:

```gradle
repositories {
    mavenLocal()
}

dependencies {
    implementation 'red.blackreflection:core:1.0.0'
    annotationProcessor 'red.blackreflection:compiler:1.0.0'
}
```

## Usage Example:

```java
// Define interface with annotations
@BClass(TargetClass.class)
public interface TargetClassReflection {
    @BMethod("methodName")
    String callMethod();
    
    @BField("fieldName")
    void setField(String value);
    
    @BField("fieldName")
    String getField();
}

// Use the generated class
TargetClass instance = new TargetClass();
TargetClassReflection reflection = BRTargetClassReflection.get(instance);
reflection.callMethod();
```

## Package Structure:
- Main package: `red.blackreflection`
- Annotations: `red.blackreflection.annotation`
- Utilities: `red.blackreflection.utils`