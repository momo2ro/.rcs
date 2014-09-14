import System.IO
import XMonad
import Data.Monoid
import System.Exit
import XMonad.Hooks.DynamicLog --xmobarにステータスを送信
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run                  -- spawnPipe, hPutStrLn
import XMonad.Layout.Maximize
import XMonad.Layout.Minimize
import XMonad.Layout.NoBorders
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
--
myTerminal      = "urxvtc"
myBorderWidth   = 2
myModMask       = mod3Mask
myNumlockMask   = mod2Mask
myWorkspaces    = ["1","2","3","4","5"]
myNormalBorderColor  = "#dddddd"
myFocusedBorderColor = "#005d80"

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
    , ((modm .|. shiftMask, xK_colon ), spawn $ XMonad.terminal conf)
    , ((modm,               xK_p     ), spawn "exe=`dmenu_path | dmenu -b -fn xft:Ricty:pixelsize=18 -nb black -nf white -sb red -sf black` && eval \"exec $exe\"")
    , ((modm .|. shiftMask, xK_p     ), spawn "gmrun")
    , ((modm,               xK_f     ), spawn "firefox")
    , ((modm .|. shiftMask, xK_m     ), spawn "mikutter")
    , ((modm,               xK_s     ), spawn "mtpaint -s")
    , ((modm,               xK_d     ), kill)
    , ((modm,               xK_space ), sendMessage NextLayout)
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    , ((modm,               xK_n     ), refresh)
    , ((modm,               xK_j     ), windows W.focusDown)
    , ((modm,               xK_k     ), windows W.focusUp  )
    , ((modm,               xK_m     ), windows W.focusMaster  )
    , ((modm,               xK_Return), windows W.swapMaster)
    , ((modm,               xK_colon ), windows W.swapMaster)
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )
    , ((modm,               xK_h     ), sendMessage Shrink)
    , ((modm,               xK_l     ), sendMessage Expand)
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")
    ]
    ++

    --
    -- mod-[1..3], Switch to workspace N
    -- mod-shift-[1..3], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_3]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


myLayout = (smartBorders $ avoidStruts $ maximize $ minimize (tiled ||| Mirror tiled)) ||| (noBorders Full)
  where
     tiled   = Tall nmaster delta ratio
     nmaster = 1
     ratio   = 1/2
     delta   = 3/100

myManageHook = manageDocks <+> composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]

myLogHook h = dynamicLogWithPP $ xmobarPP {
                  ppOutput = hPutStrLn h,
                  ppTitle = xmobarColor "green" "" . shorten 50
                  }

main = do
xmproc <- spawnPipe "xmobar"
-- spawn "trayer --edge top --align right --SetDockType true --SetPartialStrut false --expand true --width 15 --transparent true --tint 0x000000 --height 19"
spawn "stalonetray --slot-size 15 --geometry 6x1-0+0 -bg \"#000000\" -i 16 --grow-gravity SW --icon-gravity SE"
spawn "nm-applet"
spawn "gnome-autosetting-daemon"
spawn "gnome-power-manager"
spawn "gnome-sound-properties"
spawn "urxvtd -q -f -o"
spawn "dropboxd"
spawn "skype"
spawn "blueman-applet"

xmonad defaultConfig {
      -- simple stuff
        terminal           = myTerminal,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
      --numlockMask        = myNumlockMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        logHook            = myLogHook xmproc
    }
