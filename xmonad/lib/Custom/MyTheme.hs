{-# LANGUAGE ScopedTypeVariables #-}

-- |
--   Module : Custom.MyTheme
--   Copyright : (c) 2021 Joan Milev <joantmilev@gmail.com>
--   License : MIT
--
--   Maintainer : Joan Milev <joantmilev@gmail.com>
--   Stability : Stable
--   Portability : Unknown
module Custom.MyTheme
  ( basebg,
    basefg,
    basecr,
    base00,
    base08,
    base01,
    base09,
    base02,
    base0A,
    base03,
    base0B,
    base04,
    base0C,
    base05,
    base0D,
    base06,
    base0E,
    base07,
    base0F,
  )
where

import Custom.Xresources (xprop)
import Prelude (String)

basebg, basefg, basecr, base00, base08, base01, base09, base02, base0A, base03, base0B, base04, base0C, base05, base0D, base06, base0E, base07, base0F :: String
{- basebg = xprop "*.background"
basefg = xprop "*.foreground"
basecr = xprop "*.cursorColor"
base00 = xprop "*.color0"
base08 = xprop "*.color8"
base01 = xprop "*.color1"
base09 = xprop "*.color9"
base02 = xprop "*.color2"
base0A = xprop "*.color10"
base03 = xprop "*.color3"
base0B = xprop "*.color11"
base04 = xprop "*.color4"
base0C = xprop "*.color12"
base05 = xprop "*.color5"
base0D = xprop "*.color13"
base06 = xprop "*.color6"
base0E = xprop "*.color14"
base07 = xprop "*.color7"
base0F = xprop "*.color15" -}

basebg = "#1e2127"
basefg = "#c8ccd4"
basecr = basefg
base00 = "#2c313a"
base08 = "#424957"
base01 = "#ff6c6b"
base09 = "#ff8b92"
base02 = "#98be65"
base0A = "#ddffa7"
base03 = "#ffcb6b"
base0B = "#ffe585"
base04 = "#51aeed"
base0C = "#9cc4ff"
base05 = "#b58fae"
base0D = "#e1acff"
base06 = "#56b6c2"
base0E = "#a3f7ff"
base07 = "#a6aebf"
base0F = "#ffffff"
