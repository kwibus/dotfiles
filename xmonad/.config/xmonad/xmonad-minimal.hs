{-# LANGUAGE TypeSynonymInstances, DeriveDataTypeable, MultiParamTypeClasses #-}

import System.Exit
import qualified Data.Map        as M
import Data.Monoid
-- import System.Process
-- import Data.List
-- import Data.Monoid
-- import System.IO

import XMonad hiding ( (|||) )
import qualified XMonad.StackSet as W
import XMonad.Config.Desktop
-- import XMonad.Prompt
-- import XMonad.Prompt.XMonad

import XMonad.Actions.WindowGo
import XMonad.Layout.LayoutCombinators
import XMonad.Layout.Maximize
import XMonad.Layout.Minimize
import XMonad.Layout.Tabbed
-- import XMonad.Layout.TabBarDecoration
import XMonad.Layout.LayoutModifier
import XMonad.Layout.PositionStoreFloat
-- import XMonad.Layout.TwoPane
import XMonad.Layout.Named
import XMonad.Layout.ButtonDecoration
import XMonad.Layout.MultiToggle as MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.BorderResize
import XMonad.Layout.BoringWindows
-- import XMonad.Layout.DwmStyle
import XMonad.Layout.Simplest
import XMonad.Layout.ImageButtonDecoration
import XMonad.Layout.WindowSwitcherDecoration
import XMonad.Layout.DraggingVisualizer
import XMonad.Layout.MouseResizableTile
import XMonad.Layout.ToggleLayouts as ToggleLayouts
import XMonad.Layout.NoBorders
import XMonad.Layout.WindowNavigation
-- import XMonad.Layout.Combo
-- import XMonad.Layout.TrackFloating
-- import XMonad.Layout.MagicFocus
-- import XMonad.Layout.LayoutHints
-- import XMonad.Layout.SimpleFloat
-- import XMonad.Layout.Accordion
-- import XMonad.Layout.Spiral
-- import XMonad.Layout.SimplestFloat
-- import XMonad.Layout.ShowWName
-- import XMonad.Layout.Roledex
-- import XMonad.Layout.WindowArranger
-- import XMonad.Layout.SimpleDecoration
-- import XMonad.Layout.DecorationAddons
-- import XMonad.Layout.BorderResize
-- import XMonad.Layout.Maximize

import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.PositionStoreHooks
import XMonad.Hooks.Minimize
-- import XMonad.Hooks.RestoreMinimized
-- import XMonad.Hooks.PositionStoreHooks
-- import XMonad.Hooks.DynamicLog
-- import XMonad.Hooks.CurrentWorkspaceOnTop

-- import XMonad.Actions.SimpleDate
import XMonad.Actions.DwmPromote
import XMonad.Actions.WindowMenu
import XMonad.Actions.DynamicWorkspaces
-- import XMonad.Actions.CopyWindow(copy)
-- import XMonad.Actions.MouseResize
-- import XMonad.Actions.UpdatePointer

-- import XMonad.Util.EZConfig (additionalKeys)
-- import XMonad.Util.Dzen as D
-- import XMonad.Util.Run (spawnPipe)

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
myTerminal :: String
myTerminal = "urxvtc -e sh  -c \"sleep 1 && tmx.sh base\""

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
myBorderWidth :: Dimension
myBorderWidth = 1

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
myModMask :: KeyMask
myModMask = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces :: [String]
myWorkspaces = ["1"]-- ["1","2","3","4","5","6","7","8","9"]

-- Border colors for unfocused and focused windows, respectively.
myNormalBorderColor :: String
myNormalBorderColor = "#000000"

myFocusedBorderColor :: String
myFocusedBorderColor = "#50586E"--"#ff0000"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@XConfig {XMonad.modMask = modm}= M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), raiseNextMaybe ( spawn (XMonad.terminal conf)) (className =? "URxvt"))

    -- launch dmenu
    -- , ((modm,               xK_p     ), spawn "dmenu-frecency")

    -- launch gmrun
    , ((modm .|. shiftMask, xK_p     ), spawn "gmrun")

    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), dwmpromote ) -- werkt mogelijk niet goed met boring windows

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )


    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

  -- , ((mod1Mask .|. controlMask, xK_Left), prevWS)
   -- , ((mod1Mask .|. controlMask, xK_Right), nextWS)
    --, ((mod1Mask .|. controlMask .|. shiftMask,   xK_Left), shiftToPrev >> prevWS)
   -- , ((mod1Mask .|. controlMask .|. shiftMask,   xK_Right), shiftToNext >> nextWS)

    , ((modm,               xK_u     ), sendMessage ShrinkSlave) -- %! Shrink a slave area
    , ((modm,               xK_i     ), sendMessage ExpandSlave) -- %! Expand a slave area

    , ((modm .|. controlMask, xK_space), sendMessage NextLayout)

    , ((modm,                 xK_Right), sendMessage $ Go R)
    , ((modm,                 xK_Left ), sendMessage $ Go L)
    , ((modm,                 xK_Up   ), sendMessage $ Go U)
    , ((modm,                 xK_Down ), sendMessage $ Go D)
    , ((modm .|. controlMask, xK_Right), sendMessage $ Swap R)
    , ((modm .|. controlMask, xK_Left ), sendMessage $ Swap L)
    , ((modm .|. controlMask, xK_Up   ), sendMessage $ Swap U)
    , ((modm .|. controlMask, xK_Down ), sendMessage $ Swap D)


    , ((modm,               xK_m     ), withFocused minimizeWindow)
    , ((modm .|. shiftMask, xK_m     ), sendMessage RestoreNextMinimizedWin)
    -- , ((modm,               xK_d     ), date)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)
    , ((modm .|. shiftMask, xK_t     ), withFocused  float ) -- %! Float window

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
     , ((modm              , xK_b     ), sendMessage ToggleStruts)
    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io exitSuccess) --callCommand"close-windows.sh") >>



    , ((modm,               xK_x     ), sendMessage $ MultiToggle.Toggle NODECO)
    -- Restart xmonad
    , ((modm              , xK_q     ),  spawn "xmonad --recompile && xmonad --restart")

    , ((modm,               xK_o ), windowMenu)
       , ((modm .|. shiftMask, xK_BackSpace), removeWorkspace)
    , ((modm .|. shiftMask, xK_v      ), selectWorkspace def)
    -- , ((modm, xK_m                    ), withWorkspace def(windows . W.shift))
    -- , ((modm .|. shiftMask, xK_m      ), withWorkspace def(windows . copy))
    , ((modm .|. shiftMask, xK_r      ), renameWorkspace def)

   , ((modm , xK_F11), sendMessage $ MultiToggle.Toggle NBFULL)  -- jump directly to the Full layout
   , ((modm , xK_f), sendMessage $ ToggleLayouts.Toggle "Full" )  -- jump directly to the Full layout

   , ((modm , xK_g), sendMessage $ JumpToLayout "Float")  -- jump directly to the Full layout

    -- , ((modm .|. controlMask, xK_x), xmonadPrompt def)
    ]

    ++
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    [((modm,key),action)| (key,action)<- zip [xK_1..xK_9] (map (\n-> removeEmptyWorkspace >> addWorkspace ( show n)) [(1::Int)..])]
    ++
    [((modm .|. shiftMask,key),action)| (key,action)<- zip [xK_1..xK_9] (map ((\n-> addHiddenWorkspace n >> windows (W.shift n)).show) [(1::Int)..])]
    ++
    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events

myMouseBindings :: XConfig l -> M.Map (KeyMask,Button) (Window -> X())
myMouseBindings XConfig {XMonad.modMask = modm} = M.fromList

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), \w -> focus w >> mouseMoveWindow w {->> sendMessage ( JumpToLayout "Float")-}>> windows W.shiftMaster)

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), \w -> focus w >> windows W.shiftMaster)

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), \w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster)--Todo add FlexibleRisize

    , ((modm , button4), const (windows W.focusDown))

    -- Swap the focused window with the previous window
    , ((modm , button5), const (windows W.focusUp) )
    --, ((modMask                 , button5),  windows W.swapDown)
--    , ((modMask                 , button4),  windows W.swapUp  )
 --   ,((button1Mask, button4), const (windows W.focusUp))
--    ,((button1Mask, button5), const (windows W.focusDown))
    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.


data NODECO = NODECO deriving (Read, Show, Eq, Typeable)
instance Transformer NODECO  Window where
     transform _ x k = k ( modifyer x ) (\(ModifiedLayout _ x') -> x' )
      where modifyer = windowSwitcherDecorationWithImageButtons shrinkText myThemeWithImageButtons

myThemeWithImageButtons :: Theme
myThemeWithImageButtons = defaultThemeWithImageButtons {activeColor ="#2F343F",inactiveColor = "#2F343F",activeBorderColor ="#262932",inactiveBorderColor ="#262932"}

myLayout =  windowNavigation $
    -- dwmStyle shrinkText myThemeWithImageButtons $-}{-layoutHintsToCenter -}{-$mouseResize $ windowArrange $
    boringAuto $
    -- borderResize
    avoidStruts $
    minimize $
    draggingVisualizer $
    -- toggleLayouts Full$

    MultiToggle.mkToggle (MultiToggle.single NBFULL) $
    -- mouseResize windowArrange borderResize
                        -- named "Accordion" Accordion|||
                        -- named "Rolex" Roledex |||
                        -- named "Simplest"  Simplest |||
                        -- named "simpelFloat" simpleFloat|||
                        -- named  "simpelFloat" simplestFloat|||
                        -- named "spiral"(spiral (6/7)) |||
                        -- named "Tab" simpleTabbed|||

                        -- Simplest *|* Simplest |||
                        -- combineTwo (TwoPane 0.03 0.5) simpleTabbed simpleTabbed |||
                        MultiToggle.mkToggle (MultiToggle.single NODECO)(

                            named "Fullscreen" (noBorders Simplest) |||
                            tiled1 |||
                            tiled2
                        ) ||| named "Float" floating

        where
            floating       = floatingDeco $ maximize $ borderResize positionStoreFloat --TODO dubelen decoratie
            tiled1         = smartBorders $ maximize mouseResizableTileMirrored -- TODO is maximized echt nodig
            tiled2         = smartBorders $ maximize mouseResizableTile
            -- fullscreen     = maximize Full
            -- tilingDeco l   = windowSwitcherDecorationWithImageButtons shrinkText defaultThemeWithImageButtons l
            floatingDeco = buttonDeco shrinkText myThemeWithImageButtons

----------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
myManageHook :: ManageHook
myManageHook =   composeAll
    [ className =? "MPlayer"        --> doFloat
    -- , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    ]


------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook :: Monoid m => m
myLogHook = mempty {-currentWorkspaceOnTop >> updatePointer Nearest -}-- crash allot

------------------------------------------------------------------------
-- Startup hook
--
-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
myStartupHook ::Monad m => m ()
myStartupHook = return ()

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.

myHandleEventHook :: Event -> X All
myHandleEventHook = positionStoreEventHook <+> fullscreenEventHook <+> minimizeEventHook  <+> docksEventHook-- <+>  notFocusFloat
    -- where
    -- notFocusFloat = followOnlyIf (fmap not isFloat) where --Do not focusFollowMouse on Float layout
    --         isFloat = fmap (isSuffixOf "float") $ gets (description . W.layout . W.workspace . W.current . windowset)

main :: IO ()
main = xmonad $ ewmh  settings

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
settings = def{
    terminal           = myTerminal,
    focusFollowsMouse  = myFocusFollowsMouse,
    clickJustFocuses   = myClickJustFocuses,
    borderWidth        = myBorderWidth,
    modMask            = myModMask,
    workspaces         = myWorkspaces,
    normalBorderColor  = myNormalBorderColor,
    focusedBorderColor = myFocusedBorderColor,

    -- key bindings
    keys               = myKeys,
    mouseBindings      = myMouseBindings,

    -- hooks, layouts
    layoutHook         = myLayout, -- showWName myLayout,
    manageHook         =  positionStoreManageHook Nothing <+> manageDocks <+> myManageHook <+> manageHook desktopConfig ,--TODO Nothing is niet altijd goed
    handleEventHook    = myHandleEventHook,
    logHook            = myLogHook,
    startupHook        = myStartupHook
  }

