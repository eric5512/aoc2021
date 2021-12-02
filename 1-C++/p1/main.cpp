#include <iostream>
#include <fstream>

int main() {
	int num, prev_num;
	int count = 0;
	std::ifstream file;
	
	file.open("input.txt");
	if (!file) {
		std::cout << "Coudn't open the file.\n";
		return 1;
	}
	
	file >> prev_num;
	
	while(file >> num) {
		if (num > prev_num)
			count++;
		
		prev_num = num;
	}
	
	std::cout << "The result is: " << count << '\n';
	
	return 0;
}
