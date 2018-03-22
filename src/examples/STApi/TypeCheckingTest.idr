import Control.ST

data GLFWState = Initialized | HasWindow
data DisplayOptions = MkDisplayOptions

interface Glfw (m : Type -> Type) where
  GlfwContext : GLFWState -> Type

  init      : ST m (Maybe Var) [addIfJust (GlfwContext Initialized)]
  terminate : (ctx : Var) -> ST m () [remove ctx (GlfwContext Initialized)]

  setSwapInterval : Nat -> (ctx : Var) -> ST m () [ctx ::: GlfwContext Initialized]

  liftToHasWindow :  ((ctx : Var) -> ST m a [ctx ::: GlfwContext Initialized])
                  -> (ctx : Var) 
                  -> ST m a [ctx ::: GlfwContext HasWindow]

  runIOInit      : IO a -> (ctx : Var) -> ST m a [ctx ::: GlfwContext Initialized]
  runIOHasWindow : IO a -> (ctx : Var) -> ST m a [ctx ::: GlfwContext HasWindow]

  createWindow :  (title: String)
               -> DisplayOptions 
               -> (ctx : Var) 
               -> ST m () [ctx ::: GlfwContext Initialized :-> GlfwContext HasWindow]

  destroyWindow : (ctx : Var) 
                -> ST m () [ctx ::: GlfwContext HasWindow :-> GlfwContext Initialized]

Glfw IO where
  GlfwContext x = State Ptr

  init = do
    ctx <- new null
    pure $ Just ctx

  setSwapInterval i ctx = pure ()

  liftToHasWindow f ctx = do
    ret <- f ctx
    pure ret

  runIOInit f ctx = do
    ret <- lift $ f
    pure ret

  runIOHasWindow f ctx 
    = liftToHasWindow (runIOInit f) ctx

  createWindow title opts ctx = pure ()

  destroyWindow ctx = pure ()

  terminate ctx = delete ctx

exampleGlfwApi : (Glfw m, ConsoleIO m) => ST m () []
exampleGlfwApi = do
  putStr "Initializing GLFW... "
  (Just ctx) <- init | Nothing => putStrLn "failed"
  putStrLn "successful"

  putStr "Creating Window... "
  createWindow "GLFW ST API Example" MkDisplayOptions ctx
  putStrLn "done!"

  putStr "Initializing GLEW... "
  runIOHasWindow (pure ()) ctx -- commenting out this line reduces type-checking time considerably
  putStrLn "done!"

  putStr "Setting MouseCursor and swap interval... "
  liftToHasWindow (setSwapInterval 1) ctx -- commenting out this line reduces type-checking time considerably
  putStrLn "done!"

  putStr "Destroying Window... "
  destroyWindow ctx
  putStr "done!\nShuting down GLFW... "

  terminate ctx
  putStrLn "done!\nGoodbye!"

main : IO ()
main = run exampleGlfwApi