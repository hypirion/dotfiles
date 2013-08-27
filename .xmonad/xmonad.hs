import XMonad
import XMonad.Config.Xfce
import XMonad.Util.EZConfig
import XMonad.Layout.NoBorders
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import qualified XMonad.StackSet as W
import qualified Data.Map as M

hypirionTerminal = "xfce4-terminal"

hypirionWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

hypirionKeys (XConfig {modMask = mod4Mask}) = M.fromList $
             [((mod4Mask, xK_F4), kill)] ++
             [((m .|. mod4Mask, k), windows $ f i)
                  | (i, k) <- zip hypirionWorkspaces [xK_1 .. xK_9]
                  , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

hypirionLayout = tiled ||| Mirror tiled ||| noBorders Full
  where
    tiled = Tall 1 (3/100) (1/2)

main = xmonad $ xfceConfig {
     terminal = hypirionTerminal,
     modMask = mod4Mask,
     handleEventHook = fullscreenEventHook,
     layoutHook = avoidStruts $ hypirionLayout,
     workspaces = hypirionWorkspaces
     } `additionalKeysP` hypirionKeys
