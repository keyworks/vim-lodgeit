vim-pastebin
============

In ~/.vimrc, specify the root url to your pastebin. Make sure you include http//.  
```
let pastebin_resource = '<root url>'
```

Usage
----
```
:'<,'>Paste
```
or to paste the whole file:

```
:Paste
```
The URL of the code snippet will be echoed. 