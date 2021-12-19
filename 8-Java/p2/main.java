package p2;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Scanner;
import java.util.Set;
import java.util.stream.Collectors;

public class main {
    public static void dump_array(String[] sn) {
        for (String string : sn) {
            System.out.println(string == null);
        }
    }
    
    public static ArrayList<Set<Integer>> get_set_nums(String[] pattern) {
        ArrayList<String> numbers = new ArrayList<String>(Arrays.asList(new String[10]));
        ArrayList<String> resto = new ArrayList<>();
        
        for (String string : pattern) {
            if (string.length() == 2) {
                numbers.set(1, string);
            } else if (string.length() == 4) {
                numbers.set(4, string);
            } else if (string.length() == 3) {
                numbers.set(7, string);
            } else if (string.length() == 7) {
                numbers.set(8, string);
            } else {
                resto.add(string);
            }
        }
        
        for (String string : resto) {
            int aux1 = find_not_matched(numbers.get(1), string);
            int aux2 = find_not_matched(numbers.get(4), string);
            int aux3 = find_not_matched(numbers.get(7), string);
            int aux4 = find_not_matched(numbers.get(8), string);

            switch (aux1*2+aux2+aux3+aux4) {
                case 16:
                    numbers.set(0, string);
                    break;
                case 21:
                    numbers.set(2, string);
                    break;
                case 13:
                    numbers.set(3, string);
                    break;
                case 19:
                    numbers.set(5, string);
                    break;
                case 22:
                    numbers.set(6, string);
                    break;
                case 14:
                    numbers.set(9, string);
                    break;
             
                default:
                    assert false;
                    break;
            }
        }

        return new ArrayList<Set<Integer>>(numbers.stream().map(e->e.chars().boxed().collect(Collectors.toSet())).collect(Collectors.toList()));
    }

    public static int find_not_matched(String s1, String s2) {
        int count = 0;
        for (char c : s1.toCharArray()) {
            if (!s2.contains(Character.toString(c)))
                count++;
        }

        for (char c : s2.toCharArray()) {
            if (!s1.contains(Character.toString(c)))
                count++;
        }

        return count;
    }
    
    public static int str_to_int(ArrayList<Set<Integer>> numbers, String num) {
        return numbers.indexOf(num.chars().boxed().collect(Collectors.toSet()));
    }

    public static int solution(String file) {
        try {
            File f = new File(file);
            Scanner reader = new Scanner(f);
            int counter = 0;
            while (reader.hasNextLine()) {
                String[] data = reader.nextLine().trim().split(" \\| ");
                String[] pattern = data[0].trim().split(" ");
                String[] digits = data[1].trim().split(" ");
                
                ArrayList<Set<Integer>> set = get_set_nums(pattern);

                for (int i = 0; i < 4; i++)
                    counter += str_to_int(set, digits[3-i])*Math.pow(10, i);
            }

            reader.close();
            return counter;
        } catch (IOException e) {
            System.out.println("File not found");
            return -1;
        }
    }
    public static void main(String[] args) {
        /*String[] nums = {"abcefg", "acdeg", "acdfg", "abdfg", "abdefg", "abcdfg"};
        for (String string : nums) {
            System.out.println(find_not_matched(string, "cf")*2+ find_not_matched("bcdf", string) + find_not_matched("acf", string) + find_not_matched("abcdefg", string));
        }*/
        System.out.println(solution("input.txt"));
    }
}
