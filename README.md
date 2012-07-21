vim-pastebin
============

In ~/.vimrc, specify the root url to your pastebin. Make sure you include http//.
```
let pastebin_resource = '<root url>'
```

Usage
----
Visual selection:
```
:'<,'>Paste
```
or to paste the whole file:

```
:Paste
```
The URL of the code snippet will be echoed.


Requirements
------------
curl version >= 7.18.0 is needed as the plugin uses curl to do URL encoding.
