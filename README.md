# glfw-idris-st
A new library providing GLFW bindings for idris.
In contrast to the already existing glfw-idris https://github.com/eckart/glfw-idris library,
which is using Algebraic Effects, this one is using the ST approach as introduced in the
ST tutorial http://docs.idris-lang.org/en/latest/st/index.html and Edwin Bradys paper
https://www.idris-lang.org/drafts/sms.pdf

Open Issues:
- Terrible compilation time of STApi example: canceled process after 30 mins
- Does not support multiple windows (calling createWindow twice is not possible, ensured through the types)
- Encode other invariants in types e.g. setSwapInterval and swapBuffer can only be called after makeContextCurrent 
- calling modifyIORef within a callback from GLFW crashes the application
