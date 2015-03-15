
open Tsdl
open Tsdl_image

let (>>=) o f =
  match o with | `Error e -> failwith (Printf.sprintf "Error %s" e)
               | `Ok a -> f a

let () =
  ignore (Sdl.init Sdl.Init.everything);
  let flags = Image.Init.(jpg + png) in
  assert ((Image.init flags) = flags);
  let Some sface = Image.load "what.png" in
  assert ((Sdl.get_surface_size sface) = (64,64));
  assert ((Image.save_png sface "output.png") = 0);
  Sdl.rw_from_file "what.png" "rb" >>= fun f ->
  assert (false = Image.is_ico f);
  assert (false = Image.is_bmp f);
  assert (false = Image.is_gif f);
  assert (false = Image.is_pcx f);
  assert (false = Image.is_jpg f);
  assert (Image.is_png f);
  Sdl.rw_close f |> ignore;
  Image.quit ();
  Sdl.quit ();
