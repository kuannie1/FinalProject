# Developing a GPU

Anne Ku, Joseph Lee, Kimberly Winter, Sungwoo Park

## Description
We plan on implementing a simple GPU, in verilog and on an FPGA. Our GPU starts with our instruction set. This instruction set will encode the triangle or square we want, the key points, RGB color values, and operations such as fill with color. After decoding our instruction, the GPU calculates an updated set of vertices based on the operations encoded in the instructions. After the GPU calculates the set of vertices, the shape gets rasterized and processed so that the pixels can get displayed. 

## References
https://electronics.stackexchange.com/questions/15811/where-to-start-when-considering-making-a-gpu 

http://download.nvidia.com/developer/GPU_Gems_2/GPU_Gems2_ch30.pdf 

http://www.d.umn.edu/~data0003/Talks/gpuarch.pdf 

## Minimum, planned, and stretch deliverables
Our minimum deliverable is a verilog implementation of a GPU that can display shapes, such as triangles and squares, on the screen. If we finish this on time, we’re planning to account for other shapes such as circles and dodecahedrons. Other ambitions include additional features such as ray tracing, 3D rotation, shading, and more. 

## Work plan
**11/28** - Work plan and project proposal written, approved by Benjamin T. Hill
**12/1** - Finish top-level module design
**12/5** - Complete individual components (rasterizer, decoder, pixel operator, etc.) and their testbenches for midpoint check-in, debug debug debug
**12/8**- Debugging and adding additional features
**12/12** - final deliverable due
