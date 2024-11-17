#include <sys/stat.h>
#include <stdio.h>

void main()
{
int status = mkdir("tempdir", 755);
	if (status != 0) {
		printf ("mkdir failed!\n");
	}
}
