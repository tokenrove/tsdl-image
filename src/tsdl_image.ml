open Ctypes
open Foreign
open Tsdl

module Image = struct

module Init = struct
  type t = Unsigned.uint32
  let i = Unsigned.UInt32.of_int
  let ( + ) = Unsigned.UInt32.logor
  let test f m = Unsigned.UInt32.(compare (logand f m) zero <> 0)
  let eq f f' = Unsigned.UInt32.(compare f f' = 0)
  let empty = i 0
  let jpg = i 1
  let png = i 2
  let tif = i 4
  let webp = i 8
end

let init =
  foreign "IMG_Init" (uint32_t @-> returning uint32_t)

let quit =
  foreign "IMG_Quit" (void @-> returning void)

let load =
  foreign "IMG_Load" (string @-> returning Sdl.surface_opt)

let load_texture =
  foreign "IMG_LoadTexture" (Sdl.renderer @-> string @-> returning Sdl.texture_opt)

let save_png =
  foreign "IMG_SavePNG" (Sdl.surface @-> string @-> returning int)

end
