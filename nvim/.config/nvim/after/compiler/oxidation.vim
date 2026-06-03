if exists("current_compiler")
  finish
endif
let current_compiler = "oxidation"

CompilerSet makeprg=cargo\ build

CompilerSet errorformat=%E%f:%l:\ error:\ %m,
		       \%W%f:%l:\ warning:\ %m,
		       \%-Z%p^,
		       \%-C%.%#,
		       \%-G%.%#

CompilerSet errorformat=%Wwarning:\ %m,
						\%Eerror[%.%#]:\ %m,
		       			\%-C%.%#-->\ %f:%l:%c,
					   	\%-G%.%#
