import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = do
    xmproc <- spawnPipe "feh --bg-scale ~/.local/share/backgrounds/bust.png"
    xmproc <- spawnPipe "xcompmgr -c"
    xmproc <- spawnPipe "xmobar"
    xmonad $ defaultConfig
        { modMask = mod4Mask
        , terminal = "urxvt -mod mod1"
        , startupHook = spawn "xset r rate 200 20"
        , manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , normalBorderColor = "#9c4c8c"
        , focusedBorderColor = "#ffffff"
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock; xset dpms force off")
        , ((mod4Mask .|. shiftMask, xK_BackSpace), spawn "chromium")
        , ((mod4Mask .|. shiftMask, xK_numbersign), spawn "emacs")
        ]
