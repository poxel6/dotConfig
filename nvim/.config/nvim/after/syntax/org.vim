" ~/.config/nvim/after/syntax/org.vim
"
" ============================================================================
" Org-mode highlighting
" Gruber-Darker × Doom-One hybrid palette
" ============================================================================
"
" Headings:
"   Level 1  #51afef
"   Level 2  #c678dd
"   Level 3  #a9a1e1
"   Level 4  #7cc3f3
"   Level 5  #d499e5
"   Level 6  #a8d7f7
"   Level 7  #e2bbee
"
" TODO:
"   #c73c3f
"
" ============================================================================


" ============================================================================
" HEADINGS
" ============================================================================

syntax clear orgHeadline

syntax match orgHeadline1 /^\*\s\+.*/
syntax match orgHeadline2 /^\*\{2}\s\+.*/
syntax match orgHeadline3 /^\*\{3}\s\+.*/
syntax match orgHeadline4 /^\*\{4}\s\+.*/
syntax match orgHeadline5 /^\*\{5}\s\+.*/
syntax match orgHeadline6 /^\*\{6}\s\+.*/
syntax match orgHeadline7 /^\*\{7}\s\+.\*/

highlight! orgHeadline1 guifg=#51afef gui=bold
highlight! orgHeadline2 guifg=#c678dd gui=bold
highlight! orgHeadline3 guifg=#a9a1e1 gui=bold
highlight! orgHeadline4 guifg=#7cc3f3 gui=bold
highlight! orgHeadline5 guifg=#d499e5 gui=bold
highlight! orgHeadline6 guifg=#a8d7f7 gui=bold
highlight! orgHeadline7 guifg=#e2bbee gui=bold


" ============================================================================
" TODO
" ============================================================================

syntax match orgTodo /\<TODO\>/

highlight! orgTodo guifg=#c73c3f gui=bold


" ============================================================================
" INLINE FORMATTING
" ============================================================================

" *bold*
highlight! orgBold gui=bold

" /italic/
highlight! orgItalic gui=italic

" _underline_
highlight! orgUnderline gui=underline

" +strikethrough+
highlight! orgStrikethrough gui=strikethrough


" ============================================================================
" INLINE CODE / VERBATIM
" ============================================================================

" ~code~
highlight! orgCodeInline guifg=#98be65

" =verbatim=
highlight! orgVerbatimInline guifg=#a9a1e1


" ============================================================================
" CODE BLOCKS
" ============================================================================

" #+BEGIN_SRC ... #+END_SRC
highlight! orgCodeBlock guifg=#98be65

" #+BEGIN_... / #+END_...
highlight! orgVerbatimBlock guifg=#98be65


" ============================================================================
" LISTS
" ============================================================================

" - item
" + item
highlight! orgUnorderedListMarker guifg=#c678dd

" 1. item
" a. item
highlight! orgOrderedListMarker guifg=#c678dd


" ============================================================================
" COMMENTS
" ============================================================================

highlight! orgLineComment guifg=#5c6370
highlight! orgBlockComment guifg=#5c6370


" ============================================================================
" DELIMITERS
" ============================================================================

highlight! orgBoldDelimiter guifg=#51afef
highlight! orgItalicDelimiter guifg=#c678dd
highlight! orgUnderlineDelimiter guifg=#a9a1e1
highlight! orgStrikethroughDelimiter guifg=#c73c3f

highlight! orgVerbatimInlineDelimiter guifg=#a9a1e1
highlight! orgCodeInlineDelimiter guifg=#98be65

highlight! orgVerbatimBlockDelimiter guifg=#7cc3f3 gui=bold
highlight! orgCodeBlockDelimiter guifg=#7cc3f3 gui=bold


" ============================================================================
" FALLBACK / LINKED GROUPS
" ============================================================================
"
" Your syntax definition currently links some Org groups to Markdown groups.
" Override those target groups here so they don't inherit unwanted colors.
"

highlight! markdownStrike guifg=#c73c3f gui=strikethrough
highlight! markdownOrderedListMarker guifg=#c678dd
highlight! markdownCodeBlock guifg=#98be65


" ============================================================================
" ORG METADATA
" ============================================================================

" #+TITLE:
" #+AUTHOR:
" #+DATE:
" #+PROPERTY:
" etc.
highlight! orgKeyword guifg=#7cc3f3 gui=bold


" ============================================================================
" DEFAULT ORG LINK
" ============================================================================

highlight! orgLink guifg=#51afef gui=underline


" ============================================================================
" TABLES
" ============================================================================

highlight! orgTable guifg=#c678dd
