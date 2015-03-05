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

let load =
  foreign "IMG_Load" (string @-> returning Sdl.surface_opt)

let load_rw =
  foreign "IMG_Load_RW" (Sdl.rw_ops @-> int @-> returning Sdl.surface_opt)

let load_typed_rw =
  foreign "IMG_LoadTyped_RW"
    (Sdl.rw_ops @-> int @-> string @-> returning Sdl.surface_opt)

let load_texture =
  foreign "IMG_LoadTexture"
    (Sdl.renderer @-> string @-> returning Sdl.texture_opt)

let load_texture_rw =
  foreign "IMG_LoadTexture_RW"
    (Sdl.renderer @-> Sdl.rw_ops @-> int @-> returning Sdl.texture_opt)

let load_texture_typed_rw =
  foreign "IMG_LoadTextureTyped_RW"
    (Sdl.renderer @-> Sdl.rw_ops @-> int @-> string @-> returning Sdl.texture_opt)

let is_ico = foreign "IMG_isICO" (Sdl.rw_ops @-> returning bool)
let is_cur = foreign "IMG_isCUR" (Sdl.rw_ops @-> returning bool)
let is_bmp = foreign "IMG_isBMP" (Sdl.rw_ops @-> returning bool)
let is_gif = foreign "IMG_isGIF" (Sdl.rw_ops @-> returning bool)
let is_jpg = foreign "IMG_isJPG" (Sdl.rw_ops @-> returning bool)
let is_lbm = foreign "IMG_isLBM" (Sdl.rw_ops @-> returning bool)
let is_pcx = foreign "IMG_isPCX" (Sdl.rw_ops @-> returning bool)
let is_png = foreign "IMG_isPNG" (Sdl.rw_ops @-> returning bool)
let is_pnm = foreign "IMG_isPNM" (Sdl.rw_ops @-> returning bool)
let is_tif = foreign "IMG_isTIF" (Sdl.rw_ops @-> returning bool)
let is_xcf = foreign "IMG_isXCF" (Sdl.rw_ops @-> returning bool)
let is_xpm = foreign "IMG_isXPM" (Sdl.rw_ops @-> returning bool)
let is_xv = foreign "IMG_isXV" (Sdl.rw_ops @-> returning bool)
let is_webp = foreign "IMG_isWEBP" (Sdl.rw_ops @-> returning bool)

let load_ico_rw = foreign "IMG_LoadICO_RW" (Sdl.rw_ops @-> returning Sdl.surface_opt)
let load_cur_rw = foreign "IMG_LoadCUR_RW" (Sdl.rw_ops @-> returning Sdl.surface_opt)
let load_bmp_rw = foreign "IMG_LoadBMP_RW" (Sdl.rw_ops @-> returning Sdl.surface_opt)
let load_gif_rw = foreign "IMG_LoadGIF_RW" (Sdl.rw_ops @-> returning Sdl.surface_opt)
let load_jpg_rw = foreign "IMG_LoadJPG_RW" (Sdl.rw_ops @-> returning Sdl.surface_opt)
let load_lbm_rw = foreign "IMG_LoadLBM_RW" (Sdl.rw_ops @-> returning Sdl.surface_opt)
let load_pcx_rw = foreign "IMG_LoadPCX_RW" (Sdl.rw_ops @-> returning Sdl.surface_opt)
let load_png_rw = foreign "IMG_LoadPNG_RW" (Sdl.rw_ops @-> returning Sdl.surface_opt)
let load_pnm_rw = foreign "IMG_LoadPNM_RW" (Sdl.rw_ops @-> returning Sdl.surface_opt)
let load_tga_rw = foreign "IMG_LoadTGA_RW" (Sdl.rw_ops @-> returning Sdl.surface_opt)
let load_tif_rw = foreign "IMG_LoadTIF_RW" (Sdl.rw_ops @-> returning Sdl.surface_opt)
let load_xcf_rw = foreign "IMG_LoadXCF_RW" (Sdl.rw_ops @-> returning Sdl.surface_opt)
let load_xpm_rw = foreign "IMG_LoadXPM_RW" (Sdl.rw_ops @-> returning Sdl.surface_opt)
let load_xv_rw = foreign "IMG_LoadXV_RW" (Sdl.rw_ops @-> returning Sdl.surface_opt)
let load_webp_rw = foreign "IMG_LoadWEBP_RW" (Sdl.rw_ops @-> returning Sdl.surface_opt)

let read_xpm_from_array =
  foreign "IMG_ReadXPMFromArray" (ptr string @-> returning Sdl.surface_opt)

let save_png =
  foreign "IMG_SavePNG" (Sdl.surface @-> string @-> returning int)
let save_png_rw =
  foreign "IMG_SavePNG" (Sdl.surface @-> Sdl.rw_ops @-> int @-> returning int)

end
