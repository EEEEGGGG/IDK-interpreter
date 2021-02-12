#include <iostream>
#include <fstream>
#include <cstdlib>
#include <cstdio>
using namespace std;

int error_exit(char error_msg[]) {
	printf("\aerror: %s", error_msg);
	return 1;
}

int stdinMode() {
	cout << "stdin ";
	return 0;
}

int fileMode(string file) {
	cout << "file: " << file << " ";
	return 0;
}

int debugMode() {
	cout << "debug ";
	return 0;
}

int main(int argc, char *argv[]) {
	for ( int i = 1; i < argc; ++i ) {
		string argument = argv[i]; // bad, please fix.
		if ( argument == "-d" ) {
			debugMode();
		} else if ( argument == "-s" ) {
			stdinMode();
		} else if ( argument == "-f" ) {
			fileMode(argv[i + 1]); // bad, please fix.
			i++;
		}
	}
	return 0;
}
