package p1;
import java.io.File;
import java.io.IOException;
import java.util.Scanner;

public class main {
    static public int solution(String path) {
        try {
            File f = new File(path);
            Scanner reader = new Scanner(f);
            int counter = 0;
            while (reader.hasNextLine()) {
                String[] data = reader.nextLine().trim().split(" \\| ")[1].trim().split(" ");
                for (String string : data) {
                    if (string.length() == 2 || string.length() == 3 || string.length() == 4 || string.length() == 7)
                        counter++;
                }
            }

            reader.close();
            return counter;
        } catch (IOException e) {
            System.out.println("File not found");
            return -1;
        }
    }

    static public void main(String[] args) {
        System.out.println(solution("input.txt"));
    }
}