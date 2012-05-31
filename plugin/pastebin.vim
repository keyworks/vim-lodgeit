" Allow script to run on vim that has compatibility enabled
let s:save_cpo = &cpo
set cpo&vim

" Avoids the script from loading twice.
if exists('loaded_pastebin')	
  finish 
endif
let loaded_pastebin = 1

let s:paste_command = 'curl'
let s:paste_method = '-X POST'
let s:paste_resource = ''
let s:paste_content_type = "-H 'Content-Type: application/json'"

function! s:Paste(startline, endline)
  let lines = join(getline(a:startline, a:endline), "\n")

  let command = s:paste_command
  let command .= " " . s:paste_method
  let command .= " " . s:paste_resource
  let command .= " " . "-d \"language=" . &ft . "\""
  let command .= " " . "--data-urlencode \"code=" . lines . "\""

  let response = system(command)
  let id = matchlist(response, '.*\/show\/\(\d\+\)\/.*')[1]
  echo 'http://paste.2ndsiteinc.com/show/' . id
endfunction

command -range=% -nargs=0 Paste :call <SID>Paste(<line1>, <line2>)

" Set comptability options to original state.
let &cpo = s:save_cpo
unlet s:save_cpo
