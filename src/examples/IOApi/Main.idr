module Main

import Data.IORef

import Graphics.UI.GLFW as GLFW
import Graphics.UI.GLFW.Utils.GlfwConfig

-- TODO: why isn't it enough to import this one only?
--import Graphics.Rendering.OpenGL as GL
import Graphics.Rendering.OpenGL.Internal.Buffers
import Graphics.Rendering.OpenGL.Internal.GLEW
import Graphics.Rendering.OpenGL.Internal.GLBindings
import Graphics.Rendering.OpenGL.Internal.OpenGLConfig
import Graphics.Rendering.OpenGL.Internal.Types

initRef : Int 
initRef = 0

main : IO ()
main = do
    ok <- GLFW.initialize 
    case ok of
      False => putStrLn "Initializing GLFW failed"
      True  => do
        ref <- newIORef 0

        (maj, min, rev) <- GLFW.getGlfwVersion
        putStrLn "Initializing GLFW successful"
        putStrLn $ "--- GLFW " ++ show maj ++ "." ++ show min ++ "." ++ show rev ++ " ---"

        putStr "Creating Window... "
        let disp = record 
          { displayOptions_width        = 800
          , displayOptions_height       = 600
          , displayOptions_displayMode  = GLFW.WindowMode } GLFW.defaultDisplayOptions
        win <- GLFW.createWindow "glfw-idris-st createwindow example " disp

        glewInit

        GLFW.makeContextCurrent win
        putStrLn "done!"

        GLFW.showMouseCursor win True
        GLFW.setSwapInterval 1
        
        GLFW.setWindowCloseCallback   win !windowCloseCallbackPtr
        GLFW.setWindowSizeCallback    win !windowSizeCallbackPtr
        GLFW.setKeyCallback           win !keyCallbackPtr
        GLFW.setCharCallback          win !charCallbackPtr
        GLFW.setMouseButtonCallback   win !mouseButtonCallbackPtr
        GLFW.setMouseWheelCallback    win !mouseWheelCallbackPtr
        GLFW.setMousePositionCallback win !(mousePositionCallbackPtr ref)

        eventLoop win 5

        putStr "Destroying Window... "
        GLFW.destroyWindow win
        putStr "done!\nShuting down GLFW... "
        GLFW.shutdown
        putStrLn "done!\nGoodbye!"

  where
    -- IO callbacks not (yet) suppored by Idris, need to use unsafePerformIO
    windowCloseCallback : WindowCloseCallback
    windowCloseCallback win' = unsafePerformIO $ do 
      putStrLn "windowCloseCallback"
      pure ()
  
    -- unfortunately we need to pass the callback as a pointer...
    windowCloseCallbackPtr : IO Ptr
    windowCloseCallbackPtr = foreign FFI_C "%wrapper" (CFnPtr WindowCloseCallback -> IO Ptr) (MkCFnPtr windowCloseCallback)

    windowSizeCallback : WindowSizeCallback
    windowSizeCallback win' w h = unsafePerformIO $ do 
      putStrLn "windowSizeCallback"
      putStrLn $ "new window size = " ++ show w ++ " " ++ show h
      pure ()

    windowSizeCallbackPtr : IO Ptr
    windowSizeCallbackPtr = foreign FFI_C "%wrapper" (CFnPtr WindowSizeCallback -> IO Ptr) (MkCFnPtr windowSizeCallback)

    keyCallback : KeyCallback
    keyCallback win' key scancode action mods = unsafePerformIO $ do 
        putStrLn "keyCallback"
        putStrLn $ "key = " ++ show key ++
                  " scancode = " ++ show scancode ++
                  " action = " ++ show action ++
                  " action = " ++ show mods

        let mglfwKey = GLFW.glfwKeyFromInt key
        let mglfwAct = GLFW.glfwKeyActionFromInt action
        keyCallbackAux mglfwKey mglfwAct
      where
          keyCallbackAux :  Maybe GLFWKey
                         -> Maybe GLFWKeyAction
                         -> IO ()
          keyCallbackAux (Just glfwKey) (Just Press)   = putStrLn "Press Key"
          keyCallbackAux (Just glfwKey) (Just Release) = putStrLn "Release Key"
          keyCallbackAux (Just glfwKey) (Just Repeat) = putStrLn "Repeat Key"
          keyCallbackAux _ _ = putStrLn "Unknown key / action"

    keyCallbackPtr : IO Ptr
    keyCallbackPtr = foreign FFI_C "%wrapper" (CFnPtr KeyCallback -> IO Ptr) (MkCFnPtr keyCallback)

    charCallback : CharCallback
    charCallback win' c = unsafePerformIO $ do 
      putStrLn "charCallback"
      putStrLn $ "char = " ++ show c
      pure ()

    charCallbackPtr : IO Ptr
    charCallbackPtr = foreign FFI_C "%wrapper" (CFnPtr CharCallback -> IO Ptr) (MkCFnPtr charCallback)

    mouseButtonCallback : MouseButtonCallback
    mouseButtonCallback win' button action mods = unsafePerformIO $ do 
        putStrLn "mouseButtonCallback"
        putStrLn $ "button = " ++ show button ++
                  " action = " ++ show action ++
                  " mods = " ++ show mods

        let mglfwMb = GLFW.glfwMouseButtonFromInt button
        let mglfwAct = GLFW.glfwKeyActionFromInt action
        mouseButtonCallbackAux mglfwMb mglfwAct
      where
        mouseButtonCallbackAux :  Maybe GLFWMouseButton
                               -> Maybe GLFWKeyAction
                               -> IO ()
        mouseButtonCallbackAux (Just glfwMb) (Just Press)   = putStrLn "Press MouseButton"
        mouseButtonCallbackAux (Just glfwMb) (Just Release) = putStrLn "Release MouseButton"
        mouseButtonCallbackAux (Just glfwMb) (Just Repeat) = putStrLn "Repeat MouseButton"
        mouseButtonCallbackAux _ _ = putStrLn "Unknown MouseButton / Action"

    mouseButtonCallbackPtr : IO Ptr
    mouseButtonCallbackPtr = foreign FFI_C "%wrapper" (CFnPtr MouseButtonCallback -> IO Ptr) (MkCFnPtr mouseButtonCallback)

    mouseWheelCallback : MouseWheelCallback
    mouseWheelCallback win' xoff yoff = unsafePerformIO $ do 
      putStrLn "mouseWheelCallback"
      putStrLn $ "xoff = " ++ show xoff ++
                 " yoff = " ++ show yoff
      pure ()

    mouseWheelCallbackPtr : IO Ptr
    mouseWheelCallbackPtr = foreign FFI_C "%wrapper" (CFnPtr MouseWheelCallback -> IO Ptr) (MkCFnPtr mouseWheelCallback)

    mousePositionCallback : IORef Integer -> MousePositionCallback
    mousePositionCallback ref win' xpos ypos = unsafePerformIO $ do 
      putStrLn "mousePositionCallback begin"
      putStrLn $ "xpos = " ++ show xpos ++
                 " ypos = " ++ show ypos
      -- modifyIORef ref (+1) -- when uncommenting this, the program will core dump with a segmentation fault
      putStrLn "mousePositionCallback end"
      pure ()

    mousePositionCallbackPtr : IORef Integer -> IO Ptr
    mousePositionCallbackPtr ref = foreign FFI_C "%wrapper" (CFnPtr MousePositionCallback -> IO Ptr) (MkCFnPtr (mousePositionCallback ref))

    eventLoop : GLFW.Window -> Double -> IO ()
    eventLoop win sec = do
        t <- GLFW.getTime
        eventLoopAux t
      where
        eventLoopAux : Double -> IO ()
        eventLoopAux t = do
          t' <- GLFW.getTime
          if t' - t >= sec
            then pure ()
            else do
              ret <- GLFW.windowIsOpen win
              if ret
                then do
                  GLFW.pollEvents

                  glClear GL_COLOR_BUFFER_BIT
                  glClear GL_DEPTH_BUFFER_BIT
                  glClearColor 0 0 0 1

                  glColor4f 1 1 1 1

                  glBegin GL_LINE_LOOP 
                  glVertex2f (-1) 0
                  glVertex2f 0 (-1)
                  glVertex2f 1 0
                  glVertex2f 0 1
                  glEnd

                  GLFW.swapBuffers win
                  GLFW.sleep 0.001
                  eventLoopAux t
                else pure ()