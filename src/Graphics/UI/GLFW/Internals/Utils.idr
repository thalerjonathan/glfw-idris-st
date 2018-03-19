module Graphics.UI.GLFW.Internals.Utils

%include C "glfw_idris_st.h"
%link C "glfw_idris_st.o"

public export
IntPtr : Type
IntPtr = Ptr

public export
DoublePtr : Type
DoublePtr = Ptr

export
nextIntArgPtr : IO IntPtr
nextIntArgPtr
  = foreign FFI_C "nextIntArgPtr" (IO Ptr)

export
nextDoubleArgPtr : IO DoublePtr
nextDoubleArgPtr
  = foreign FFI_C "nextDoubleArgPtr" (IO Ptr)

export
intPtrToValue : IntPtr -> IO Int
intPtrToValue ptr
  = foreign FFI_C "intPtrToValue" (Ptr -> IO Int) ptr

export
doublePtrToValue : DoublePtr -> IO Double
doublePtrToValue ptr
  = foreign FFI_C "doublePtrToValue" (Ptr -> IO Double) ptr

export
sleepMillis : Int -> IO ()
sleepMillis millis
  = foreign FFI_C "sleepMillis" (Int -> IO ()) millis