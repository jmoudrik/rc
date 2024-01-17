import XMonad  
import XMonad.Config.Azerty  
import XMonad.Hooks.DynamicLog  
import XMonad.Hooks.ManageDocks  
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Util.Run(spawnPipe)  
import XMonad.Util.EZConfig  
import Graphics.X11.ExtraTypes.XF86  
import XMonad.Layout.Spacing  
import XMonad.Layout.NoBorders(smartBorders)  
import XMonad.Layout.PerWorkspace  
import XMonad.Actions.MouseResize
import XMonad.Layout.WindowArranger
import XMonad.Actions.WorkspaceNames
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

--import XMonad.Layout.IM  
import XMonad.Layout.Grid  
import XMonad.Layout.Fullscreen
import XMonad.Layout.Tabbed
import XMonad.Layout.SimpleFloat
import XMonad.Actions.CycleWS
import XMonad.Prompt (XPConfig (..), font, height, position)

--import XMonad.Actions.GridSelect  
import Data.Ratio ((%))  
import XMonad.Actions.CycleWS  
import qualified XMonad.StackSet as W  
import System.IO  

myExtraWorkspaces = [(xK_0, "0"),(xK_minus, "-"),(xK_equal, "=")]
myWorkspaces  = ["1","2","3","4","5","6","7","8","9"]  ++ (map snd myExtraWorkspaces)

myXPConfig :: XPConfig
myXPConfig = def { font = "xft:terminus:size=16:antialias=false", height = 30 }

myLayout = 
--onWorkspaces ["9"] tabbedLayout $
	tiled1 ||| Mirror tiled1 ||| tabbedLayout
-- jm:
-- grid je dobrej pro furu oken, ale to nepouzivam;
-- nobordersLayout je fajn, ale tabbed s 1 oknem je dtto  
-- simple float nepouzivam (a navic alt+t to dela)
-- ||| gridLayout ||| nobordersLayout ||| simpleFloat
 where  
  tiled1 = spacing 0 $ smartBorders $ Tall nmaster1 delta ratio  
  --tiled2 = spacing 5 $ Tall nmaster2 delta ratio  
  nmaster1 = 1  
  nmaster2 = 2  
  ratio = 2/3  
  delta = 3/100  
  nobordersLayout = smartBorders $ Full
  tabbedLayout = smartBorders $ simpleTabbed 
  gridLayout = spacing 0 $ Grid

myManageHook = composeAll       
     [
     isFullscreen --> doFullFloat
     , title =? "htopterm" --> doShift "9"  
     ]

myLogHook pipe = workspaceNamesPP xmobarPP {
            ppOutput = hPutStrLn pipe  
            , ppTitle = xmobarColor "#2CE3FF" "" . shorten 70  
            , ppLayout = const "" -- to disable the layout info on xmobar  
           } >>= dynamicLogWithPP

main = do  
  xmproc <- spawnPipe "/usr/bin/xmobar /home/jm/.xmonad/xmobarrc.hs"  
  xmonad $ docks $ def
    {
      modMask = mod3Mask
    , manageHook = manageDocks <+> myManageHook <+> fullscreenManageHook <+> manageHook def  
    , layoutHook = avoidStrutsOn [U] $ myLayout
    , handleEventHook = handleEventHook def <+> XMonad.Layout.Fullscreen.fullscreenEventHook
    --, logHook = dynamicLogWithPP $ myPP xmproc
    , logHook = myLogHook xmproc
    , startupHook = setWMName "LG3D"
    , workspaces     = myWorkspaces  
    , borderWidth    = 2
    }`additionalKeys`  
     ([
     ((mod3Mask, xK_p), (spawn "dmenu_run -l 10 -sf yellow -nb black -fn terminus-12"))
     , ((mod4Mask, xK_t), spawn "term")
     , ((mod4Mask, xK_c), spawn "google-chrome")
     , ((mod4Mask, xK_f), spawn "firefox")
     , ((mod4Mask, xK_l), spawn "xlinks2")
     , ((mod3Mask, xK_c), kill)
     , ((0, xF86XK_AudioLowerVolume), spawn "amixer set Master 3%-")
     , ((0, xF86XK_AudioRaiseVolume), spawn "amixer set Master 3%+")
     , ((0, xF86XK_AudioMute), spawn "audio_toggle")
     , ((0, xF86XK_MonBrightnessUp), spawn "lxqt-config-brightness -i")
     , ((0, xF86XK_MonBrightnessDown), spawn "lxqt-config-brightness -d")
     -- xF86XK_AudioMicMute to neumi...
     , ((0, 0x1008ffb2), spawn "amixer set Capture toggle")

     , ((0, xF86XK_Sleep), spawn "sleep_n_lock")
     , ((0, xF86XK_ScreenSaver), spawn "xscreensaver-command -lock")
     -- (keysym 0x1008ffa9, XF86TouchpadToggle) 
     --
     -- xF86XK_TouchpadToggle to neumi...
     , ((0, 0x1008ffa9), spawn "touchpad_toggle")

     --, ((mod4Mask, xK_a ), windows W.swapUp) -- swap up window  
     --, ((mod4Mask, xK_z ), windows W.swapDown) -- swap down window  
     , ((mod3Mask, xK_KP_Add ), sendMessage (IncMasterN 1)) -- increase the number of window on master pane  
     , ((mod3Mask, xK_KP_Subtract ), sendMessage (IncMasterN (-1))) -- decrease the number of window  
     --, ((controlMask,        xK_Right   ), sendMessage Expand) -- expand master pane  
     --, ((controlMask,        xK_Left   ), sendMessage Shrink) -- shrink master pane  
    , ((0, xK_Print), spawn "flameshot gui") -- capture screenshot of full desktop  
    --, ((0, xK_Print), spawn "scrot") -- capture screenshot of full desktop  
    --
    -- tohle  na prejmenovavani workspaces, ale ted nefunguje, protoze to neumim 
    -- zobrazit v xmobaru nahore (mozna potrebuju xmonad 0.17)
    , ((mod3Mask, xK_r ), XMonad.Actions.WorkspaceNames.renameWorkspace myXPConfig)

    , ((mod1Mask, xK_Tab), windows W.focusDown)
    ] ++ [
        ((mod3Mask, key), (windows $ W.greedyView ws))
        | (key,ws) <- myExtraWorkspaces
      ] ++ [
        ((mod3Mask .|. shiftMask, key), (windows $ W.shift ws))
        | (key,ws) <- myExtraWorkspaces
     ])`removeKeys`     -- keys to remove  
     [ ]`additionalMouseBindings`  
     [ ]  
