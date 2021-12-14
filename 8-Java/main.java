import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

public class main {
    static public String read_file(String path) {
        try {
            return Files.readString(Paths.get(path));
        } catch (IOException e) {
            return "";
        }
    }

    static public void main(String[] args) {

    }
}