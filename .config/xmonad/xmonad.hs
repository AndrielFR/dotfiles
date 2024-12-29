{- ORMOLU_DISABLE -}
-- Imports
import XMonad
import XMonad.StackSet (focusDown, focusUp, swapDown, swapUp, focusWindow, sink, shiftMaster, greedyView, shift, view, RationalRect (RationalRect), focusMaster)

-- Actions
import qualified XMonad.Actions.FlexibleResize as Flex
import XMonad.Actions.Commands (runCommand)
import XMonad.Actions.CopyWindow (kill1, copy)
import XMonad.Actions.CycleWS (toggleWS, prevWS, nextWS, moveTo, Direction1D (Prev, Next), ignoringWSs, prevScreen, nextScreen)
import XMonad.Actions.EasyMotion (selectWindow, EasyMotionConfig (txtCol, bgCol, overlayF, borderCol, borderPx, emFont), fixedSize)
import XMonad.Actions.RotSlaves (rotSlavesDown, rotAllDown)
import XMonad.Actions.TiledWindowDragging (dragWindow)
import XMonad.Actions.ToggleFullFloat (toggleFullFloatEwmhFullscreen, toggleFullFloat)
import XMonad.Actions.WindowBringer (gotoMenu, bringMenu)
import XMonad.Actions.WindowGo (runOrRaise)
import XMonad.Actions.WithAll (sinkAll)

-- Hooks
import XMonad.Hooks.EwmhDesktops (ewmh, ewmhFullscreen)
import XMonad.Hooks.InsertPosition (insertPosition, Position (Below), Focus (Newer))
import XMonad.Hooks.ManageDocks (manageDocks, checkDock, avoidStruts)
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat, isDialog, doLower, transience', doCenterFloat, doRectFloat)
import XMonad.Hooks.Modal (floatMode, modal, logMode, setMode, floatModeLabel)
import XMonad.Hooks.PositionStoreHooks (positionStoreManageHook, positionStoreEventHook)
import XMonad.Hooks.Rescreen (rescreenHook, RescreenConfig (afterRescreenHook, randrChangeHook))
import XMonad.Hooks.StatusBar (withSB, withEasySB, statusBarProp, defToggleStrutsKey)
import XMonad.Hooks.StatusBar.PP (PP (ppCurrent, ppOrder, ppSep, ppExtras, ppTitle, ppHidden, ppHiddenNoWindows, ppUrgent), wrap, shorten)

-- Layout
import XMonad.Layout.DraggingVisualizer (draggingVisualizer)
import XMonad.Layout.Dwindle (Direction2D(R), Dwindle(Dwindle), Chirality (CCW))
import XMonad.Layout.Renamed (renamed, Rename (Replace))
import XMonad.Layout.ResizableTile (ResizableTall(ResizableTall), MirrorResize (MirrorShrink, MirrorExpand))
import XMonad.Layout.ResizableThreeColumns (ResizableThreeCol(ResizableThreeColMid))
import XMonad.Layout.Fullscreen (fullscreenSupport)
import XMonad.Layout.FocusTracking (focusTracking)
import XMonad.Layout.HintedTile (HintedTile(nmaster, delta))
import XMonad.Layout.LayoutModifier (ModifiedLayout(ModifiedLayout))
import XMonad.Layout.MultiToggle (mkToggle, (??), EOT (EOT))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NOBORDERS, NBFULL))
import XMonad.Layout.NoBorders (lessBorders, Ambiguity (OnlyScreenFloat), smartBorders)
import XMonad.Layout.PositionStoreFloat (positionStoreFloat)
import XMonad.Layout.SubLayouts (subLayout)
import XMonad.Layout.Spacing (spacingRaw, Border (Border), setScreenWindowSpacing, incScreenSpacing, decScreenSpacing, incWindowSpacing, decWindowSpacing, spacingWithEdge, Spacing (Spacing))
import XMonad.Layout.Tabbed (tabbed, shrinkText, Theme (inactiveBorderColor, activeBorderColor, activeColor, activeBorderWidth, urgentBorderWidth, inactiveBorderWidth, inactiveColor, fontName, activeTextColor, inactiveTextColor, decoHeight, decoWidth), addTabs)
import XMonad.Layout.WindowNavigation (windowNavigation)

-- Util
import qualified XMonad.Util.Hacks as Hacks
import XMonad.Util.ActionCycle (cycleAction)
import XMonad.Util.Cursor (setDefaultCursor)
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.ClickableWorkspaces (clickablePP)
import XMonad.Util.NamedScratchpad (scratchpadWorkspaceTag)
import XMonad.Util.SpawnOnce (spawnOnce, manageSpawn)

-- Others
import qualified Data.Map as M
import Custom.MyTheme (base00, base01, base03, base07, base08, basebg, basefg, base0A, base0B, base0C)
import System.Exit (exitSuccess)
import Data.Maybe (mapMaybe)
{- ORMOLU_ENABLE -}

myMask :: KeyMask
myMask = mod4Mask

-- The preferred terminal program
myTerminal :: String
myTerminal = "alacritty msg create-window || alacritty"

-- Width of the window border in pixels
myBorderWidth :: Dimension
myBorderWidth = 2

-- Workspaces identifiers
myWorkspaces :: [WorkspaceId]
myWorkspaces = ["α", "β", "γ", "δ", "ε", "ϛ", "ζ", "η", "θ", "ι"] `surround` " "
  where
    surround l c = [c ++ x ++ c | x <- l]

-- Focused and unfocused window border color
myNormalBorderColor, myFocusedBorderColor :: String
myNormalBorderColor = base00
myFocusedBorderColor = base0B

-- Font for the most apps
myFont :: String
myFont = "xft:FantasqueSansM Nerd Font:size=10:style=regular:antialias=true:hinting=true"

-- Wheter focus follows the mouse pointer
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

-- Wheter clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- General gaps, in px
myGaps :: Num p => p
myGaps = 3

-- Scripts
myClipboardMenu, myPowerMenu, myScreenshotMenu, myMonitorLayoutMenu, myQuickScreenshotScript, myHotplugMonitorDaemon, myBatteryLowNotifyDaemon :: String
myClipboardMenu = "~/.scripts/clipboard_menu.sh"
myPowerMenu = "~/.scripts/power_menu.sh"
myScreenshotMenu = "~/.scripts/screenshot_menu.sh"
myMonitorLayoutMenu = "~/.scripts/monitor_layout_menu.sh"
myQuickScreenshotScript = "~/.scripts/quick_screenshot.sh"
myHotplugMonitorDaemon = "~/.scripts/hotplug_monitord.sh"
myBatteryLowNotifyDaemon = "~/.scripts/battery_low_notifyd.sh"

myTabConfig =
  def
    { activeColor = base08,
      activeTextColor = basefg,
      activeBorderColor = base08,
      activeBorderWidth = 2,
      inactiveColor = base00,
      inactiveTextColor = base07,
      inactiveBorderColor = basebg,
      inactiveBorderWidth = 2,
      urgentBorderWidth = 2,
      fontName = myFont
    }

myLayout = mkToggle (NOBORDERS ?? NBFULL ?? EOT) . avoidStruts . lessBorders OnlyScreenFloat $ focusTracking layouts
  where
    -- Default tiling algorithm
    layouts = dwindle ||| tiled ||| columned ||| monocle ||| tabbed' ||| floating

    -- Layouts
    dwindle = rn "Dwindle" $ spacing myGaps $ windowNavigation . draggingVisualizer $ Dwindle R CCW 1.5 1.1
    tiled = rn "Tiled" $ spacing myGaps $ windowNavigation . draggingVisualizer $ ResizableTall nmaster delta ratio []
    columned = rn "Columned" $ spacing myGaps $ windowNavigation . draggingVisualizer $ ResizableThreeColMid nmaster delta ratio []
    monocle = rn "Monocle" $ spacing myGaps Full
    tabbed' = rn "Tabbed" $ tabSpacing (myGaps + 5) $ tabbed shrinkText myTabConfig
    floating = rn "Floating" positionStoreFloat

    -- Simplify
    rn n = renamed [Replace n]

    -- Gaps
    spacing :: Integer -> l a -> ModifiedLayout Spacing l a
    spacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

    tabSpacing :: Integer -> l a -> ModifiedLayout Spacing l a
    tabSpacing i = spacingRaw False (Border i i i i) True (Border 0 0 0 0) True

    -- Default number of windows in the master pane
    nmaster = 1

    -- Percent of screen to increment by when resizing panes
    delta = 3 / 100

    -- Default proportion of screen occupied by master pane
    ratio = 1 / 2

myEMConf =
  def
    { txtCol = basefg,
      bgCol = basebg,
      overlayF = fixedSize 30 30,
      borderCol = basefg,
      borderPx = myGaps,
      emFont = myFont
    }

myCommands =
  pure
    [ ("next-layout", sendMessage NextLayout),
      ("default-layout", asks (layoutHook . config) >>= setLayout),
      ("restart-wm", restart "xmonad" True),
      ("sink-all", sinkAll),
      ("kill", kill),
      ("kill1", kill1),
      ("refresh", refresh)
    ]

data Description = Desc String | Nil

data Keys a = Key (String, a, Description) | Title String

{- ORMOLU_DISABLE -}
myAddKeys' =
  [ Title "Misc",
    Key ("M-<Return>", spawn myTerminal, Desc "Spawn a new terminal"),
    Key ("M-p", spawn "rofi -show drun", Desc "Open the application launcher"),
    Key ("M-S-p", spawn "rofi -show run", Desc "Open the command runner"),
    Key ("M-q", kill1, Desc "Close the focused window"),
    Key ("M-S-q", io exitSuccess, Desc "Quit Xmonad"),
    Key ("M-S-r", spawn "xmonad --recompile && xmonad --restart", Desc "Recompile and restart Xmonad"),

    Title "Resizing the master/slave ratio",
    Key ("M-<Down>", sendMessage MirrorShrink, Desc "Shrink the focused window vertically"),
    Key ("M-<Up>", sendMessage MirrorExpand, Desc "Expand the focused window vertically"),
    Key ("M-<Left>", sendMessage Shrink, Desc "Shrink the focused window horizontally"),
    Key ("M-<Right>", sendMessage Expand, Desc "Expand the focused window horizontally"),

    Title "Resizing the master/slave ratio",
    Key ("M-h", sendMessage Shrink, Desc "Shrink the focused window"),
    Key ("M-l", sendMessage Expand, Desc "Expand the focused window"),

    Title "Move focus up or down the window stack",
    Key ("M-j", windows focusDown, Desc "Focus the previous window in the stack"),
    Key ("M-k", windows focusUp, Desc "Focus the next window in the stack"),
    Key ("M-m", windows focusMaster, Desc "Focus the master window in the stack"),

    Title "Modifying the window order",
    Key ("M-S-j", windows swapDown, Desc "Swap the focused window with the previous window in the stack"),
    Key ("M-S-k", windows swapUp, Desc "Swap the focused window with the next window in the stack"),
    Key ("M-S-m", windows shiftMaster, Desc "Swap the focused window with the master window in the stack"),

    Title "Cycle the window order",
    Key ("M-S-<Tab>", rotSlavesDown, Desc "Move all windows except master to the next spot"),
    Key ("M-C-<Tab>", rotAllDown, Desc "Move all windows to the next spot"),

    Title "Commands",
    Key ("M-x x", myCommands >>= runCommand, Desc "Run a custom command"),

    Title "Window Finder",
    Key ("M-x g", gotoMenu, Desc "Go to a window by name"),
    Key ("M-x b", bringMenu, Desc "Bring a window to the current workspace by name"),

    Title "CycleWS",
    Key ("M-<Tab>", toggleWS, Desc "Toggle between visible workspaces"),
    Key ("M-S-,", prevWS, Desc "Switch to the previous workspace"),
    Key ("M-S-.", nextWS, Desc "Switch to the next workspace"),

    Title "Switch monitors",
    Key ("M-,", prevScreen, Desc "Switch to the previous monitor"),
    Key ("M-.", nextScreen, Desc "Switch to the next monitor"),

    Title "Lock screen",
    Key ("M-S-l", spawn "betterlockscreen -l dimblur -- --composite", Desc "Lock the screen"),

    Title "Layouts",
    Key ("M-S-<Space>", sendMessage NextLayout, Desc "Rotate through the available layout algorithms"),

    Title "Easy Motion",
    Key ("M-\\", selectWindow myEMConf >>= (`whenJust` windows . focusWindow), Desc "Select a window using Easy Motion"),

    Title "Modal",
    Key ("M1-S-f", setMode floatModeLabel, Desc "Enter float mode"),

    Title "Toggle Polybar",
    Key ("M-C-S-b", cycleAction "togglePolybar" [spawn "notify-send 'Polybar: OFF' && pkill polybar", spawn "notify-send 'Polybar: ON' && polybar -r arch"], Desc "Toggle Polybar"),

    Title "Toggle Picom",
    Key ("M-C-S-p", cycleAction "togglePicom" [spawn "notify-send 'Picom: OFF' && pkill picom", spawn "notify-send 'Picom: ON' && picom"], Desc "Toggle Picom compositing"),

    Title "Increase or decrease number of windows in the master area",
    Key ("M-i", sendMessage $ IncMasterN 1, Desc "Increase the number of windows in the master area"),
    Key ("M-d", sendMessage $ IncMasterN $ -1, Desc "Decrease the number of windows in the master area"),

    Title "Push window back into tiling",
    Key ("M-<Space>", withFocused $ windows . sink, Desc "Push the focused window back into tiling"),
    Key ("M-S-C-<Space>", sinkAll, Desc "Push all windows back into tiling"),

    Title "Toggle full float",
    Key ("M-S-f", withFocused toggleFullFloat, Desc "Toggle full float for the focused window"),

    Title "Spacing",
    Key ("M-C-S-r", setScreenWindowSpacing myGaps, Desc "Set the window spacing for the current screen"),
    Key ("M-C-S-k", incScreenSpacing myGaps, Desc "Increase the window spacing for the current screen"),
    Key ("M-C-S-j", decScreenSpacing myGaps, Desc "Decrease the window spacing for the current screen"),
    Key ("M-C-S-l", incWindowSpacing myGaps, Desc "Increase the window spacing"),
    Key ("M-C-S-h", decWindowSpacing myGaps, Desc "Decrease the window spacing"),

    Title "Media Keys",
    Key ("<XF86AudioMute>", spawn "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle", Desc "Toggle mute"),
    Key ("<XF86AudioLowerVolume>", spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-", Desc "Decrease the volume"),
    Key ("<XF86AudioRaiseVolume>", spawn "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 2%+", Desc "Increase the volume"),
    Key ("<XF86AudioMicMute>", cycleAction "toggleMic" [spawn "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 1 && dunstify -t 1900 -u critical -r 10020 -i mic-off 'Microphone' 'Muted'", spawn "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 0 && dunstify -t 1900 -u critical -r 10020 -i mic-ready 'Microphone' 'Ready'"], Desc "Toggle mic mute"),
    Key ("<XF86AudioPlay>", spawn "playerctl play-pause", Desc "Play/Pause media"),
    Key ("<XF86AudioStop>", spawn "playerctl stop", Desc "Stop media"),
    Key ("<XF86AudioPrev>", spawn "playerctl previous", Desc "Play the previous track"),
    Key ("<XF86AudioNext>", spawn "playerctl next", Desc "Play the next track"),

    Title "Brightness Keys",
    Key ("<XF86MonBrightnessDown>", spawn "brightnessctl set 5%- && brightnessctl -s && ~/.scripts/brightness_notify.sh", Desc "Decrease the main monitor brightness"),
    Key ("<XF86MonBrightnessUp>", spawn "brightnessctl set 5%+ && brightnessctl -s && ~/.scripts/brightness_notify.sh", Desc "Increase the main monitor brightness"),
    Key ("M-<XF86MonBrightnessDown>", spawn "ddcutil setvcp 10 - 20", Desc "Decrease the second monitor brightness"),
    Key ("M-<XF86MonBrightnessUp>", spawn "ddcutil setvcp 10 + 20", Desc "Increase the second monitor brightness"),

    Title "Other Special Keys",
    Key ("<XF86ScreenSaver>", spawn "betterlockscreen -l dimblur -- --composite", Desc "Lock the screen"),
    Key ("<XF86Calculator>", runOrRaise "galculator" (className =? "Galculator"), Desc "Open the calculator"),
    -- XF86Favorites is not working, so use another key
    Key ("M-c", spawn myClipboardMenu, Desc "Open the clipboard menu"),
    -- XF86Favorites is not working, so use another key
    Key ("M-e", spawn "rofi -modi emoji -show emoji", Desc "Open the emoji picker"),
    Key ("<Print>", spawn myScreenshotMenu, Desc "Open the screenshot menu"),
    Key ("M-<Print>", spawn myQuickScreenshotScript, Desc "Take a quick screenshot"),
    Key ("<XF86PowerOff>", spawn myPowerMenu, Desc "Open the power menu"),
    Key ("M-C-p", spawn myMonitorLayoutMenu, Desc "Open the monitor layout menu"),

    Key ("M-x h", xmessage help, Desc "Display help")
  ]
{- ORMOLU_ENABLE -}

myAddKeys = mapMaybe getKeyAndFn myAddKeys'
  where
    getKeyAndFn (Key (x, y, _)) = Just (x, y)
    getKeyAndFn (Title _) = Nothing

help = unlines $ map addPadding listRaw
  where
    getKeyAndDesc (Key (x, _, Desc y)) = [x, y]
    getKeyAndDesc (Key (x, _, Nil)) = [x]
    getKeyAndDesc (Title x) = ["\n" ++ x]

    keyLength [x] = length x
    keyLength [x, _] = length x
    largestKeySize = maximum $ map keyLength listRaw

    addPadding [x] = x
    addPadding [x, y] = x ++ concat (replicate (1 + largestKeySize - length x) " ") ++ y

    listRaw = map getKeyAndDesc myAddKeys'

myKeys (XConfig {modMask = modMask, workspaces = workspaces, layoutHook = layoutHook}) =
  M.fromList $
    [ ((m .|. modMask, k), windows $ f i)
      | (i, k) <- zip workspaces workspaceKeys,
        (f, m) <- [(greedyView, 0), (shift, shiftMask)]
    ]
      ++ [ ((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
           | (key, sc) <- zip [xK_w, xK_e, xK_r] [0 ..],
             (f, m) <- [(view, 0), (shift, shiftMask)]
         ]
      ++ [ ((m .|. modMask, k), windows $ f i)
           | (i, k) <- zip workspaces workspaceKeys,
             (f, m) <- [(view, 0), (shift, shiftMask), (copy, shiftMask .|. controlMask)]
         ]
  where
    workspaceKeys = [xK_1 .. xK_9] ++ [xK_0]

myMouseBindings (XConfig {modMask = modMask}) =
  M.fromList
    -- Drag windows
    [ ((modMask .|. shiftMask, button1), dragWindow),
      -- Set the window to floating mode and move by dragging
      ((modMask, button1), \w -> focus w >> mouseMoveWindow w >> windows shiftMaster),
      -- Raise the window to the top of the stack
      ((modMask, button2), windows . (shiftMaster .) . focusWindow),
      -- Set the window to floating mode and resize by dragging
      ((modMask, button3), \w -> focus w >> Flex.mouseResizeWindow w >> windows shiftMaster),
      -- Switch workspace by scrolling the mouse wheel
      ((modMask, button4), \w -> focus w >> moveTo Prev nonNSP),
      ((modMask, button5), \w -> focus w >> moveTo Next nonNSP)
    ]
  where
    nonNSP = ignoringWSs [scratchpadWorkspaceTag]

myManageHook :: ManageHook
myManageHook =
  positionStoreManageHook Nothing
    <> manageDocks
    <> composeAll
      [ myManageHook',
        transience'
      ]
    <+> manageHook def
    <+> manageSpawn
    <+> (isDialog --> doCenterFloat) -- Open center floating if is dialog
    <+> (isFullscreen --> doFullFloat) -- Open full if is fullscreen
    <+> (fmap not willFloat --> insertPosition Below Newer) -- Open at the end if not floating

myManageHook' :: ManageHook
myManageHook' =
  composeAll
    . concat
    $ [ [className =? cf --> doCenterFloat | cf <- myCenterFloats],
        [title =? tcf --> doFloat | tcf <- myCenterFloats'],
        [className =? f --> doFloat | f <- myFloats],
        [title =? tf --> doFloat | tf <- myFloats'],
        [className =? s --> doShift (myWorkspaces !! ws) | (s, ws) <- myShifts],
        [resource =? i --> doIgnore | i <- myIgnores]
      ]
  where
    myCenterFloats =
      [ "imv",
        "obs",
        "feh",
        "mpv",
        "yad",
        "qt6ct",
        "Thunar",
        "confirm",
        "PollyMC",
        "Zathura",
        "caffeine",
        "Minecraft",
        "Galculator",
        "kdeconnect",
        "easyeffects",
        "pavucontrol",
        "Blueman-manager",
        "mcpelauncher-ui-qt",
        "xdg-desktop-portal-gtk"
      ]
    myCenterFloats' =
      [ "OBS*",
        "heroic",
        "nwg-look",
        "Minecraft",
        "*launcher*",
        "*Launcher*",
        "Preferences*"
      ]
    myFloats =
      [ "file_progress"
      ]
    myFloats' =
      [ "Picture-in-Picture"
      ]
    myShifts =
      [ ("firefox", 1),
        ("heroic", 2),
        ("PollyMC", 2),
        ("Minecraft", 2)
      ]
    myIgnores =
      [ "kdesktop",
        "desktop_window"
      ]

myHandleEventHook =
  positionStoreEventHook
    <> Hacks.windowedFullscreenFixEventHook

myPolybarPP :: PP
myPolybarPP =
  def
    { ppSep = color base0A " | ", -- Separator character
      ppCurrent = color base03 . wrap " " "", -- Current workspace
      ppTitle = shorten 60, -- Title of active window
      ppHidden = color base08 . wrap " " "", -- Inactive workspace
      ppHiddenNoWindows = color base01 . wrap " " "", -- Inactive workspace (no windows)
      ppUrgent = color base08 . wrap "!" "!", -- Urgent workspace
      ppOrder = \(ws : l : x : xs) -> [ws, l] ++ xs ++ [x], -- Order of things
      ppExtras = [logMode]
    }
  where
    color :: String -> String -> String
    color c = wrap ("%{F" <> c <> "}") " ${F-}"

myStartupHook :: X ()
myStartupHook = do
  -- Screen locker
  spawnOnce "xset dpms 0 180 120"
  spawnOnce "xss-lock --transfer-sleep-lock -- betterlockscreen -l dimblur -- --composite"

  -- Brightness
  spawnOnce "brightnessctl -r"

  -- Multi-monitor brightness
  spawnOnce "ddcutil detect"

  -- Background
  spawnOnce "feh --bg-fill --randomize /usr/share/backgrounds/*"
  spawnOnce "betterlockscreen -u /usr/share/backgrounds/"

  -- Daemons / Applet
  spawnOnce "pipewire" -- Audio server
  spawnOnce "dunst" -- Notifications
  spawnOnce "easyeffects --gapplication-service" -- Audio effects
  spawnOnce "greenclip daemon" -- Clipboard manager
  spawnOnce "udiskie --tray" -- Removable devices
  spawnOnce "nm-applet --sm-disable --indicator" -- Network manager
  spawnOnce "blueman-applet" -- Bluetooth manager
  spawnOnce "redshift-gtk" -- Night light
  spawnOnce "kdeconnectd" -- KDE Connect Daemon
  spawnOnce "caffeine" -- Prevent screen from turning off when detect media
  spawnOnce myHotplugMonitorDaemon -- Hotplug monitor
  spawnOnce myBatteryLowNotifyDaemon -- Battery low noitifier

  -- Compositor
  spawnOnce "picom --config ~/.config/picom/picom.conf"

  -- Keyboard repeat rate
  spawn "xset r rate 320 50"

myConfig =
  def
    { keys = myKeys,
      modMask = myMask,
      terminal = myTerminal,
      manageHook = myManageHook,
      layoutHook = smartBorders myLayout,
      workspaces = myWorkspaces,
      borderWidth = myBorderWidth,
      startupHook = myStartupHook,
      mouseBindings = myMouseBindings,
      handleEventHook = myHandleEventHook,
      clickJustFocuses = myClickJustFocuses,
      focusFollowsMouse = myFocusFollowsMouse,
      normalBorderColor = myNormalBorderColor,
      focusedBorderColor = myFocusedBorderColor
    }
    `additionalKeysP` myAddKeys

main :: IO ()
main =
  xmonad
    . Hacks.javaHack
    . fullscreenSupport
    . toggleFullFloatEwmhFullscreen
    . ewmhFullscreen
    . ewmh
    . modal [floatMode 10]
    . withEasySB (statusBarProp "polybar" $ clickablePP myPolybarPP) defToggleStrutsKey
    $ myConfig
