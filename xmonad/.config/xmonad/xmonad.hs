{-# LANGUAGE TypeSynonymInstances, DeriveDataTypeable, MultiParamTypeClasses, FlexibleContexts #-}

-- TODO do we need postion store
-- TODO cleaner shutdown
-- TODO directional navigaion
-- TODO correct behavior new terminal
import System.Exit
import qualified Data.Map        as M
import Data.Monoid
-- import System.Process
-- import Data.List
-- import Data.Monoid
-- import System.IO

import XMonad hiding ( (|||) ,Mirror)
import qualified XMonad.StackSet as W
import XMonad.Config.Desktop
-- import XMonad.Prompt
-- import XMonad.Prompt.XMonad

import XMonad.Actions.WindowGo

-- import qualified XMonad.Layout.BinarySpacePartition as Binary
import XMonad.Actions.CycleWindows
import XMonad.Layout.LimitWindows
import XMonad.Actions.CycleSelectedLayouts
-- import XMonad.Layout.Magnifier
-- import XMonad.Layout.Spacing
-- import XMonad.Layout.StackTile
-- import XMonad.Layout.TwoPane
import XMonad.Layout.Fullscreen as Fullscreen
import XMonad.Layout.LayoutCombinators -- use this
import XMonad.Layout.Maximize
import XMonad.Layout.Minimize
-- import XMonad.Layout.Tabbed
-- import XMonad.Layout.TabBarDecoration
import XMonad.Layout.LayoutModifier
import XMonad.Layout.PositionStoreFloat
-- import XMonad.Layout.TwoPane
import XMonad.Layout.Renamed as Renamed
import XMonad.Layout.Decoration
import XMonad.Layout.ButtonDecoration
import XMonad.Layout.MultiToggle as MultiToggle
-- import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.BorderResize
import XMonad.Layout.BoringWindows
-- import XMonad.Layout.DwmStyle
import XMonad.Layout.Simplest
import XMonad.Layout.ImageButtonDecoration
import XMonad.Layout.WindowSwitcherDecoration
import XMonad.Layout.DraggingVisualizer
import MyMouseResizableTile
-- import XMonad.Layout.ToggleLayouts as ToggleLayouts
import XMonad.Layout.NoBorders
import XMonad.Layout.WindowNavigation
-- import XMonad.Layout.Combo
import XMonad.Layout.TrackFloating
-- import XMonad.Layout.MagicFocus
import XMonad.Layout.LayoutHints
-- import XMonad.Layout.SimpleFloat
-- import XMonad.Layout.Accordion
-- import XMonad.Layout.Spiral
-- import XMonad.Layout.SimplestFloat
-- import XMonad.Layout.ShowWName
-- import XMonad.Layout.Roledex
import XMonad.Layout.WindowArranger
-- import XMonad.Layout.SimpleDecoration
-- import XMonad.Layout.DecorationAddons
-- import XMonad.Layout.BorderResize
-- import XMonad.Layout.Maximize

import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops as Ewmh
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
import XMonad.Actions.MouseResize
-- import XMonad.Actions.UpdatePointer

-- import XMonad.Util.EZConfig (additionalKeys)
-- import XMonad.Util.Dzen as D
-- import XMonad.Util.Run (spawnPipe)

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
myTerminal :: String
myTerminal = "termite"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window -- TODO revers
myClickJustFocuses :: Bool
myClickJustFocuses = True

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
myFocusedBorderColor = "#5058EE"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@XConfig {XMonad.modMask = modm}= M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), raiseNextMaybe ( spawn (XMonad.terminal conf)) (className =? "URxvt"))

    -- launch dmenu
    -- , ((modm,               xK_p     ), spawn "dmenu-frecency")

    -- launch gmrun
    , ((modm .|. shiftMask, xK_p     ), spawn "albert toggle")

    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), cycleRecentWindows [xK_Super_L] xK_Tab xK_i) --TODO is this what i want
    -- Move focus to the next window
    , ((modm,               xK_u     ), cycleRecentWindows [xK_Super_L] xK_u xK_i)
    , ((modm,               xK_i     ), rotOpposite)

    , ((modm,               xK_j     ), focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_o     ), focusMaster  ) -- TODO find good key

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), dwmpromote ) -- werkt mogelijk niet goed met boring windows

    -- Swap the focused window with the next window

    -- , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )
    -- , ((modm .|. shiftMask, xK_j     ), windows W.focusDown)

    -- Swap the focused window with the previous window

    -- , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )
    -- , ((modm .|. shiftMask, xK_k     ), windows W.focusUp)

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

  -- , ((mod1Mask .|. controlMask, xK_Left), prevWS)
   -- , ((mod1Mask .|. controlMask, xK_Right), nextWS)
    --, ((mod1Mask .|. controlMask .|. shiftMask,   xK_Left), shiftToPrev >> prevWS)
   -- , ((mod1Mask .|. controlMask .|. shiftMask,   xK_Right), shiftToNext >> nextWS)

    , ((modm.|. shiftMask,   xK_l    ), sendMessage ShrinkSlave) -- %! Shrink a slave area
    , ((modm.|. shiftMask,   xK_h    ), sendMessage ExpandSlave) -- %! Expand a slave area

    , ((modm,               xK_Right ), sendMessage $ Go R)
    , ((modm,               xK_Left  ), sendMessage $ Go L)
    , ((modm,               xK_Up    ), sendMessage $ Go U)
    , ((modm,               xK_Down  ), sendMessage $ Go D)
    , ((modm .|. shiftMask, xK_Right ), sendMessage $ Swap R)
    , ((modm .|. shiftMask, xK_Left  ), sendMessage $ Swap L)
    , ((modm .|. shiftMask, xK_Up    ), sendMessage $ Swap U)
    , ((modm .|. shiftMask, xK_Down  ), sendMessage $ Swap D)


--    , ((modm,               xK_m     ), withFocused minimizeWindow)
--    , ((modm .|. shiftMask, xK_m     ), sendMessage RestoreNextMinimizedWin)
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
     , ((modm              , xK_b    ), sendMessage ToggleStruts)
    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io exitSuccess) --callCommand"close-windows.sh") >>



    , ((modm,               xK_z     ), sendMessage Mirror)
    , ((modm,               xK_x     ), sendMessage $ MultiToggle.Toggle NODECO)
    -- Restart xmonad
    , ((modm              , xK_q     ),  spawn "xmonad --recompile && xmonad --restart")

    -- , ((modm,               xK_o ), windowMenu)
    --    , ((modm .|. shiftMask, xK_BackSpace), removeWorkspace)

    , ((modm             ,xK_backslash), withFocused (sendMessage . maximizeRestore))

    , ((modm .|. shiftMask, xK_v      ), selectWorkspace def)
    -- , ((modm, xK_m                    ), withWorkspace def(windows . W.shift))
    -- , ((modm .|. shiftMask, xK_m      ), withWorkspace def(windows . copy))
    , ((modm .|. shiftMask, xK_r      ), renameWorkspace def)

    , ((modm , xK_F11                 ), sendMessage $ JumpToLayout "Fullscreen")  -- jump directly to the Full layout

    , ((modm ,                    xK_f), sendMessage $ JumpToLayout "Fullscreen")  -- jump directly to the Full layout
   -- , ((modm , xK_f), sendMessage $ ToggleLayouts.Toggle "Full" )  -- jump directly to the Full layout

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
myThemeWithImageButtons = defaultThemeWithImageButtons {activeColor ="#1E284C",inactiveColor = "#262932F",activeBorderColor ="#262932",inactiveBorderColor ="#262932"}

myLayout =
  avoidStruts $
  minimize $
      full ||| tiled3 ||| tiled2 ||| floating
                              -- TODO swap with mose does now work
                              --      swap master
                              --      tileN are bad names
  where
      rename newName = renamed [Renamed.Replace newName ]
      prefixNonFloating l = prefix $
              MultiToggle.mkToggle (MultiToggle.single NODECO) $
              l

                         -- magnifiercz 0.02 $
      prefix l = fullscreenFocus $
               windowNavigation $ -- TODO what do the deafult settings
               -- dwmStyle shrinkText myThemeWithImageButtons $
               -- layoutHints $ -- might not work
               -- mouseResize $
               -- windowArrange $
               boringAuto $
               -- borderResize
               trackFloating $

              draggingVisualizer $
               -- useTransientFor $
               -- MultiToggle.mkToggle (MultiToggle.single NBFULL) $
               l
      floating = rename "Float" $ -- TODO make al Float this
              noBorders $
              layoutHints $
              floatingDeco $
              maximizeWithPadding 0 $ -- TODO maximize windows cant be resized
              borderResize $
              positionStoreFloat

      -- twopane        = rename "Twopane" $ prefixNonFloating $ borderResize (mouseResize $ windowArrange  $ TwoPane (3/100) (1/2))
      floatingDeco   = buttonDeco shrinkText myThemeWithImageButtons
      full           = rename "Fullscreen" $ prefixNonFloating (noBorders Simplest)
      tiled3 = rename "Tile3" $
              -- limitWindows 2 $ --TODO make it possible to increase limit
              --                         why do some applcation go to master and some to save
              limitSelect 1 1 $
              prefixNonFloating $
              smartBorders $
              mouseResizableTile
      -- tiled1         = rename "Tile1" $
      --         -- mkToggle (single MIRROR) $
      --         prefixNonFloating $
      --         smartBorders $
      --         mouseResizableTileMirrored
      tiled2         = rename "Til2" $
              -- mkToggle (single MIRROR)  $
              prefixNonFloating $
              smartBorders $
              mouseResizableTile
      -- fullscreen     = maximize Full
      -- tilingDeco l   = windowSwitcherDecorationWithImageButtons shrinkText defaultThemeWithImageButtons l
                        -- named "Accordion" Accordion|||
                        -- named "Rolex" Roledex |||
                        -- named "Simplest"  Simplest |||
                        -- named "simpelFloat" simpleFloat|||
                        -- named  "simpelFloat" simplestFloat|||
                        -- named "spiral"(spiral (6/7)) |||
                        -- named "Tab" simpleTabbed|||

                        -- Simplest *|* Simplest |||
                        -- combineTwo (TwoPane 0.03 0.5) simpleTabbed simpleTabbed |||

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
myHandleEventHook = handleEventHook def<+> positionStoreEventHook <+> Fullscreen.fullscreenEventHook <+> minimizeEventHook  <+> docksEventHook-- <+>  notFocusFloat
    -- where
    -- notFocusFloat = followOnlyIf (fmap not isFloat) where --Do not focusFollowMouse on Float layout
    --         isFloat = fmap (isSuffixOf "float") $ gets (description . W.layout . W.workspace . W.current . windowset)

main :: IO ()
main = xmonad $ fullscreenSupport $ ewmh $docks settings

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

     --TODO there was something here (see other file)
     --TODO resize window closed corner
    -- mouseBindings      = myMouseBindings,

    -- hooks, layouts
    layoutHook         = myLayout, -- showWName myLayout,
    manageHook         = positionStoreManageHook Nothing <+> manageDocks <+> myManageHook <+> manageHook desktopConfig ,--TODO Nothing is niet altijd goed
    handleEventHook    = myHandleEventHook,
    logHook            = myLogHook,
    startupHook        = myStartupHook
  }

