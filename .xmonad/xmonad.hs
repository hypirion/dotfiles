import XMonad
import XMonad.Config.Xfce
import XMonad.Util.EZConfig
import XMonad.Hooks.EwmhDesktops
import qualified Data.Map as M

hypirionTerminal = "xfce-terminal"

hypirionKeys (XConfig {modMask = mod4Mask}) = M.fromList $
             [((mod4Mask, xK_F4), kill)]

main = xmonad xfceConfig {
     terminal = hypirionTerminal,
     modMask = mod4Mask,
     handleEventHook = fullscreenEventHook,
     keys = \c -> hypirionKeys c `M.union` keys xfceConfig c
     }
