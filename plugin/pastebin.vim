" Allow script to run on vim that has compatibility enabled
let s:save_cpo = &cpo
set cpo&vim

" Avoids the script from loading twice.
if exists('g:loaded_pastebin')
  finish
endif
let g:loaded_pastebin = 1

function! s:Initialize(startline, endline)
  if !exists('g:pastebin_resource')
    call <SID>ConfigureURI()
  endif
  call <SID>CleanURI()
  call <SID>Paste(a:startline, a:endline)
endfunction

function! s:ConfigureURI()
  call inputsave()
  let uri = input('Enter pastebin root url: ')
  call inputrestore()
  redraw

  let g:pastebin_resource = uri
endfunction

function! s:CleanURI()
  if matchstr(g:pastebin_resource,'/$') == ''
    let g:pastebin_resource = g:pastebin_resource . '/'
  endif
endfunction

function! s:Paste(startline, endline)
  let lines = join(getline(a:startline, a:endline), "\n")

  let command = 'curl -X POST ' . g:pastebin_resource
  let command .= ' -d "language=' . &ft . '"'
  let command .= ' --data-urlencode "code=' . escape(lines, '"') . '"'

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
