module Main

import Control.ST

import Graphics.Rendering.OpenGL.Internal.GLEW
import Graphics.UI.GLFW.ST
import Graphics.UI.GLFW as GLFW

import Config

{-
eventLoopDuration : Double
eventLoopDuration = 5.0

eventLoop :  (Glfw m, ConsoleIO m)
          => Double 
          -> ST m () []
eventLoop sec = ?eventLoop


eventLoop : (Glfw m, ConsoleIO m) 
          => (ctx : GLFWState)
          -> Double 
          -> ST m () [ctx ::: GlfwContext HasWindow]
eventLoop ctx sec = ?eventLoop  do
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
-}

exampleGlfwApi : (Glfw m, ConsoleIO m) => ST m () []
exampleGlfwApi = do
  putStr "Initializing GLFW... "
  ctx <- init
  putStrLn "successful"

  (maj, min, rev) <- getVersion ctx
  putStrLn $ "--- GLFW " ++ show maj ++ "." ++ show min ++ "." ++ show rev ++ " ---"

  -- TODO: have to call at this place because atm this function can only be called when Initialized
  setSwapInterval ctx 1


  putStr "Creating Window... "
  let disp = record 
    { displayOptions_width        = 800
    , displayOptions_height       = 600
    , displayOptions_displayMode  = GLFW.WindowMode } GLFW.defaultDisplayOptions
  createWindow ctx "GLFW ST API Example" disp

  -- TODO: this doesnt work yet
  -- lift $ glewInit
  makeContextCurrent ctx
  putStrLn "done!"

  --showMouseCursor ctx True
  -- TODO: does not work, because not in Initialized state
  -- setSwapInterval ctx 1

{-
  putStr $ "Entering event-loop for " ++ show eventLoopDuration ++ " sec ... \n"
  --eventLoop eventLoopDuration
  putStr "Returned from event-loop!"
  -}

  putStr "Destroying Window... "
  destroyWindow ctx
  putStr "done!\nShuting down GLFW... "
  terminate ctx
  putStrLn "done!\nGoodbye!"

main : IO ()
main = run exampleGlfwApi