# glfw-idris-st
A new library providing GLFW bindings for Idris. In contrast to the already existing glfw-idris https://github.com/eckart/glfw-idris library,
which is using Algebraic Effects, this one is using the ST approach as introduced in the ST tutorial http://docs.idris-lang.org/en/latest/st/index.html and Edwin Bradys paper https://www.idris-lang.org/drafts/sms.pdf.

### Idris version: 1.2

### Library Dependencies
- glfw3: for loading the OpenGL functions on the respective system

### Building the library
Assuming you have installed Idris and it is on your path.

1. Make sure glfw3 is installed on your system and can be found by pkg-config. On Linux use the package manager of your system, on Mac OS X use brew install.
2. Download / clone glfw-idris-st.
3. Install the library by navigating to the glfw-idris-st folder and simply invoke 'make' in a terminal.

### Examples
There exist two examples which both show how to initialize GLFW, create a window, initialize GLEW, render a rectangle to the Window using OpenGL and shutdown after 5 seconds.

- IOApi: uses the low-level API which is just a wrapper for foreign calls.
- STApi: uses the dependently-typed high-level API which uses the ST approach and prevents (at compile time, that is!) e.g. creation of a window when GLFW is not created or prevents swapping the buffers when there exists no window.

#### Building and running the examples
Both examples need the gl-idris-b library, available from https://github.com/thalerjonathan/gl-idris-b.
Both examples depend on glew (due to gl-idris-b) for rendering a rectangle to the window. 

1. Assuming you have installed Idris and it is on your path and you have successfully built and installed glfw-idris-st on your system.
2. Make sure glew is installed on your system and can be found by pkg-config. On Linux use the package manager of your system, on Mac OS X use brew install.
3. Download / clone glfw-idris-st.
4. Navigate to src/examples where the examples are located.
5. Compile your example of choice by navigating to its folder and simply invoking 'make' in a terminal.
6. Run the example.