(defmodule lone-ranger
  (doc "Cowboy utilities for LFE.")
  (author "Eric Bailey")
  (export (priv-dir 3) (priv-dir 2) (priv-dir 1)
          (priv-file 2)))

(defun priv-dir (app path extra)
  "Since cowboy_static internally calls `code:priv_dir/1`, which doesn't like
application names in kebab case, use this `#(dir ...)` config instead of:
```erlang
{priv_dir, App, Path, Extra}
```"
  `#(dir ,(filename:join (priv-dir app) path) ,extra))

(defun priv-dir (app path)
  "Equivalent to [[priv-dir/3]] with `[]` as `extra`."
  (priv-dir app path []))

(defun priv-dir (app)
  "Given an `app` name as an atom, return the path to its `priv` directory.
Call `code:priv_dir/1` and return the result, unless it is `#(error bad_name)`.
In that case, hack together the path manually, using a trick that
should work, even if `app` is in kebab case."
  (case (code:priv_dir app)
    (#(error bad_name)
     (let ((app-dir (filename:dirname (filename:dirname (code:which app)))))
       (filename:absname_join app-dir "priv")))
    (priv-dir priv-dir)))

(defun priv-file (app path)
  "Since cowboy_static internally calls `code:priv_dir/1`, which doesn't like
application names in kebab case, use this `#(file ...)` config instead of:
```erlang
{priv_file, App, Path, Extra}
```"
  `#(file ,(filename:absname (++ (priv-dir app) "/" path)) []))
