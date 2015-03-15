open Ctypes
open Foreign
open Tsdl

module Image = struct

let bool =
  view ~read:((<>)0) ~write:(fun b -> compare b false) int

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

let surface =
  view ~read:Sdl.unsafe_surface_of_ptr ~write:Sdl.unsafe_ptr_of_surface nativeint
let surface_opt =
  let read v = if Nativeint.(compare v zero) = 0 then None else Some (Sdl.unsafe_surface_of_ptr v) in
  let write = function | None -> raw_address_of_ptr @@ null | Some s -> Sdl.unsafe_ptr_of_surface s in
  view ~read ~write nativeint

let texture_opt =
  let read v = if Nativeint.(compare v zero) = 0 then None else Some (Sdl.unsafe_texture_of_ptr v) in
  let write = function | None -> raw_address_of_ptr @@ null | Some s -> Sdl.unsafe_ptr_of_texture s in
  view ~read ~write nativeint

let rw_ops =
  view ~read:Sdl.unsafe_rw_ops_of_ptr ~write:Sdl.unsafe_ptr_of_rw_ops nativeint
let renderer =
  view ~read:Sdl.unsafe_renderer_of_ptr ~write:Sdl.unsafe_ptr_of_renderer nativeint

let load =
  foreign "IMG_Load" (string @-> returning surface_opt)

let load_rw =
  foreign "IMG_Load_RW" (rw_ops @-> bool @-> returning surface_opt)

let load_typed_rw =
  foreign "IMG_LoadTyped_RW"
    (rw_ops @-> bool @-> string @-> returning surface_opt)

let load_texture =
  foreign "IMG_LoadTexture"
    (renderer @-> string @-> returning texture_opt)

let load_texture_rw =
  foreign "IMG_LoadTexture_RW"
    (renderer @-> rw_ops @-> bool @-> returning texture_opt)

let load_texture_typed_rw =
  foreign "IMG_LoadTextureTyped_RW"
    (renderer @-> rw_ops @-> bool @-> string @-> returning texture_opt)

let is_ico = foreign "IMG_isICO" (rw_ops @-> returning bool)
let is_cur = foreign "IMG_isCUR" (rw_ops @-> returning bool)
let is_bmp = foreign "IMG_isBMP" (rw_ops @-> returning bool)
let is_gif = foreign "IMG_isGIF" (rw_ops @-> returning bool)
let is_jpg = foreign "IMG_isJPG" (rw_ops @-> returning bool)
let is_lbm = foreign "IMG_isLBM" (rw_ops @-> returning bool)
let is_pcx = foreign "IMG_isPCX" (rw_ops @-> returning bool)
let is_png = foreign "IMG_isPNG" (rw_ops @-> returning bool)
let is_pnm = foreign "IMG_isPNM" (rw_ops @-> returning bool)
let is_tif = foreign "IMG_isTIF" (rw_ops @-> returning bool)
let is_xcf = foreign "IMG_isXCF" (rw_ops @-> returning bool)
let is_xpm = foreign "IMG_isXPM" (rw_ops @-> returning bool)
let is_xv = foreign "IMG_isXV" (rw_ops @-> returning bool)
let is_webp = foreign "IMG_isWEBP" (rw_ops @-> returning bool)

let load_ico_rw = foreign "IMG_LoadICO_RW" (rw_ops @-> returning surface_opt)
let load_cur_rw = foreign "IMG_LoadCUR_RW" (rw_ops @-> returning surface_opt)
let load_bmp_rw = foreign "IMG_LoadBMP_RW" (rw_ops @-> returning surface_opt)
let load_gif_rw = foreign "IMG_LoadGIF_RW" (rw_ops @-> returning surface_opt)
let load_jpg_rw = foreign "IMG_LoadJPG_RW" (rw_ops @-> returning surface_opt)
let load_lbm_rw = foreign "IMG_LoadLBM_RW" (rw_ops @-> returning surface_opt)
let load_pcx_rw = foreign "IMG_LoadPCX_RW" (rw_ops @-> returning surface_opt)
let load_png_rw = foreign "IMG_LoadPNG_RW" (rw_ops @-> returning surface_opt)
let load_pnm_rw = foreign "IMG_LoadPNM_RW" (rw_ops @-> returning surface_opt)
let load_tga_rw = foreign "IMG_LoadTGA_RW" (rw_ops @-> returning surface_opt)
let load_tif_rw = foreign "IMG_LoadTIF_RW" (rw_ops @-> returning surface_opt)
let load_xcf_rw = foreign "IMG_LoadXCF_RW" (rw_ops @-> returning surface_opt)
let load_xpm_rw = foreign "IMG_LoadXPM_RW" (rw_ops @-> returning surface_opt)
let load_xv_rw = foreign "IMG_LoadXV_RW" (rw_ops @-> returning surface_opt)
let load_webp_rw = foreign "IMG_LoadWEBP_RW" (rw_ops @-> returning surface_opt)

let read_xpm_from_array =
  foreign "IMG_ReadXPMFromArray" (ptr string @-> returning surface_opt)

let save_png =
  foreign "IMG_SavePNG" (surface @-> string @-> returning int)
let save_png_rw =
  foreign "IMG_SavePNG_RW" (surface @-> rw_ops @-> bool @-> returning int)

end
