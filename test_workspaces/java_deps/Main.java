import java.io.File;

import com.google.protobuf.RuntimeVersion;


public class Main {
  public static void main(String[] args) {
    // Check resolved version of Protobuf
    String expectedVersion = "4.34.0";
    String[] expectedVersionParts = expectedVersion.split("\\.");
    assert RuntimeVersion.MAJOR == Integer.parseInt(expectedVersionParts[0]): "Bad major runtime version: " + RuntimeVersion.MAJOR;
    assert RuntimeVersion.MINOR == Integer.parseInt(expectedVersionParts[1]): "Bad minor runtime version: " + RuntimeVersion.MINOR;
    assert RuntimeVersion.PATCH == Integer.parseInt(expectedVersionParts[2]): "Bad patch runtime version: " + RuntimeVersion.PATCH;

    // Check classpath only contains one version of Protobuf, in an incredibly fragile way...
    int protobufCount = 0;
    String classpath = System.getProperty("java.class.path");
    String[] classpathEntries = classpath.split(File.pathSeparator);
    for (String classpathEntry : classpathEntries) {
      String[] pathParts = classpathEntry.split(File.separator);
      String fileName = pathParts[pathParts.length - 1];
      String packageName = fileName.replaceFirst("^processed_", "").replaceFirst("-[^-]+\\.jar$", "");
      String packageVersion = fileName.replaceFirst("^.+-", "").replaceFirst("\\.jar$", "");
      System.out.println(packageName + " @ " + packageVersion);
      if (packageName.equals("protobuf-java")) {
        protobufCount++;
      }
    }
    assert protobufCount == 1 : "Found " + protobufCount + " versions of Protobuf";
  }
}
