; Instructions
(instruction
  kind: (word) @keyword)

; Registers
(reg
  (word) @variable.builtin)

; Numbers
(int) @number

; Symbols / operands
(ident) @variable

; Comments
(line_comment) @comment

(string) @string 

(label
  (ident) @label)

(ptr) @variable.member
