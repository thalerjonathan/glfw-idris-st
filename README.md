# glfw-idris-st
A new library providing GLFW bindings for idris.
In contrast to the already existing glfw-idris https://github.com/eckart/glfw-idris library,
which is using Algebraic Effects, this one is using the ST approach as introduced in the
ST tutorial http://docs.idris-lang.org/en/latest/st/index.html and Edwin Bradys paper
https://www.idris-lang.org/drafts/sms.pdf

There exists two examples which both show how to initialize GLFW, create a window, initialize GLEW, render a rectangle and shutdown after 5 seconds. Both examples need the gl-idris-b library, available from https://github.com/thalerjonathan/gl-idris-b. 
- IOApi: uses the low-level API which is just a wrapper for foreign calls
- STApi: uses the dependently-typed high-level API which uses the ST approach and prevents (at compile time, that is!) e.g. creation of a window when GLFW is not created or prevents swapping the buffers when there exists no window