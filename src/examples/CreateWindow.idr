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

        GLFW.setSwapInterval 1

        -- wait for 5 seconds and then terminate
        pt <- spawn $ pollThread win

        listen 10

        putStrLn "Shuting down GLFW..."
        GLFW.shutdown

  where
    pollThread : GLFW.Window -> IO ()
    pollThread win = do
      GLFW.pollEvents
      GLFW.swapBuffers win
      --putStrLn "polling..."
      pollThread win