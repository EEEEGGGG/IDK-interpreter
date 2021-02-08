#include <iostream>
#include <fstream>
#include <cstdlib>
using namespace std;

int stdinMode() {
	cout << "stdin";
	return 0;
}

int debugMode() {
	cout << "debug";
	return 0;
}

int main(int argc, char *argv[]) {
	for ( int i = 1; i < argc; ++i ) {
		string argument = argv[i];
		if ( argument == "-d" ) {
			debugMode();
		} else if ( argument == "-s" ) {
			stdinMode();
		}
	}
	return 0;
}
