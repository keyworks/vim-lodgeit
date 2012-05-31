" Allow script to run on vim that has compatibility enabled
let s:save_cpo = &cpo
set cpo&vim

" Avoids the script from loading twice.
if exists('g:loaded_pastebin')	
  finish 
endif
let g:loaded_pastebin = 1
let g:pastebin_resource = 'http://localhost:5000/'

function! s:Initialize(startline, endline)
  if !exists('g:pastebin_resource')
    call <SID>ConfigureURI() 
  endif
  call <SID>Paste(a:startline, a:endline)
endfunction

function! s:ConfigureURI()
  call inputsave()
  let uri = input('Enter pastebin root url: ') 
  call inputrestore()

  if matchstr(uri,'/$') == ''
    let uri = uri . '/'
  endif

  let g:pastebin_resource = uri
endfunction

function! s:Paste(startline, endline)
  let lines = join(getline(a:startline, a:endline), "\n")

  let command = 'curl -X POST ' . g:pastebin_resource
  let command .= ' -d "language=' . &ft . '"'
  let command .= ' --data-urlencode "code=' . lines . '"'

  let response = system(command)
  let path = matchstr(response, 'show\/\d\+')
  let id = matchstr(path, '\d\+$')

  echom g:pastebin_resource . 'show/' . id
endfunction

" Public interface
command -range=% -nargs=0 Paste :call <SID>Initialize(<line1>, <line2>)
command -nargs=0 PasteConfigure :call <SID>ConfigureURI()

" Set comptability options to original state.
let &cpo = s:save_cpo
unlet s:save_cpo
