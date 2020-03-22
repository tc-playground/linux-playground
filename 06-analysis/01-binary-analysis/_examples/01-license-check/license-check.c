#include <string.h>
#include <stdio.h>

// A simple 'license check` C program examples.
//
// https://www.youtube.com/watch?v=VroEiMOJPm8&list=PLhixgUqwRTjxglIswKp9mpkfPNfHkzyeN&index=6
// https://github.com/LiveOverflow/liveoverflow_youtube/blob/master/0x05_simple_crackme_intro_assembler/license_1.c

int main(int argc, char *argv[]) {
        if (argc==2) {
		printf("Checking License: %s\n", argv[1]);
		if(strcmp(argv[1], "AAAA-Z10N-42-OK")==0) {
			printf("Access Granted!\n");
		} else {
			printf("WRONG!\n");
		}
	} else {
		printf("Usage: <key>\n");
	}
	return 0;
}