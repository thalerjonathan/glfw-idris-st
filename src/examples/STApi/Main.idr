module Main

import Control.ST
import Data.IORef

import Graphics.Rendering.OpenGL
import Graphics.UI.GLFW.ST
import Graphics.UI.GLFW as GLFW

import Config

eventLoop : (Glfw m, ConsoleIO m)   
          => Double 
          -> (ctx : Var) 
          -> ST m () [ctx ::: GlfwContext {m} HasWindow]
eventLoop sec ctx = do
    t <- liftToHasWindow getTime ctx
    eventLoopAux t ctx
  where
    eventLoopAux :  (Glfw m, ConsoleIO m)
                 => Double 
                 -> (ctx : Var)
                 -> ST m () [ctx ::: GlfwContext {m} HasWindow]
    eventLoopAux t ctx = do
      t' <- liftToHasWindow getTime ctx
      if t' - t >= sec
        then pure ()
        else do
          ret <- isWindowOpen ctx
          if ret
            then do
              liftToHasWindow pollEvents ctx

              runIOHasWindow (do
                glClear GL_COLOR_BUFFER_BIT
                glClear GL_DEPTH_BUFFER_BIT
                glClearColor 0 0 0 1

                glColor4f 1 1 1 1

                glBegin GL_LINE_LOOP 
                glVertex2f (-1) 0
                glVertex2f 0 (-1)
                glVertex2f 1 0
                glVertex2f 0 1
                glEnd) ctx

              swapBuffers ctx
              liftToHasWindow (sleep 0.001) ctx
              eventLoopAux t ctx
            else pure ()

exampleInstallCallbacks :  (Glfw m, ConsoleIO m)
                        => IORef Integer
                        -> (ctx : Var)
                        -> ST m () [ctx ::: GlfwContext {m} HasWindow]
exampleInstallCallbacks ref ctx = do
    setWindowCloseCallback   ctx !(runIOHasWindow windowCloseCallbackPtr ctx)
    setWindowSizeCallback    ctx !(runIOHasWindow windowSizeCallbackPtr ctx)
    setKeyCallback           ctx !(runIOHasWindow keyCallbackPtr ctx)
    setCharCallback          ctx !(runIOHasWindow charCallbackPtr ctx)
    setMouseButtonCallback   ctx !(runIOHasWindow mouseButtonCallbackPtr ctx)
    setMouseWheelCallback    ctx !(runIOHasWindow mouseWheelCallbackPtr ctx)
    setMousePositionCallback ctx !(runIOHasWindow (mousePositionCallbackPtr ref) ctx)
    
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

exampleGlfwApi :  (Glfw m, ConsoleIO m) 
               => IORef Integer
               -> ST m () []
exampleGlfwApi ref = do
  putStr "Initializing GLFW... "
  (Just ctx) <- init | Nothing => putStrLn "failed"
  putStrLn "successful"

  (maj, min, rev) <- getVersion ctx
  putStrLn $ "--- GLFW " ++ show maj ++ "." ++ show min ++ "." ++ show rev ++ " ---"

  putStr "Creating Window... "
  let disp = record 
    { displayOptions_width        = 800
    , displayOptions_height       = 600
    , displayOptions_displayMode  = GLFW.WindowMode } GLFW.defaultDisplayOptions
  createWindow "GLFW ST API Example" disp ctx

  runIOHasWindow glewInit ctx
  makeContextCurrent ctx
  putStrLn "done!"

  showMouseCursor True ctx
  liftToHasWindow (setSwapInterval 1) ctx

  putStr $ "Installing Callbacks... "
  exampleInstallCallbacks ref
  putStrLn "done!"

  putStr $ "Entering event-loop for 5 sec ... \n"
  eventLoop 5 ctx
  putStrLn "Returned from event-loop!"

  putStr "Destroying Window... "
  destroyWindow ctx
  putStr "done!\nShuting down GLFW... "

  terminate ctx
  putStrLn "done!\nGoodbye!"

main : IO ()
main = do
  ref <- newIORef (the Integer 0)
  run $ exampleGlfwApi ref