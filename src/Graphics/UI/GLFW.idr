module Graphics.UI.GLFW

import Graphics.UI.GLFW.Internals.Utils
import Graphics.UI.GLFW.Utils.GlfwConfig

%include C "GLFW/glfw3.h"

public export
Window : Type
Window = Ptr

export
Monitor : Type
Monitor = Ptr

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
glfwKeyToInt : GLFWKey -> Int
glfwKeyToInt (CharKey x) = cast x
glfwKeyToInt KeyUnknown = -1
glfwKeyToInt KeySpace = 32
glfwKeyToInt KeySpecial = -1
glfwKeyToInt KeyEsc = 256
glfwKeyToInt KeyF1 = 290
glfwKeyToInt KeyF2 = 291
glfwKeyToInt KeyF3 = 292
glfwKeyToInt KeyF4 = 293
glfwKeyToInt KeyF5 = 294
glfwKeyToInt KeyF6 = 295
glfwKeyToInt KeyF7 = 296
glfwKeyToInt KeyF8 = 297
glfwKeyToInt KeyF9 = 298
glfwKeyToInt KeyF10 = 299
glfwKeyToInt KeyF11 = 300
glfwKeyToInt KeyF12 = 301
glfwKeyToInt KeyF13 = 302
glfwKeyToInt KeyF14 = 303
glfwKeyToInt KeyF15 = 304
glfwKeyToInt KeyF16 = 305
glfwKeyToInt KeyF17 = 306
glfwKeyToInt KeyF18 = 307
glfwKeyToInt KeyF19 = 308
glfwKeyToInt KeyF20 = 309
glfwKeyToInt KeyF21 = 310
glfwKeyToInt KeyF22 = 311
glfwKeyToInt KeyF23 = 312
glfwKeyToInt KeyF24 = 313
glfwKeyToInt KeyF25 = 314
glfwKeyToInt KeyUp = 265
glfwKeyToInt KeyDown = 264
glfwKeyToInt KeyLeft = 263
glfwKeyToInt KeyRight = 262
glfwKeyToInt KeyLeftShift = 340
glfwKeyToInt KeyRightShift = 344
glfwKeyToInt KeyLeftCtrl = 341
glfwKeyToInt KeyRightCtrl = 345
glfwKeyToInt KeyLeftAlt = 342
glfwKeyToInt KeyRightAlt = 346
glfwKeyToInt KeyTab = 258
glfwKeyToInt KeyEnter = 257
glfwKeyToInt KeyBackspace = 259
glfwKeyToInt KeyInsert = 260
glfwKeyToInt KeyDel = 261
glfwKeyToInt KeyPageup = 266
glfwKeyToInt KeyPagedown = 267
glfwKeyToInt KeyHome = 268
glfwKeyToInt KeyEnd = 269
glfwKeyToInt KeyPad0 = 320
glfwKeyToInt KeyPad1 = 321
glfwKeyToInt KeyPad2 = 322
glfwKeyToInt KeyPad3 = 323
glfwKeyToInt KeyPad4 = 324
glfwKeyToInt KeyPad5 = 325
glfwKeyToInt KeyPad6 = 326
glfwKeyToInt KeyPad7 = 327
glfwKeyToInt KeyPad8 = 328
glfwKeyToInt KeyPad9 = 329
glfwKeyToInt KeyPadDivide = 331
glfwKeyToInt KeyPadMultiply = 332
glfwKeyToInt KeyPadSubtract = 333
glfwKeyToInt KeyPadAdd = 334
glfwKeyToInt KeyPadDecimal = 330
glfwKeyToInt KeyPadEqual = 336
glfwKeyToInt KeyPadEnter = 335

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
getPrimaryMonitor : IO Monitor
getPrimaryMonitor
  = foreign FFI_C "glfwGetPrimaryMonitor" (IO Monitor)

--------------------------------------------------------------------
-- only used from within createWindow, is extremely lowlevel
private
glfwTrue : Int
glfwTrue = 1

glfwFalse : Int
glfwFalse = 0

private
glfwResizable : Int
glfwResizable = 0x00020003 -- GLFW_RESIZABLE

private
glfwStereo : Int
glfwStereo = 0x0002100C   -- GLFW_STEREO

private
glfwAuxBuffers : Int
glfwAuxBuffers = 0x0002100B -- GLFW_AUX_BUFFERS 

private
glfwAccumRedBits : Int
glfwAccumRedBits = 0x00021007 -- GLFW_ACCUM_RED_BITS 

private
glfwAccumGreenBits : Int
glfwAccumGreenBits = 0x00021008 -- GLFW_ACCUM_GREEN_BITS  

private
glfwAccumBlueBits : Int
glfwAccumBlueBits = 0x00021009 -- GLFW_ACCUM_BLUE_BITS    

private
glfwAccumAlphaBits : Int
glfwAccumAlphaBits = 0x0002100A -- GLFW_ACCUM_ALPHA_BITS    

private
glfwSamples : Int
glfwSamples = 0x0002100D -- GLFW_SAMPLES

private
glfwRefreshRate : Int
glfwRefreshRate = 0x0002100F -- GLFW_REFRESH_RATE   

private
glfwRedBits : Int
glfwRedBits = 0x00021001 -- GLFW_RED_BITS

private
glfwGreenBits : Int
glfwGreenBits = 0x00021002 -- GLFW_GREEN_BITS 

private
glfwBlueBits : Int
glfwBlueBits = 0x00021003 -- GLFW_BLUE_BITS 

private
glfwAlphaBits : Int
glfwAlphaBits = 0x00021004 -- GLFW_ALPHA_BITS 

private
glfwDepthBits : Int
glfwDepthBits = 0x00021005 -- GLFW_DEPTH_BITS 

private
glfwStencilBits : Int
glfwStencilBits = 0x00021006 -- GLFW_STENCIL_BITS 

private
glfwContextMajor : Int
glfwContextMajor = 0x00022002 -- GLFW_CONTEXT_VERSION_MAJOR   

private
glfwContextMinor : Int
glfwContextMinor = 0x00022003 -- GLFW_CONTEXT_VERSION_MINOR   

private
glfwGLForward : Int
glfwGLForward = 0x00022006 --	GLFW_OPENGL_FORWARD_COMPAT   

private
glfwGLDebug : Int
glfwGLDebug = 0x00022007 --	GLFW_OPENGL_DEBUG_CONTEXT   

private
glfwGlProfile : Int
glfwGlProfile = 0x00022008 -- GLFW_OPENGL_PROFILE   

private
glfwGLAnyProfile : Int
glfwGLAnyProfile = 0 -- GLFW_OPENGL_ANY_PROFILE

private
glfwGLCoreProfile : Int
glfwGLCoreProfile = 0x00032001 -- GLFW_OPENGL_CORE_PROFILE

private
glfwCompatProfile : Int
glfwCompatProfile = 0x00032002 --	GLFW_OPENGL_COMPAT_PROFILE   0x00032002
--------------------------------------------------------------------

private
windowHint : Int -> Int -> IO ()
windowHint hint value
  = foreign FFI_C "glfwWindowHint" (Int -> Int -> IO ()) hint value

export
createWindow : String -> DisplayOptions -> IO Window
createWindow title disp = do
  let width  = displayOptions_width disp
  let height = displayOptions_height disp

  let redBits = displayOptions_numRedBits disp
  let greenBits = displayOptions_numGreenBits disp
  let blueBits = displayOptions_numBlueBits disp
  let alphaBits = displayOptions_numAlphaBits disp
  let depthBits = displayOptions_numDepthBits disp
  let stencilBits = displayOptions_numStencilBits disp

  let (glVerMin, glVerMaj) = displayOptions_openGLVersion disp

  when (displayOptions_windowIsResizable disp) (windowHint glfwResizable glfwTrue)
  when (displayOptions_stereoRendering disp) (windowHint glfwStereo glfwTrue)
  maybe (pure ()) (\n => (windowHint glfwAuxBuffers n)) (displayOptions_numAuxiliaryBuffers disp)
  maybe (pure ()) (\n => (windowHint glfwAccumRedBits n)) (displayOptions_accumNumRedBits disp)
  maybe (pure ()) (\n => (windowHint glfwAccumGreenBits n)) (displayOptions_accumNumGreenBits disp)
  maybe (pure ()) (\n => (windowHint glfwAccumBlueBits n)) (displayOptions_accumNumBlueBits disp)
  maybe (pure ()) (\n => (windowHint glfwAccumAlphaBits n)) (displayOptions_accumNumAlphaBits disp)
  maybe (pure ()) (\n => (windowHint glfwSamples n)) (displayOptions_numFsaaSamples disp)
  maybe (pure ()) (\n => (windowHint glfwRefreshRate n)) (displayOptions_refreshRate disp)
  when (redBits > 0) (windowHint glfwRedBits redBits)
  when (greenBits > 0) (windowHint glfwGreenBits greenBits)
  when (blueBits > 0) (windowHint glfwBlueBits blueBits)
  when (alphaBits > 0) (windowHint glfwAlphaBits alphaBits)
  when (depthBits > 0) (windowHint glfwDepthBits depthBits)
  when (stencilBits > 0) (windowHint glfwStencilBits stencilBits)
  
  windowHint glfwContextMajor glVerMaj
  windowHint glfwContextMinor glVerMin
  when (displayOptions_openGLForwardCompatible disp) (windowHint glfwGLForward glfwTrue)
  when (displayOptions_openGLDebugContext disp) (windowHint glfwGLDebug glfwTrue)

  case displayOptions_openGLProfile disp of
    DefaultProfile        => windowHint glfwGlProfile glfwGLAnyProfile
    CoreProfile           => windowHint glfwGlProfile glfwGLCoreProfile
    CompatibilityProfile  => windowHint glfwGlProfile glfwCompatProfile

  monitor <-
    case displayOptions_displayMode disp of
      WindowMode     => pure null
      FullscreenMode => getPrimaryMonitor

  foreign FFI_C "glfwCreateWindow" (Int -> Int -> String -> Ptr -> Ptr -> IO Ptr) width height title monitor null

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

private
glfwCursor : Int
glfwCursor = 0x00033001 -- GLFW_CURSOR

private
glfwCursorNormal : Int
glfwCursorNormal = 0x00034001 -- GLFW_CURSOR_NORMAL

private
glfwCursorHidden : Int
glfwCursorHidden = 0x00034002 -- GLFW_CURSOR_HIDDEN

private
glfwCursorDisabled : Int
glfwCursorDisabled = 0x00034003 -- GLFW_CURSOR_DISABLED

export
showMouseCursor : Window -> Bool -> IO ()
showMouseCursor win True  = foreign FFI_C "glfwSetInputMode" (Ptr -> Int -> Int -> IO ()) win glfwCursor glfwCursorHidden 
showMouseCursor win False = foreign FFI_C "glfwSetInputMode" (Ptr -> Int -> Int -> IO ()) win glfwCursor 0x00034002 

export
getWindowDimensions : Window -> IO (Int, Int)
getWindowDimensions win = do
  widthPtr <- nextIntArgPtr
  heightPtr <- nextIntArgPtr

  foreign FFI_C "glfwGetWindowSize" (Ptr -> Ptr -> Ptr -> IO ()) win widthPtr heightPtr

  width <- intPtrToValue widthPtr
  height <- intPtrToValue heightPtr

  pure (width, height)

private
glfwGetWindowAttrib : Window -> Int -> IO Int
glfwGetWindowAttrib win attrib
  = foreign FFI_C "glfwGetWindowAttrib" (Ptr -> Int -> IO Int) win attrib

export
getWindowValue : Window -> WindowValue -> IO Int
getWindowValue win NumRedBits = glfwGetWindowAttrib win glfwRedBits
getWindowValue win NumGreenBits = glfwGetWindowAttrib win glfwGreenBits
getWindowValue win NumBlueBits = glfwGetWindowAttrib win glfwBlueBits
getWindowValue win NumAlphaBits = glfwGetWindowAttrib win glfwAlphaBits
getWindowValue win NumDepthBits = glfwGetWindowAttrib win glfwDepthBits
getWindowValue win NumStencilBits = glfwGetWindowAttrib win glfwStencilBits
getWindowValue win NumAccumRedBits = glfwGetWindowAttrib win glfwAccumRedBits
getWindowValue win NumAccumGreenBits = glfwGetWindowAttrib win glfwAccumGreenBits
getWindowValue win NumAccumBlueBits = glfwGetWindowAttrib win glfwAccumBlueBits
getWindowValue win NumAccumAlphaBits = glfwGetWindowAttrib win glfwAccumAlphaBits
getWindowValue win NumAuxBuffers = glfwGetWindowAttrib win glfwAuxBuffers
getWindowValue win NumFsaaSamples = glfwGetWindowAttrib win glfwSamples

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

private
glfwPress : Int
glfwPress = 1

private 
getMouseButton : Window -> Int -> IO Int
getMouseButton win but
  = foreign FFI_C "glfwGetMouseButton" (Ptr -> Int -> IO Int) win but

export
isMouseButtonPressed : Window -> GLFWMouseButton -> IO Bool
isMouseButtonPressed win MouseButton1 = getMouseButton win 0 >>= \ret => pure (ret == glfwPress)
isMouseButtonPressed win MouseButton2 = getMouseButton win 1 >>= \ret => pure (ret == glfwPress)
isMouseButtonPressed win MouseButton3 = getMouseButton win 2 >>= \ret => pure (ret == glfwPress)
isMouseButtonPressed win MouseButton4 = getMouseButton win 3 >>= \ret => pure (ret == glfwPress)
isMouseButtonPressed win MouseButton5 = getMouseButton win 4 >>= \ret => pure (ret == glfwPress)
isMouseButtonPressed win MouseButton6 = getMouseButton win 5 >>= \ret => pure (ret == glfwPress)
isMouseButtonPressed win MouseButton7 = getMouseButton win 6 >>= \ret => pure (ret == glfwPress)
isMouseButtonPressed win MouseButton8 = getMouseButton win 7 >>= \ret => pure (ret == glfwPress)

private 
getKey : Window -> Int -> IO Int
getKey win k
  = foreign FFI_C "glfwGetKey" (Ptr -> Int -> IO Int) win k

export
isKeyPressed : Window -> GLFWKey -> IO Bool
isKeyPressed win k = do
  let kInt = glfwKeyToInt k
  ret <- getKey win kInt
  pure (ret == glfwPress)

export
getCursorPos : Window -> IO (Double, Double)
getCursorPos win = do
  xPtr <- nextDoubleArgPtr
  yPtr <- nextDoubleArgPtr

  foreign FFI_C "glfwGetCursorPos" (Ptr -> Ptr -> Ptr -> IO ()) win xPtr yPtr

  x <- doublePtrToValue xPtr
  y <- doublePtrToValue yPtr

  pure (x, y)

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