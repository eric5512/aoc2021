module p2.main;

import std.stdio: writeln;
import std.file: readText;
import std.array: split;
import std.conv: to;
import std.string: chomp;
import std.math.algebraic: abs;
import std.functional: partial;
import std.algorithm.iteration: map, reduce, sum;
import std.algorithm.comparison : max, min;


auto parse_file(string file) {
    return map!(x => to!int(x))(split(chomp(readText(file)), ","));
}

int diff(int x, int y) {
    if (x < y) {
        return abs(x-y-1)*abs(x-y)/2;
    } else {
        return abs(y-x-1)*abs(y-x)/2;
    }
}

void main() {
    auto num_list = parse_file("sample.txt");
    int max_num = reduce!(max)(0, num_list);
    int[] res = new int[max_num+1]; 
    for (int i = 0; i <= max_num; ++i) {
        res[i] = sum(map!(partial!(diff,i))(num_list));
    }
    int result = reduce!(min)(int.max, res);
    writeln(result);
}