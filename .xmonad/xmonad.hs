import XMonad
import XMonad.Config.Xfce
import XMonad.Util.EZConfig
import XMonad.Layout.NoBorders
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import qualified Data.Map as M

hypirionTerminal = "xfce4-terminal"

hypirionKeys (XConfig {modMask = mod4Mask}) = M.fromList $
             [((mod4Mask, xK_F4), kill)]

hypirionLayout = tiled ||| Mirror tiled ||| noBorders Full
  where
    tiled = Tall 1 (3/100) (1/2)

main = xmonad xfceConfig {
     terminal = hypirionTerminal,
     modMask = mod4Mask,
     handleEventHook = fullscreenEventHook,
     layoutHook =  avoidStruts $ hypirionLayout,
     keys = \c -> hypirionKeys c `M.union` keys xfceConfig c
     }
