#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <vpi_user.h>


int counter = 0;
static int pts[8];

static int calc_x(int x1, int y1, int x2, int y2, int x3, int y3){
  int x4 = 0;

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

static int calc_y(int x1, int y1, int x2, int y2, int x3, int y3){
  int y4 = 0;

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


static int compiletf(char*user_data)
{
      return 0;
}

// Implements the increment system task
static int function(char *userdata) {
  vpi_printf("%d\n", counter);

  vpiHandle systfref, args_iter, argh;
  struct t_vpi_value argval;
  int value;

  // Obtain a handle to the argument list
  systfref = vpi_handle(vpiSysTfCall, NULL);
  args_iter = vpi_iterate(vpiArgument, systfref);
  
  // Grab the value of the first argument
  argh = vpi_scan(args_iter);
  argval.format = vpiIntVal;
  vpi_get_value(argh, &argval);
  value = argval.value.integer;
  vpi_printf("VPI routine received %d\n", value);

  // save the argval into the pts array
  
  if (counter < 6){
    pts[counter] = value;
  }
  
  // at the 7th index, calculate the x value of the rectangle
  else if (counter == 6){
    pts[counter] = calc_x(pts[0], pts[1], pts[2], pts[3], pts[4], pts[5]);
    argval.value.integer = pts[counter];
    vpi_put_value(argh, &argval, NULL, vpiNoDelay);
  }
  else if (counter == 7){
    pts[counter] = calc_y(pts[0], pts[1], pts[2], pts[3], pts[4], pts[5]);
    argval.value.integer = pts[counter];
    vpi_put_value(argh, &argval, NULL, vpiNoDelay);

  }

  for (int i = 0; i < 8; ++i){
    vpi_printf("pts[%d]: %d\n", i, pts[i]);
  }


// // leave for the end:
//   vpi_put_value(argh, &argval, NULL, vpiNoDelay);

  // Cleanup and return
  vpi_free_object(args_iter);
  counter++;
  return 0;
}


void testregister()
{
      s_vpi_systf_data tf_data;

      tf_data.type      = vpiSysTask;
      tf_data.tfname    = "$function";
      tf_data.calltf    = function;
      tf_data.compiletf = compiletf;
      tf_data.sizetf    = 0;
      tf_data.user_data = 0;
      vpi_register_systf(&tf_data);
}

void (*vlog_startup_routines[])() = {
    testregister,
    0
};