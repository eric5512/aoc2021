#include <iostream>
#include <fstream>

int main() {
	int num[3], sum, prev_sum, i = 0;
	int count = 0;
	std::ifstream file;
	
	file.open("input.txt");
	if (!file) {
		std::cout << "Coudn't open the file.\n";
		return 1;
	}
	
	file >> num[0] >> num[1] >> num[2];
	prev_sum = num[0] + num[1] + num[2];
	
	while(file >> num[i]) {
		sum = num[0] + num[1] + num[2];
		if (sum > prev_sum)
			count++;
		
		prev_sum = sum;
		i = (i + 1) % 3;
	}
	
	std::cout << "The result is: " << count << '\n';
	
	return 0;
}
