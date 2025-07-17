import com.google.protobuf.RuntimeVersion;

public class Main {
  public static void main(String[] args) {
    assert RuntimeVersion.MAJOR == 4: "Bad major runtime version: " + RuntimeVersion.MAJOR;
    assert RuntimeVersion.MINOR == 31: "Bad minor runtime version: " + RuntimeVersion.MINOR;
    assert RuntimeVersion.PATCH == 0: "Bad patch runtime version: " + RuntimeVersion.PATCH;
  }
}
