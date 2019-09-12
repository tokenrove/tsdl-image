
open Tsdl
open Tsdl_image
open Result

let (>>=) o f =
  match o with | Error (`Msg e) -> failwith (Printf.sprintf "Error %s" e)
               | Ok a -> f a

let () =
  ignore (Sdl.init Sdl.Init.everything);
  let flags = Image.Init.(jpg + png) in
  assert ((Image.init flags) = flags);
  let sface = match Image.load "what.png" with
  | Result.Ok sface -> sface
  | _ -> failwith "can't load image"
  in
  assert ((Sdl.get_surface_size sface) = (64,64));
  assert ((Image.save_png sface "output.png") = 0);
  Sdl.rw_from_file "what.png" "rb" >>= fun f ->
  assert (false = Image.is_format Image.Ico f);
  assert (false = Image.is_format Image.Bmp f);
  assert (false = Image.is_format Image.Gif f);
  assert (false = Image.is_format Image.Pcx f);
  assert (false = Image.is_format Image.Jpg f);
  assert (Image.is_format Image.Png f);
  Sdl.rw_close f |> ignore;
  Image.quit ();
  Sdl.quit ();
