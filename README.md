vim-pastebin
============

Code paster for [LodgeIt pastebin](http://www.pocoo.org/projects/lodgeit/). 

In ~/.vimrc, specify the root url to your pastebin.
```
let pastebin_resource = 'http://yourpastebin.com'
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
