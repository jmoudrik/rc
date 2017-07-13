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

--import XMonad.Layout.IM  
--import XMonad.Layout.Grid  
import XMonad.Layout.Tabbed
import XMonad.Layout.SimpleFloat
import XMonad.Actions.CycleWS

--import XMonad.Actions.GridSelect  
import Data.Ratio ((%))  
import XMonad.Actions.CycleWS  
import qualified XMonad.StackSet as W  
import System.IO  

myExtraWorkspaces = [(xK_0, "0"),(xK_minus, "-"),(xK_equal, "=")]
myWorkspaces  = ["1:www","2","3","4","5","6","7","8","9:htop"]  ++ (map snd myExtraWorkspaces)

myLayout = onWorkspaces ["9:htop"] nobordersLayout $ tiled1 ||| Mirror tiled1 ||| nobordersLayout ||| tabbedLayout ||| simpleFloat
--myLayout = onWorkspaces ["9:htop"] nobordersLayout $ onWorkspaces ["1:www"] tabbedLayout $ tiled1 ||| Mirror tiled1 ||| nobordersLayout ||| tabbedLayout ||| simpleFloat
 where  
  tiled1 = spacing 2 $ smartBorders $ Tall nmaster1 delta ratio  
  --tiled2 = spacing 5 $ Tall nmaster2 delta ratio  
  nmaster1 = 1  
  nmaster2 = 2  
  ratio = 2/3  
  delta = 3/100  
  nobordersLayout = smartBorders $ Full  
  tabbedLayout = smartBorders $ simpleTabbed 
  -- gridLayout = spacing 8 $ Grid
  -- gimpLayout = withIM (0.20) (Role "gimp-toolbox") $ reflectHoriz $ withIM (0.20) (Role "gimp-dock") Full  
  -- pidginLayout = withIM (18/100) (Role "buddy_list") gridLayout

myManageHook = composeAll       
     [
	 --className =? "File Operation Progress"   --> doFloat  
     --, resource =? "desktop_window" --> doIgnore  
     --, className =? "xfce4-notifyd" --> doIgnore  

	 isFullscreen --> doFullFloat
     , title =? "htopterm" --> doShift "9:htop"  
     ]
main = do  
  xmproc <- spawnPipe "/usr/bin/xmobar /home/jm/.xmonad/xmobarrc.hs"  
  --xmproc <- spawnPipe "/usr/bin/xmobar /home/jm/.xmonad/xmobarrc2.hs"  
  --spawn "xcompmgr -Cf"  
  xmonad $ defaultConfig
    {
  	modMask = mod3Mask
	, manageHook = manageDocks <+> myManageHook <+> manageHook defaultConfig  
    --, layoutHook = avoidStrutsOn [U] $ myLayoutTab
    , layoutHook = avoidStrutsOn [U] $ myLayout
    , logHook = dynamicLogWithPP xmobarPP  
            { ppOutput = hPutStrLn xmproc  
            , ppTitle = xmobarColor "#2CE3FF" "" . shorten 70  
               , ppLayout = const "" -- to disable the layout info on xmobar  
            }  
    , startupHook = setWMName "LG3D"
    --, modMask = mod4Mask  
     , workspaces     = myWorkspaces  
    --, normalBorderColor = "#60A1AD"  
    --, focusedBorderColor = "#68e862"  
     , borderWidth    = 2
    }`additionalKeys`  
     ([
	 ((mod3Mask, xK_p), (spawn "dmenu_run -l 10 -sf yellow -nb black -fn terminus-12"))
     , ((mod4Mask, xK_t), spawn "term")
     , ((mod4Mask, xK_c), spawn "google-chrome")
     , ((mod4Mask, xK_i), spawn "google-chrome --incognito")
     , ((mod4Mask, xK_l), spawn "xlinks2")
     , ((mod4Mask, xK_d), spawn "dillo")
     , ((mod3Mask, xK_c), kill)
     , ((0, xF86XK_AudioLowerVolume), spawn "amixer set Master 3%-")
     , ((0, xF86XK_AudioRaiseVolume), spawn "amixer set Master 3%+")
     , ((0, xF86XK_AudioMute), spawn "audio_toggle")

     -- xF86XK_AudioMicMute to neumi...
     , ((0, 0x1008ffb2), spawn "amixer set Capture toggle")

     , ((0, xF86XK_Sleep), spawn "sleep_n_lock")
     , ((0, xF86XK_ScreenSaver), spawn "xscreensaver-command -lock")

     -- (keysym 0x1008ffa9, XF86TouchpadToggle) 
     -- xF86XK_TouchpadToggle to neumi...
     , ((0, 0x1008ffa9), spawn "touchpad_toggle")

     --, ((mod4Mask, xK_a ), windows W.swapUp) -- swap up window  
     --, ((mod4Mask, xK_z ), windows W.swapDown) -- swap down window  
     , ((mod3Mask, xK_KP_Add ), sendMessage (IncMasterN 1)) -- increase the number of window on master pane  
     , ((mod3Mask, xK_KP_Subtract ), sendMessage (IncMasterN (-1))) -- decrease the number of window  
     --, ((controlMask,        xK_Right   ), sendMessage Expand) -- expand master pane  
     --, ((controlMask,        xK_Left   ), sendMessage Shrink) -- shrink master pane  
    , ((0, xK_Print), spawn "scrot") -- capture screenshot of full desktop  

	--, ((mod3Mask, xK_g     ), gotoMenu)
	--, ((mod3Mask, xK_b     ), bringMenu)
	, ((mod1Mask, xK_Tab), windows W.focusDown)
	] ++ [
	{-
     (mod3Mask, k), windows $ W.shift i)
	   | (i, k) <- zip myWorkspaces [xK_1 .. xK_8]
	] ++ [
	((mod3Mask, k), windows $ W.greedyView i)
	   | (i, k) <- zip myWorkspaces [xK_F1 .. xK_F8]
	-}
	] ++ [
        ((mod3Mask, key), (windows $ W.greedyView ws))
        | (key,ws) <- myExtraWorkspaces
      ] ++ [
        ((mod3Mask .|. shiftMask, key), (windows $ W.shift ws))
        | (key,ws) <- myExtraWorkspaces
     ])`removeKeys`     -- keys to remove  
     [
	 -- pepa smazal
	 -- (mod3Mask .|. shiftMask, xK_c)  
     --, (mod3Mask .|. shiftMask, xK_Return)  
	 --
     --, (mod3Mask .|. shiftMask, xK_j)  
     --, (mod3Mask, xK_j)  
     --, (mod3Mask, xK_comma)  
     --, (mod3Mask, xK_period)  
     ]`additionalMouseBindings`  
     [--((mod4Mask, button4),\_-> nextWS)  
     --,((mod4Mask, button5),\_-> prevWS)  
     --((mod4Mask, button4),\_-> spawn "amixer set Master 3%+")  
     --,((mod4Mask, button5),\_-> spawn "amixer set Master 3%-")  
	 -- return znamena 'does nothing'
     --,((mod4Mask, button3),\_-> return())  
     --,((mod4Mask, button1),\_-> return())  
     ]  
