#include <iostream>

extern "C" __declspec(dllimport) int modul3(int x, int y, int z);


int vec[3] {100, 200, 300};

int main()
{
	std::cout << "\n\t\t  START.." << "\n\n";

	std::cout << "please, input X:\t";
	std::cin >> vec[0];

	std::cout << "please, input Y:\t";
	std::cin >> vec[1];
	
	std::cout << "please, input Z:\t";
	std::cin >> vec[2];

	std::cout << "\n\n\tvector \"vec\" = (" << vec[0] << " " << vec[1] << " " << vec[2] << ")" << std::endl;

	int result = 0;
	result = modul3(vec[0], vec[1], vec[2]);
	std::cout << "\n\tresult = " << result << std::endl;

	std::cout << "\n\t\t  ..BENE" << "\n\n";
	system("pause");
	return 0;
}