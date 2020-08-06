Base16 Themes for StumpWM
================================

[Base16](https://github.com/chriskempson/base16) provides carefully chosen syntax highlighting and a default set of sixteen colors suitable for a wide range of applications. Base16 is not a single theme but a set of guidelines with numerous implementations.

This repository contains a Base16 Template for StumpWM and a StumpWM Module which allows easy selection of a Base16 Scheme from within StumpWM.

# Installation #

In order to install the StumpWM Module you require the cl-base16 dependency which is not on quicklisp but can be found here: [https://github.com/tpine/cl-base16](https://github.com/tpine/cl-base16) and installed into your quicklisp local projects directory.

# Example Usage #

```lisp
(set-module-dir "/path/to/stumpwm/module/dir/")

(load-module :stumpwm-base16)

;;; On first run execute this to pull the themes from github
;;; This command may take some time to complete
(stumpwm-base16:update)

;;; Load theme by passing a string with the theme name
(stumpwm-base16:load-theme "dracula")
```

# Using stumpwm-base16 #

The module provides two commands ``` load-theme``` and ``` select-theme ```.

``` load-theme ``` provides a basic interface to select your theme and is best used in your stumpwm init file to select a theme on startup.

``` select-theme ``` provides a menu to browse and select the theme you wish to use.
