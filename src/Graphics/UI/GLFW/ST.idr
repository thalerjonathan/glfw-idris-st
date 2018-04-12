module Graphics.UI.GLFW.ST

import Control.ST
import Graphics.UI.GLFW as GLFW

public export
data GlfwState = Initialized | HasWindow

public export
interface Glfw (m : Type -> Type) where
  GlfwContext : GlfwState -> Type

  init      : ST m (Maybe Var) [addIfJust (GlfwContext Initialized)]
  terminate : (ctx : Var) -> ST m () [remove ctx (GlfwContext s)]

  getVersion      : (ctx : Var) -> ST m (Nat, Nat, Nat) [ctx ::: GlfwContext s]
  -- TODO: should only be called with a current context
  setSwapInterval : Nat -> (ctx : Var) -> ST m () [ctx ::: GlfwContext s]
  getTime         : (ctx : Var) -> ST m Double [ctx ::: GlfwContext s]
  pollEvents      : (ctx : Var) -> ST m () [ctx ::: GlfwContext s]
  sleep           : Double -> (ctx : Var) -> ST m () [ctx ::: GlfwContext s]
  primaryMonitor  : (ctx : Var) -> ST m Monitor [ctx ::: GlfwContext s]
  getVideoMode    : Monitor -> (ctx : Var) -> ST m GlfwVideomode [ctx ::: GlfwContext s]

  ||| use this to run an IO action within any GlfwContext
  runIOAny : IO a -> (ctx : Var) -> ST m a [ctx ::: GlfwContext s]
  ||| Use this to run an IO action within an Initialized GlfwContext 
  runIOInit : IO a -> (ctx : Var) -> ST m a [ctx ::: GlfwContext Initialized]
  ||| Use this to run an IO action within a GlfwContext with a Window
  |||  the use case for this is initialisation of GLEW. It would of course be
  |||  much nicer to have e.g. a function glewInit in this interface but this
  |||  would create a dependency to GLEW which we would like to omit.
  runIOHasWindow : IO a -> (ctx : Var) -> ST m a [ctx ::: GlfwContext HasWindow]

  createWindow :  (title: String)
               -> DisplayOptions 
               -> (ctx : Var) 
               -> ST m () [ctx ::: GlfwContext Initialized :-> GlfwContext HasWindow]
  makeContextCurrent  : (ctx : Var) -> ST m () [ctx ::: GlfwContext HasWindow]
  showMouseCursor     : Bool -> (ctx : Var) -> ST m () [ctx ::: GlfwContext HasWindow]
  isWindowOpen        : (ctx : Var) -> ST m Bool [ctx ::: GlfwContext HasWindow]
  swapBuffers         : (ctx : Var) -> ST m () [ctx ::: GlfwContext HasWindow]
  
  windowValue         : WindowValue -> (ctx : Var) -> ST m Int [ctx ::: GlfwContext HasWindow]

  setWindowCloseCallback   : (ctx : Var) -> Ptr -> ST m () [ctx ::: GlfwContext HasWindow]
  setWindowSizeCallback    : (ctx : Var) -> Ptr -> ST m () [ctx ::: GlfwContext HasWindow]
  setKeyCallback           : (ctx : Var) -> Ptr -> ST m () [ctx ::: GlfwContext HasWindow]
  setCharCallback          : (ctx : Var) -> Ptr -> ST m () [ctx ::: GlfwContext HasWindow]
  setMouseButtonCallback   : (ctx : Var) -> Ptr -> ST m () [ctx ::: GlfwContext HasWindow]
  setMouseWheelCallback    : (ctx : Var) -> Ptr -> ST m () [ctx ::: GlfwContext HasWindow]
  setMousePositionCallback : (ctx : Var) -> Ptr -> ST m () [ctx ::: GlfwContext HasWindow]

  getMousePosition     : (ctx : Var) -> ST m (Double, Double) [ctx ::: GlfwContext HasWindow]
  isMouseButtonPressed : GlfwMouseButton -> (ctx : Var) -> ST m Bool [ctx ::: GlfwContext HasWindow]
  isKeyPressed         : GlfwKey -> (ctx : Var) -> ST m Bool [ctx ::: GlfwContext HasWindow]

  destroyWindow       : (ctx : Var) 
                      -> ST m () [ctx ::: GlfwContext HasWindow :-> GlfwContext Initialized]

export
Glfw IO where
  GlfwContext x = State Window

  init = do
    ret <- lift $ GLFW.initialize
    if ret 
      then do
        ctx <- new NullWindow
        pure $ Just ctx
      else pure Nothing

  getVersion ctx = do
    (maj, min, rev) <- lift $ GLFW.getGlfwVersion
    pure (cast maj, cast min, cast rev)

  setSwapInterval i ctx = do
    lift $ GLFW.setSwapInterval (toIntNat i)

  getTime ctx = do
    lift $ GLFW.getTime 

  pollEvents ctx = do
    lift $ GLFW.pollEvents

  sleep secFract ctx = do
    lift $ GLFW.sleep secFract

  primaryMonitor ctx = do
    lift $ GLFW.getPrimaryMonitor

  getVideoMode mon ctx = do
    lift $ GLFW.getVideoMode mon

  runIOAny f ctx = do
    ret <- lift $ f
    pure ret

  runIOInit f ctx = do
    ret <- lift $ f
    pure ret

  runIOHasWindow f ctx = do
    ret <- lift $ f
    pure ret

  createWindow title opts ctx = do
    win <- lift $ GLFW.createWindow title opts
    write ctx win

  makeContextCurrent ctx = do
    win <- read ctx
    lift $ GLFW.makeContextCurrent win

  showMouseCursor flag ctx = do
    win <- read ctx
    lift $ GLFW.showMouseCursor win flag

  isWindowOpen ctx = do
    win <- read ctx
    lift $ GLFW.windowIsOpen win

  swapBuffers ctx = do
    win <- read ctx
    lift $ GLFW.swapBuffers win

  windowValue val ctx = do
    win <- read ctx
    lift $ GLFW.getWindowValue win val

  setWindowCloseCallback ctx ptr = do
    win <- read ctx
    lift $ GLFW.setWindowCloseCallback win ptr

  setWindowSizeCallback ctx ptr = do
    win <- read ctx
    lift $ GLFW.setWindowSizeCallback win ptr

  setKeyCallback ctx ptr = do
    win <- read ctx
    lift $ GLFW.setKeyCallback win ptr

  setCharCallback ctx ptr = do
    win <- read ctx
    lift $ GLFW.setCharCallback win ptr

  setMouseButtonCallback ctx ptr = do
      win <- read ctx
      lift $ GLFW.setMouseButtonCallback win ptr

  setMouseWheelCallback ctx ptr = do
      win <- read ctx
      lift $ GLFW.setMouseWheelCallback win ptr

  setMousePositionCallback ctx ptr = do
      win <- read ctx
      lift $ GLFW.setMousePositionCallback win ptr

  getMousePosition ctx = do
    win <- read ctx
    lift $ GLFW.getCursorPos win

  isMouseButtonPressed btn ctx = do
    win <- read ctx
    lift $ GLFW.isMouseButtonPressed win btn

  isKeyPressed key ctx = do
    win <- read ctx
    lift $ GLFW.isKeyPressed win key

  destroyWindow ctx = do
    win <- read ctx
    lift $ GLFW.destroyWindow win
    write ctx NullWindow

  terminate ctx = delete ctx
