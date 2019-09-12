# Access method ActiveX from Java

This makes only sense, if any, if on Windows. In theory it can be achieved through:
* [JNI](https://docs.oracle.com/javase/8/docs/technotes/guides/jni/)
* [JACOB](https://sourceforge.net/projects/jacob-project/)
* [COM4J](https://github.com/kohsuke/com4j)

Maybe this is the only way to use the Btrieve API indirectly from Java. Although in theory SWIG can also be an option if one writes interface files.

Not surprisingly I have not written any demo code for this.

