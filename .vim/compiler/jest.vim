if exists("current_compiler")
  finish
endif
let current_compiler = "jest"

let s:cpo_save = &cpo
set cpo-=C

CompilerSet makeprg=jest
CompilerSet errorformat=\(%f\)

let &cpo = s:cpo_save
unlet s:cpo_save
