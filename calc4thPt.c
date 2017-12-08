#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "vpi_user.h"

int* calc(int x1, int y1, int x2, int y2, int x3, int y3){
	static int ans[2];
	int x4, y4;

	printf("1st pt: %d, %d\n", x1, y1);
	printf("2nd pt: %d, %d\n", x2, y2);
	printf("3rd pt: %d, %d\n", x3, y3);


	// calculate distance between pt1 and pt2
	double d12 = sqrt( pow((y2 - y1), 2) + pow((x2 - x1), 2) );
	// calculate distance between pt1 and pt3
	double d13 = sqrt( pow((y3 - y1), 2) + pow((x3 - x1), 2) );
	// calculate distance between pt2 and pt3
	double d23 = sqrt( pow((y2 - y3), 2) + pow((x2 - x3), 2) );

	printf("1st distance: %f\n", d12);
	printf("2nd distance: %f\n", d13);
	printf("3rd distance: %f\n", d23);
	double distances[3] = { d12, d13, d23 };
	// We're assuming we don't get equilateral or isoceles triangles, because that'll be baaaaad

	// if statements: if distance[0] is largest, then this 4th point will be between 1 & 2
	if ((distances[0] >= distances[1]) && (distances[0] >= distances[2])){
		// calculate the 4th point

		// get the slope between pt 3 and pt 2
		int x_displ = (x2 - x3);
		int y_displ = (y2 - y3);

		// get x4 and y4 from applying  x_displ and y_displ to pt 1
		x4 = x_displ + x1;
		y4 = y_displ + y1;

	} 
	// if distance[1] is largest, then this 4th point will be between 1 & 3
	else if ((distances[1] >= distances[2]) && (distances[1] >= distances[0])){
		// calculate the 4th point

		// get the slope between pt 3 and pt 2
		int x_displ = (x3 - x2);
		int y_displ = (y3 - y2);

		// get x4 and y4 from applying  x_displ and y_displ to pt 1
		x4 = x_displ + x1;
		y4 = y_displ + y1;
	} 
	// if distance[2] is largest, then this 4th point will be between 2 & 3
	else if ((distances[2] >= distances[1]) && (distances[2] >= distances[0])) {
		// calculate the 4th point

		// get the slope between pt 1 and pt 2
		int x_displ = (x2 - x1);
		printf("x_displ: %d\n", x_displ);
		int y_displ = (y2 - y1);
		printf("y_displ: %d\n", y_displ);

		x4 = x_displ + x3;
		y4 = y_displ + y3;

	}

	ans[0] = x4;
	ans[1] = y4;

	return ans;
}


int calc_x(int x1, int y1, int x2, int y2, int x3, int y3){
	int x4;

	// calculate distance between pt1 and pt2
	double d12 = sqrt( pow((y2 - y1), 2) + pow((x2 - x1), 2) );
	// calculate distance between pt1 and pt3
	double d13 = sqrt( pow((y3 - y1), 2) + pow((x3 - x1), 2) );
	// calculate distance between pt2 and pt3
	double d23 = sqrt( pow((y2 - y3), 2) + pow((x2 - x3), 2) );


	double distances[3] = { d12, d13, d23 };
	// We're assuming we don't get equilateral or isoceles triangles, because that'll be baaaaad

	// if statements: if distance[0] is largest, then this 4th point will be between 1 & 2
	if ((distances[0] >= distances[1]) && (distances[0] >= distances[2])){
		// calculate the 4th point

		// get the slope between pt 3 and pt 2
		int x_displ = (x2 - x3);


		x4 = x_displ + x1;

	} 
	// if distance[1] is largest, then this 4th point will be between 1 & 3
	else if ((distances[1] >= distances[2]) && (distances[1] >= distances[0])){
		// calculate the 4th point

		// get the slope between pt 3 and pt 2
		int x_displ = (x3 - x2);


		x4 = x_displ + x1;
	} 
	// if distance[2] is largest, then this 4th point will be between 2 & 3
	else if ((distances[2] >= distances[1]) && (distances[2] >= distances[0])) {
		// calculate the 4th point

		// get the slope between pt 1 and pt 2
		int x_displ = (x2 - x1);

		x4 = x_displ + x3;

	}

	return x4;
}

int calc_y(int x1, int y1, int x2, int y2, int x3, int y3){
	int y4;

	// calculate distance between pt1 and pt2
	double d12 = sqrt( pow((y2 - y1), 2) + pow((x2 - x1), 2) );
	// calculate distance between pt1 and pt3
	double d13 = sqrt( pow((y3 - y1), 2) + pow((x3 - x1), 2) );
	// calculate distance between pt2 and pt3
	double d23 = sqrt( pow((y2 - y3), 2) + pow((x2 - x3), 2) );


	double distances[3] = { d12, d13, d23 };
	// We're assuming we don't get equilateral or isoceles triangles, because that'll be baaaaad

	// if statements: if distance[0] is largest, then this 4th point will be between 1 & 2
	if ((distances[0] >= distances[1]) && (distances[0] >= distances[2])){
		// calculate the 4th point

		// get the slope between pt 3 and pt 2
		int y_displ = (y2 - y3);

		y4 = y_displ + y1;

	} 
	// if distance[1] is largest, then this 4th point will be between 1 & 3
	else if ((distances[1] >= distances[2]) && (distances[1] >= distances[0])){
		// calculate the 4th point

		// get the slope between pt 3 and pt 2
		int y_displ = (y3 - y2);


		y4 = y_displ + y1;
	} 
	// if distance[2] is largest, then this 4th point will be between 2 & 3
	else if ((distances[2] >= distances[1]) && (distances[2] >= distances[0])) {
		// calculate the 4th point

		// get the slope between pt 1 and pt 2
		int y_displ = (y2 - y1);

		y4 = y_displ + y3;

	}

	return y4;
}

int main() {

	// pointer to an int
	int *p;
	int i;
	p = calc(3, 3, 0, 2, 1, 1);
	int x4 = calc_x(3, 3, 0, 2, 1, 1);
	int y4 = calc_y(3, 3, 0, 2, 1, 1);
	printf("x4: %d\n", x4);
	printf("y4: %d\n", y4);

	printf("x4: %d\t y4: %d\n", *(p), *(p+1));

	return 0;
}