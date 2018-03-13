module Graphics.UI.GLFW.GLFW

import Graphics.UI.GLFW.Internals.Utils.Utils
import Graphics.UI.GLFW.GlfwConfig

%include C "GLFW/glfw3.h"

export
Window : Type
Window = Ptr

export
NullWindow : Window
NullWindow = null

public export
data DisplayMode
  = WindowMode
  | FullscreenMode

public export
data OpenGLProfile
  = DefaultProfile
  | CoreProfile
  | CompatibilityProfile

public export
record DisplayOptions where
  constructor MkDisplayOptions
  displayOptions_width                   : Int
  displayOptions_height                  : Int
  displayOptions_numRedBits              : Int
  displayOptions_numGreenBits            : Int
  displayOptions_numBlueBits             : Int
  displayOptions_numAlphaBits            : Int
  displayOptions_numDepthBits            : Int
  displayOptions_numStencilBits          : Int
  displayOptions_displayMode             : DisplayMode
  displayOptions_refreshRate             : Maybe Int
  displayOptions_accumNumRedBits         : Maybe Int
  displayOptions_accumNumGreenBits       : Maybe Int
  displayOptions_accumNumBlueBits        : Maybe Int
  displayOptions_accumNumAlphaBits       : Maybe Int
  displayOptions_numAuxiliaryBuffers     : Maybe Int
  displayOptions_numFsaaSamples          : Maybe Int
  displayOptions_windowIsResizable       : Bool
  displayOptions_stereoRendering         : Bool
  displayOptions_openGLVersion           : (Int, Int)
  displayOptions_openGLForwardCompatible : Bool
  displayOptions_openGLDebugContext      : Bool
  displayOptions_openGLProfile           : OpenGLProfile

public export
data WindowValue
  = NumRedBits
  | NumGreenBits
  | NumBlueBits
  | NumAlphaBits
  | NumDepthBits
  | NumStencilBits
  | NumAccumRedBits
  | NumAccumGreenBits
  | NumAccumBlueBits
  | NumAccumAlphaBits
  | NumAuxBuffers
  | NumFsaaSamples

public export
data GLFWKey
  = CharKey Char
  | KeyUnknown
  | KeySpace
  | KeySpecial
  | KeyEsc
  | KeyF1
  | KeyF2
  | KeyF3
  | KeyF4
  | KeyF5
  | KeyF6
  | KeyF7
  | KeyF8
  | KeyF9
  | KeyF10
  | KeyF11
  | KeyF12
  | KeyF13
  | KeyF14
  | KeyF15
  | KeyF16
  | KeyF17
  | KeyF18
  | KeyF19
  | KeyF20
  | KeyF21
  | KeyF22
  | KeyF23
  | KeyF24
  | KeyF25
  | KeyUp
  | KeyDown
  | KeyLeft
  | KeyRight
  | KeyLeftShift
  | KeyRightShift
  | KeyLeftCtrl
  | KeyRightCtrl
  | KeyLeftAlt
  | KeyRightAlt
  | KeyTab
  | KeyEnter
  | KeyBackspace
  | KeyInsert
  | KeyDel
  | KeyPageup
  | KeyPagedown
  | KeyHome
  | KeyEnd
  | KeyPad0
  | KeyPad1
  | KeyPad2
  | KeyPad3
  | KeyPad4
  | KeyPad5
  | KeyPad6
  | KeyPad7
  | KeyPad8
  | KeyPad9
  | KeyPadDivide
  | KeyPadMultiply
  | KeyPadSubtract
  | KeyPadAdd
  | KeyPadDecimal
  | KeyPadEqual
  | KeyPadEnter

public export
data GLFWMouseButton
  = MouseButton0 | MouseButton1 | MouseButton2 | MouseButton3
  | MouseButton4 | MouseButton5 | MouseButton6 | MouseButton7

export
defaultDisplayOptions : DisplayOptions
defaultDisplayOptions =
  MkDisplayOptions
    0               -- isplayOptions_width                    = 0
    0               -- displayOptions_height                  = 0
    0               -- displayOptions_numRedBits              = 0
    0               -- displayOptions_numGreenBits            = 0
    0               -- displayOptions_numBlueBits             = 0
    0               -- displayOptions_numAlphaBits            = 0
    0               -- displayOptions_numDepthBits            = 0
    0               -- displayOptions_numStencilBits          = 0
    WindowMode      -- displayOptions_displayMode             = Window
    Nothing         -- displayOptions_refreshRate             = Nothing
    Nothing         -- displayOptions_accumNumRedBits         = Nothing
    Nothing         -- displayOptions_accumNumGreenBits       = Nothing
    Nothing         -- displayOptions_accumNumBlueBits        = Nothing
    Nothing         -- displayOptions_accumNumAlphaBits       = Nothing
    Nothing         -- displayOptions_numAuxiliaryBuffers     = Nothing
    Nothing         -- displayOptions_numFsaaSamples          = Nothing
    True            -- displayOptions_windowIsResizable       = True
    False           -- displayOptions_stereoRendering         = False
    (1, 1)          -- displayOptions_openGLVersion           = (1,1)
    False           -- displayOptions_openGLForwardCompatible = False
    False           -- displayOptions_openGLDebugContext      = False
    DefaultProfile  -- displayOptions_openGLProfile           = DefaultProfile

public export
WindowCloseCallback : Type
WindowCloseCallback = IO Bool

public export
WindowSizeCallback : Type 
WindowSizeCallback = Int -> Int -> IO ()

public export
CharCallback : Type 
CharCallback = Char -> Bool -> IO ()

public export
KeyCallback : Type
KeyCallback = GLFWKey -> Bool -> IO ()

public export
MouseButtonCallback : Type
MouseButtonCallback = GLFWMouseButton -> Bool -> IO ()

public export
MousePositionCallback : Type
MousePositionCallback = Int -> Int -> IO ()

public export
MouseWheelCallback : Type
MouseWheelCallback  = Int -> IO ()

export
initialize : IO Bool
initialize = do
  ret <- foreign FFI_C "glfwInit" (IO Int)
  pure $ if ret == 1 then True else False

export
shutdown : IO ()
shutdown 
  = foreign FFI_C "glfwTerminate" (IO ())

export
getGlfwVersion : IO (Int, Int, Int)
getGlfwVersion = do
  majPtr <- allocIntArgPtr
  minPtr <- allocIntArgPtr
  revPtr <- allocIntArgPtr

  foreign FFI_C "glfwGetVersion" (Ptr -> Ptr -> Ptr -> IO ()) majPtr minPtr revPtr

  maj <- intPtrToValue majPtr
  min <- intPtrToValue majPtr
  rev <- intPtrToValue majPtr

  freeIntArgPtr majPtr
  freeIntArgPtr minPtr
  freeIntArgPtr revPtr

  pure (maj, min, rev)

export
closeWindow : IO ()
closeWindow
  = foreign FFI_C "glfwDestroyWindow" (IO ())

export
openWindow : String -> DisplayOptions -> IO Window
openWindow title disp = do
{-
  displayOptions_width                   : Int
  displayOptions_height                  : Int
  displayOptions_numRedBits              : Int
  displayOptions_numGreenBits            : Int
  displayOptions_numBlueBits             : Int
  displayOptions_numAlphaBits            : Int
  displayOptions_numDepthBits            : Int
  displayOptions_numStencilBits          : Int
  displayOptions_displayMode             : DisplayMode
  displayOptions_refreshRate             : Maybe Int
  displayOptions_accumNumRedBits         : Maybe Int
  displayOptions_accumNumGreenBits       : Maybe Int
  displayOptions_accumNumBlueBits        : Maybe Int
  displayOptions_accumNumAlphaBits       : Maybe Int
  displayOptions_numAuxiliaryBuffers     : Maybe Int
  displayOptions_numFsaaSamples          : Maybe Int
  displayOptions_windowIsResizable       : Bool
  displayOptions_stereoRendering         : Bool
  displayOptions_openGLVersion           : (Int, Int)
  displayOptions_openGLForwardCompatible : Bool
  displayOptions_openGLDebugContext      : Bool
  displayOptions_openGLProfile           : OpenGLProfile
-}

  let width  = displayOptions_width disp
  let height = displayOptions_height disp

  let monitor = 
    case displayOptions_displayMode disp of
      WindowMode     => null
      FullscreenMode => null -- TODO: set to valid monitor config

  win <- foreign FFI_C "glfwCreateWindow" (Int -> Int -> String -> Ptr -> Ptr -> IO Ptr) width height title monitor null

  pure win

export
setWindowPosition : Window -> Int -> Int -> IO ()
setWindowPosition win x y
  = foreign FFI_C "glfwSetWindowPos" (Ptr -> Int -> Int -> IO ()) win x y

export
setWindowTitle : Window -> String -> IO ()
setWindowTitle win title
  = foreign FFI_C "glfwSetWindowTitle" (Ptr -> String -> IO ()) win title

export
setSwapInterval : Int -> IO ()
setSwapInterval interval
  = foreign FFI_C "glfwSwapInterval" (Int -> IO ()) interval

-- #define GLFW_CURSOR_NORMAL   0x00034001
-- #define GLFW_CURSOR_HIDDEN   0x00034002
-- #define GLFW_CURSOR_DISABLED 0x00034003
-- #define GLFW_CURSOR          0x00033001
export
showMouseCursor : Window -> Bool -> IO ()
showMouseCursor win True  = foreign FFI_C "glfwSetInputMode" (Ptr -> Int -> Int -> IO ()) win 0x00033001 0x00034001 
showMouseCursor win False = foreign FFI_C "glfwSetInputMode" (Ptr -> Int -> Int -> IO ()) win 0x00033001 0x00034002 

export
getWindowDimensions : Window -> IO (Int, Int)
getWindowDimensions win = do
  widthPtr <- allocIntArgPtr
  heightPtr <- allocIntArgPtr

  foreign FFI_C "glfwGetWindowSize" (Ptr -> Ptr -> Ptr -> IO ()) win widthPtr heightPtr

  width <- intPtrToValue widthPtr
  height <- intPtrToValue heightPtr

  freeIntArgPtr widthPtr
  freeIntArgPtr heightPtr
  
  pure (width, height)

export
getWindowValue : WindowValue -> IO Int
getWindowValue wv = ?getWindowValue

export
setWindowCloseCallback : WindowCloseCallback -> IO ()
setWindowCloseCallback clbk = ?setWindowCloseCallback

export
setWindowSizeCallback : WindowSizeCallback -> IO ()
setWindowSizeCallback clbk = ?setWindowSizeCallback

export
setKeyCallback : KeyCallback -> IO ()
setKeyCallback clbk = ?setKeyCallback

export
setCharCallback : CharCallback -> IO ()
setCharCallback clbk = ?setCharCallback

export
setMouseButtonCallback : MouseButtonCallback -> IO ()
setMouseButtonCallback clbk = ?setMouseButtonCallback

export
setMouseWheelCallback : MouseWheelCallback -> IO ()
setMouseWheelCallback clbk = ?setMouseWheelCallback

export
setMousePositionCallback : MousePositionCallback -> IO ()
setMousePositionCallback clbk = ?setMousePositionCallback

export
windowIsOpen : Window -> IO Bool
windowIsOpen win = do
  ret <- foreign FFI_C "glfwWindowShouldClose" (Ptr -> IO Int) win
  pure $ if ret == 1 then False else True

||| This function may only be called from the main thread.
||| This function may not be called from a callback.
||| On some platforms, certain callbacks may be called outside of a call to one of the event processing functions.
export
pollEvents : IO ()
pollEvents 
  = foreign FFI_C "glfwPollEvents" (IO ())

export
swapBuffers : Window -> IO ()
swapBuffers win
  = foreign FFI_C "glfwSwapBuffers" (Ptr -> IO ()) win

export
sleep : Double -> IO ()
sleep secFract 
  = sleepMillis (cast $ secFract * 1000)

export
getTime : IO Double
getTime 
  = foreign FFI_C "glfwGetTime" (IO Double)