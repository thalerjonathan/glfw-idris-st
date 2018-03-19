module Graphics.UI.GLFW.Internals.Utils

%include C "glfw_idris_st.h"
%link C "glfw_idris_st.o"

export
nextIntArgPtr : IO Ptr
nextIntArgPtr
  = foreign FFI_C "nextIntArgPtr" (IO Ptr)

export
intPtrToValue : Ptr -> IO Int
intPtrToValue ptr
  = foreign FFI_C "intPtrToValue" (Ptr -> IO Int) ptr

export
sleepMillis : Int -> IO ()
sleepMillis millis
  = foreign FFI_C "sleepMillis" (Int -> IO ()) millis