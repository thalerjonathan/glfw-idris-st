module Graphics.UI.GLFW.ST

import Control.ST

import Graphics.UI.GLFW as GLFW

public export
data GLFWState = Initialized | HasWindow

public export
data GLFWInit = OK | Failed

-- TODO: currently only one window is supported

public export
interface Glfw (m : Type -> Type) where
  GlfwContext : GLFWState -> Type

  -- TODO: should depend on success
  init : ST m Var [add (GlfwContext Initialized)]

  -- TODO: should work in HasWindow too
  getVersion : (ctx : Var) -> ST m (Nat, Nat, Nat) [ctx ::: GlfwContext Initialized]
  -- TODO: should work in HasWindow too
  setSwapInterval : (ctx : Var) -> Nat -> ST m () [ctx ::: GlfwContext Initialized]

  createWindow : (ctx : Var) 
               -> (title: String)
               -> DisplayOptions 
               -> ST m () [ctx ::: GlfwContext Initialized :-> GlfwContext HasWindow]
  makeContextCurrent : (ctx : Var) -> ST m () [ctx ::: GlfwContext HasWindow]
  showMouseCursor : (ctx : Var) -> Bool -> ST m () [ctx ::: GlfwContext HasWindow]
  destroyWindow : (ctx : Var) -> ST m () [ctx ::: GlfwContext HasWindow :-> GlfwContext Initialized]

  terminate : (ctx : Var) -> ST m () [remove ctx (GlfwContext Initialized)]

export
Glfw IO where
  GlfwContext x = State Window

  init = do
    lift $ GLFW.initialize
    ctx <- new NullWindow
    pure ctx

  getVersion ctx = do
    (maj, min, rev) <- lift $ GLFW.getGlfwVersion
    pure (cast maj, cast min, cast rev)

  setSwapInterval ctx i = do
    lift $ GLFW.setSwapInterval (toIntNat i)

  createWindow ctx title opts = do
    win <- lift $ GLFW.createWindow title opts
    write ctx win

  makeContextCurrent ctx = do
    win <- read ctx
    lift $ GLFW.makeContextCurrent win

  showMouseCursor ctx flag = do
    win <- read ctx
    lift $ GLFW.showMouseCursor win flag

  destroyWindow ctx = do
    win <- read ctx
    lift $ GLFW.destroyWindow win
    write ctx NullWindow

  terminate ctx = delete ctx
