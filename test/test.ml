
open Tsdl
open Tsdl_image

let () =
  ignore (Sdl.init Sdl.Init.everything);
  let flags = Image.Init.(jpg + png) in
  assert ((Image.init flags) = flags);
  let Some sface = Image.load "what.png" in
  assert ((Sdl.get_surface_size sface) = (64,64));
  assert ((Image.save_png sface "output.png") = 0);
  Image.quit ();
  Sdl.quit ();
