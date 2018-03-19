module Graphics.UI.GLFW

import Graphics.UI.GLFW.Internals.Utils
import Graphics.UI.GLFW.Utils.GlfwConfig

%include C "GLFW/glfw3.h"

public export
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
data GLFWKeyAction
  = Press
  | Release
  | Repeat

public export
data GLFWKeyModifier
  = Shift
  | Control
  | Alt
  | Super

public export
data GLFWMouseButton
  = MouseButton1 | MouseButton2 | MouseButton3 | MouseButton4
  | MouseButton5 | MouseButton6 | MouseButton7 | MouseButton8

export
glfwKeyFromInt : Int -> Maybe GLFWKey
--glfwKeyFromInt (-1) = Just KeyUnknown
glfwKeyFromInt 32 = Just KeySpace
-- #define 	GLFW_KEY_APOSTROPHE   39 /* ' */
-- #define 	GLFW_KEY_COMMA   44 /* , */
-- #define 	GLFW_KEY_MINUS   45 /* - */
-- #define 	GLFW_KEY_PERIOD   46 /* . */ 
-- #define 	GLFW_KEY_SLASH   47 /* / */
-- glfwKeyFromInt 48 = Just KeyPad0
-- glfwKeyFromInt 49 = Just KeyPad1
-- glfwKeyFromInt 50 = Just KeyPad2
-- glfwKeyFromInt 51 = Just KeyPad3
-- glfwKeyFromInt 52 = Just KeyPad4
-- glfwKeyFromInt 53 = Just KeyPad5
-- glfwKeyFromInt 54 = Just KeyPad6
-- glfwKeyFromInt 55 = Just KeyPad7
-- glfwKeyFromInt 56 = Just KeyPad8
-- glfwKeyFromInt 57 = Just KeyPad9
-- #define 	GLFW_KEY_SEMICOLON   59 /* ; */
-- #define 	GLFW_KEY_EQUAL   61 /* = */
glfwKeyFromInt 65 = Just $ CharKey 'a'
glfwKeyFromInt 66 = Just $ CharKey 'b'
glfwKeyFromInt 67 = Just $ CharKey 'c'
glfwKeyFromInt 68 = Just $ CharKey 'd'
glfwKeyFromInt 69 = Just $ CharKey 'e'
glfwKeyFromInt 70 = Just $ CharKey 'f'
glfwKeyFromInt 71 = Just $ CharKey 'g'
glfwKeyFromInt 72 = Just $ CharKey 'h'
glfwKeyFromInt 73 = Just $ CharKey 'i'
glfwKeyFromInt 74 = Just $ CharKey 'j'
glfwKeyFromInt 75 = Just $ CharKey 'k'
glfwKeyFromInt 76 = Just $ CharKey 'l'
glfwKeyFromInt 77 = Just $ CharKey 'm'
glfwKeyFromInt 78 = Just $ CharKey 'n'
glfwKeyFromInt 79 = Just $ CharKey 'o'
glfwKeyFromInt 80 = Just $ CharKey 'p'
glfwKeyFromInt 81 = Just $ CharKey 'q'
glfwKeyFromInt 82 = Just $ CharKey 'r'
glfwKeyFromInt 83 = Just $ CharKey 's'
glfwKeyFromInt 84 = Just $ CharKey 't'
glfwKeyFromInt 85 = Just $ CharKey 'u'
glfwKeyFromInt 86 = Just $ CharKey 'v'
glfwKeyFromInt 87 = Just $ CharKey 'w'
glfwKeyFromInt 88 = Just $ CharKey 'x'
glfwKeyFromInt 89 = Just $ CharKey 'y'
glfwKeyFromInt 90 = Just $ CharKey 'z'
-- #define 	GLFW_KEY_LEFT_BRACKET   91 /* [ */
-- #define 	GLFW_KEY_BACKSLASH   92 /* \ */
-- #define 	GLFW_KEY_RIGHT_BRACKET   93 /* ] */
-- #define 	GLFW_KEY_GRAVE_ACCENT   96 /* ` */
-- #define 	GLFW_KEY_WORLD_1   161 /* non-US #1 */
-- #define 	GLFW_KEY_WORLD_2   162 /* non-US #2 */
glfwKeyFromInt 256 = Just KeyEsc
glfwKeyFromInt 257 = Just KeyEnter
glfwKeyFromInt 258 = Just KeyTab
glfwKeyFromInt 259 = Just KeyBackspace
glfwKeyFromInt 260 = Just KeyInsert
glfwKeyFromInt 261 = Just KeyDel
glfwKeyFromInt 262 = Just KeyRight
glfwKeyFromInt 263 = Just KeyLeft
glfwKeyFromInt 264 = Just KeyDown
glfwKeyFromInt 265 = Just KeyUp
glfwKeyFromInt 266 = Just KeyPageup
glfwKeyFromInt 267 = Just KeyPagedown
glfwKeyFromInt 268 = Just KeyHome
glfwKeyFromInt 269 = Just KeyEnd
-- #define 	GLFW_KEY_CAPS_LOCK   280
-- #define 	GLFW_KEY_SCROLL_LOCK   281
-- #define 	GLFW_KEY_NUM_LOCK   282
-- #define 	GLFW_KEY_PRINT_SCREEN   283
-- #define 	GLFW_KEY_PAUSE   284
glfwKeyFromInt 290 = Just KeyF1
glfwKeyFromInt 291 = Just KeyF2
glfwKeyFromInt 292 = Just KeyF3
glfwKeyFromInt 293 = Just KeyF4
glfwKeyFromInt 294 = Just KeyF5
glfwKeyFromInt 295 = Just KeyF6
glfwKeyFromInt 296 = Just KeyF7
glfwKeyFromInt 297 = Just KeyF8
glfwKeyFromInt 298 = Just KeyF9
glfwKeyFromInt 299 = Just KeyF10
glfwKeyFromInt 300 = Just KeyF11
glfwKeyFromInt 301 = Just KeyF12
glfwKeyFromInt 302 = Just KeyF13
glfwKeyFromInt 303 = Just KeyF14
glfwKeyFromInt 304 = Just KeyF15
glfwKeyFromInt 305 = Just KeyF16
glfwKeyFromInt 306 = Just KeyF17
glfwKeyFromInt 307 = Just KeyF18
glfwKeyFromInt 308 = Just KeyF19
glfwKeyFromInt 309 = Just KeyF20
glfwKeyFromInt 310 = Just KeyF21
glfwKeyFromInt 311 = Just KeyF22
glfwKeyFromInt 312 = Just KeyF23
glfwKeyFromInt 313 = Just KeyF24
glfwKeyFromInt 314 = Just KeyF25
 
glfwKeyFromInt 320 = Just KeyPad0
glfwKeyFromInt 321 = Just KeyPad1
glfwKeyFromInt 322 = Just KeyPad2
glfwKeyFromInt 323 = Just KeyPad3
glfwKeyFromInt 324 = Just KeyPad4
glfwKeyFromInt 325 = Just KeyPad5
glfwKeyFromInt 326 = Just KeyPad6
glfwKeyFromInt 327 = Just KeyPad7
glfwKeyFromInt 328 = Just KeyPad8
glfwKeyFromInt 329 = Just KeyPad9
glfwKeyFromInt 330 = Just KeyPadDecimal
glfwKeyFromInt 331 = Just KeyPadDivide
glfwKeyFromInt 332 = Just KeyPadMultiply
glfwKeyFromInt 333 = Just KeyPadSubtract
glfwKeyFromInt 334 = Just KeyPadAdd
glfwKeyFromInt 335 = Just KeyPadEnter
glfwKeyFromInt 336 = Just KeyPadEqual
glfwKeyFromInt 340 = Just KeyLeftShift
glfwKeyFromInt 341 = Just KeyLeftCtrl
glfwKeyFromInt 342 = Just KeyLeftAlt
-- #define 	GLFW_KEY_LEFT_SUPER   343
glfwKeyFromInt 344 = Just KeyRightShift
glfwKeyFromInt 345 = Just KeyRightCtrl
glfwKeyFromInt 346 = Just KeyRightAlt
-- #define 	GLFW_KEY_RIGHT_SUPER   347
-- #define 	GLFW_KEY_MENU   348
glfwKeyFromInt _ = Nothing

export
glfwKeyActionFromInt : Int -> Maybe GLFWKeyAction
glfwKeyActionFromInt 0 = Just Release
glfwKeyActionFromInt 1 = Just Press
glfwKeyActionFromInt 2 = Just Repeat
glfwKeyActionFromInt _ = Nothing

export
glfwKeyModifierFromInt : Int -> Maybe GLFWKeyModifier
glfwKeyModifierFromInt 1 = Just Shift
glfwKeyModifierFromInt 2 = Just Control
glfwKeyModifierFromInt 4 = Just Alt
glfwKeyModifierFromInt 8 = Just Super
glfwKeyModifierFromInt _ = Nothing

export
glfwMouseButtonFromInt : Int -> Maybe GLFWMouseButton
glfwMouseButtonFromInt 0 = Just MouseButton1
glfwMouseButtonFromInt 1 = Just MouseButton2
glfwMouseButtonFromInt 2 = Just MouseButton3
glfwMouseButtonFromInt 3 = Just MouseButton4
glfwMouseButtonFromInt 4 = Just MouseButton5
glfwMouseButtonFromInt 5 = Just MouseButton6
glfwMouseButtonFromInt 6 = Just MouseButton7
glfwMouseButtonFromInt 7 = Just MouseButton8
glfwMouseButtonFromInt _ = Nothing

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
  majPtr <- nextIntArgPtr
  minPtr <- nextIntArgPtr
  revPtr <- nextIntArgPtr

  foreign FFI_C "glfwGetVersion" (Ptr -> Ptr -> Ptr -> IO ()) majPtr minPtr revPtr

  maj <- intPtrToValue majPtr
  min <- intPtrToValue majPtr
  rev <- intPtrToValue majPtr

  pure (maj, min, rev)

export
destroyWindow : Window -> IO ()
destroyWindow win
  = foreign FFI_C "glfwDestroyWindow" (Window -> IO ()) win

export
createWindow : String -> DisplayOptions -> IO Window
createWindow title disp = do
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

  -- TODO: set other parameters

  pure win

export
makeContextCurrent : Window -> IO ()
makeContextCurrent win
  = foreign FFI_C "glfwMakeContextCurrent" (Ptr -> IO ()) win

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
  widthPtr <- nextIntArgPtr
  heightPtr <- nextIntArgPtr

  foreign FFI_C "glfwGetWindowSize" (Ptr -> Ptr -> Ptr -> IO ()) win widthPtr heightPtr

  width <- intPtrToValue widthPtr
  height <- intPtrToValue heightPtr

  pure (width, height)

export
getWindowValue : WindowValue -> IO Int
getWindowValue wv = pure 42 -- TODO: implement ?getWindowValue

public export
WindowCloseCallback : Type
WindowCloseCallback = Window -> ()

-- for some reason it is not possible to call an IO action which is
-- passed as argument in a callback function, either because of
-- idris or (more likely) because of GLFWs internal callback implementation 
-- if one does as implemented below, the program will crash when clbk win' is called
-- therefore we gotta pass the callback as raw ptr and the caller needs to
-- ensure it is the correct type
{-
export
setWindowCloseCallback : Window -> (Window -> IO Bool) -> IO ()
setWindowCloseCallback win clbk = do
    clbkPtr <- foreign FFI_C "%wrapper" (CFnPtr (Window -> ()) -> IO Ptr) (MkCFnPtr windowCloseCallbackPure)
    foreign FFI_C "glfwSetWindowCloseCallback" (Ptr -> Ptr -> IO Ptr) win clbkPtr
    pure ()

  where
    -- IO callbacks not (yet) suppored by Idris, need to use unsafePerformIO
    windowCloseCallbackPure : Window -> ()
    windowCloseCallbackPure win' = unsafePerformIO $ do 
      _ <- clbk win'
      pure ()
-}
export
setWindowCloseCallback : Window -> Ptr -> IO ()
setWindowCloseCallback win clbkPtr = do
  _ <- foreign FFI_C "glfwSetWindowCloseCallback" (Ptr -> Ptr -> IO Ptr) win clbkPtr
  pure ()

public export
WindowSizeCallback : Type 
WindowSizeCallback = Window -> Int -> Int -> ()

export
setWindowSizeCallback : Window -> Ptr -> IO ()
setWindowSizeCallback win clbkPtr = do
  _ <- foreign FFI_C "glfwSetWindowSizeCallback" (Ptr -> Ptr -> IO Ptr) win clbkPtr
  pure ()

public export
KeyCallback : Type
KeyCallback = Window -> Int -> Int -> Int -> Int -> ()

export
setKeyCallback : Window -> Ptr -> IO ()
setKeyCallback win clbkPtr = do
  _ <- foreign FFI_C "glfwSetKeyCallback" (Ptr -> Ptr -> IO Ptr) win clbkPtr
  pure ()

public export
CharCallback : Type 
CharCallback = Window -> Char -> ()

export
setCharCallback : Window -> Ptr -> IO ()
setCharCallback win clbkPtr = do
  _ <- foreign FFI_C "glfwSetCharCallback" (Ptr -> Ptr -> IO Ptr) win clbkPtr
  pure ()

public export
MouseButtonCallback : Type
MouseButtonCallback = Window -> Int -> Int -> Int -> ()

export
setMouseButtonCallback : Window -> Ptr -> IO ()
setMouseButtonCallback win clbkPtr = do
  _ <- foreign FFI_C "glfwSetMouseButtonCallback" (Ptr -> Ptr -> IO Ptr) win clbkPtr
  pure ()

public export
MouseWheelCallback : Type
MouseWheelCallback  = Window -> Double -> Double -> ()

export
setMouseWheelCallback : Window -> Ptr -> IO ()
setMouseWheelCallback win clbkPtr = do
  _ <- foreign FFI_C "glfwSetScrollCallback" (Ptr -> Ptr -> IO Ptr) win clbkPtr
  pure ()

public export
MousePositionCallback : Type
MousePositionCallback = Window -> Double -> Double -> ()

export
setMousePositionCallback : Window -> Ptr -> IO ()
setMousePositionCallback win clbkPtr = do
  _ <- foreign FFI_C "glfwSetCursorPosCallback" (Ptr -> Ptr -> IO Ptr) win clbkPtr
  pure ()

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