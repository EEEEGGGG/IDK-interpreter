#include <iostream>
#include <fstream>
#include <cstdlib>
using namespace std;

int debugMode() {
	cout << "debug";
	return 0;
}

int main(int argc, char *argv[]) {
	// debug
	bool dbg;
	for ( int i = 1; i < argc; ++i ) {
		string argument = argv[i];
		if ( argument == "-d" && dbg != true ) {
			dbg = true;
			debugMode();
		}
	}
	return 0;
}
