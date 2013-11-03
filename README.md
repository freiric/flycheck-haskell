flycheck-haskell
================

Make Flycheck use ghc options in cabal projects.

A *Cabal project* is denoted by the existence of a `*.cabal` file at the top of the
source code tree. Flychek (or more precisely hdevtools) needs some ghc options which are set up in the cabal
configuration file.

The perfect solution would be to extract these options from the cabal file and
pass them to flycheck (the hdevtools checker).
In the meantime this extension reads the option from a file .ghc-options when it exists.

Installation
------------

```lisp
(source melpa)

(depends-on "flycheck-haskell")
```

In your `init.el`:

```lisp
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-haskell-setup))
```

Usage
-----

Use Flycheck in cabal project and write the options to pass to ghc into a file .ghc-options.
Reference to directory are relative to the directory where the cabal file is found.

Example of `.ghc-options` file:

```
-wtest -cpp -optP-include -optPdist/build/autogen/cabal_macros.h -optP-DTEST_EXPORT
```

Customization
-------------

- No customization yet.

License
-------

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
this program.  If not, see http://www.gnu.org/licenses/.

