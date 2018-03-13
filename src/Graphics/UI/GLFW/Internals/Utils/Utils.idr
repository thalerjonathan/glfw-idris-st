module Graphics.UI.GLFW.Internals.Utils.Utils

%include C "glfw_idris_st.h"
%link C "glfw_idris_st.o"

export
allocIntArgPtr : IO Ptr
allocIntArgPtr
  = foreign FFI_C "allocIntArgPtr" (IO Ptr)

export
freeIntArgPtr : Ptr -> IO ()
freeIntArgPtr ptr
  = foreign FFI_C "freeIntArgPtr" (Ptr -> IO ()) ptr

export
intPtrToValue : Ptr -> IO Int
intPtrToValue ptr
  = foreign FFI_C "intPtrToValue" (Ptr -> IO Int) ptr