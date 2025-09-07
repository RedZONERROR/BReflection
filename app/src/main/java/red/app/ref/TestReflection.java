package red.app.ref;

import red.blackreflection.annotation.BClass;
import red.blackreflection.annotation.BConstructor;
import red.blackreflection.annotation.BField;
import red.blackreflection.annotation.BMethod;
import red.blackreflection.annotation.BParamClassName;
import red.blackreflection.annotation.BStaticField;
import red.blackreflection.annotation.BStaticMethod;

/**
 * Created by Milk on 2022/2/16.
 * * ∧＿∧
 * (`･ω･∥
 * 丶　つ０
 * しーＪ
 * 此处无Bug
 */
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

    @BStaticField
    String fakeField();
}
