import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.Cursor(setDefaultCursor)
import XMonad.Util.EZConfig(additionalKeys)

import System.IO

myManageHook = composeAll [
    className =? "Pidgin" --> doShift "2:im" ]

main = do
    xmproc <- spawnPipe "feh --bg-scale ~/.local/share/backgrounds/bust.png"
    xmproc <- spawnPipe "xcompmgr -c"
    xmproc <- spawnPipe "xmobar"
    xmonad $ defaultConfig
        { modMask = mod4Mask
        , terminal = "urxvt -mod mod1"
        , workspaces = ["1:main", "2:im", "3:media"] ++ map show([4..9] ++ [0])
        , startupHook = do
              spawn "pidgin"
              spawn "xset r rate 200 20"
              setDefaultCursor xC_left_ptr
              spawn "xscreensaver -no-splash"
        , manageHook = manageDocks <+> myManageHook <+> manageHook defaultConfig
        , layoutHook = avoidStruts $ layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , normalBorderColor = "#9c4c8c"
        , focusedBorderColor = "#ffffff"
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z)
               , spawn "xscreensaver-command -lock; xset dpms force off")
        , ((mod4Mask .|. shiftMask, xK_BackSpace), spawn "chromium")
        , ((mod4Mask .|. shiftMask, xK_numbersign), spawn "emacs")
        ]
