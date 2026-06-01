if exists("current_compiler")
  finish
endif
let current_compiler = "myzig"

CompilerSet makeprg=zig\ build

CompilerSet errorformat=%E%f:%l:%c:\ error:\ %m,
						\%W%f:%l:%c:\ warning:\ %m,
					   	\%-Z%p^,
					   	\%-C%.%#,
					   	\%-G%.%#

