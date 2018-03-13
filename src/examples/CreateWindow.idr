module CreateWindow

import System.Concurrency.Channels

import Graphics.UI.GLFW.GLFW as GLFW

createWindowTest : IO ()
createWindowTest = do
    ok <- GLFW.initialize 
    case ok of
      False => putStrLn "Initializing GLFW failed"
      True  => do
        (maj, min, rev) <- GLFW.getGlfwVersion
        putStrLn "Initializing GLFW successful"
        putStrLn $ "--- GLFW " ++ show maj ++ "." ++ show min ++ "." ++ show rev ++ " ---"

        let disp = record 
          { displayOptions_width        = 800
          , displayOptions_height       = 600
          , displayOptions_displayMode  = GLFW.WindowMode } GLFW.defaultDisplayOptions
        win <- GLFW.openWindow "glfw-idris-st createwindow example " disp

        GLFW.showMouseCursor win True
        GLFW.setSwapInterval 1
        
        pump win 5

        putStrLn "Shuting down GLFW..."
        GLFW.shutdown

  where
    pump : GLFW.Window -> Double -> IO ()
    pump win sec = do
        t <- GLFW.getTime
        pumpAux t
      where
        pumpAux : Double -> IO ()
        pumpAux t = do
          t' <- GLFW.getTime
          if t' - t >= sec
            then pure ()
            else do
              ret <- GLFW.windowIsOpen win
              if ret
                then do
                  GLFW.pollEvents
                  GLFW.swapBuffers win
                  GLFW.sleep 0.001
                  pumpAux t
                else pure ()