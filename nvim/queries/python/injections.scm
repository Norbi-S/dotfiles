; extends
; Try to identify SQL strings automatically
(string
  (string_content) @injection.content
  (#match? @injection.content "SELECT|CREATE|INSERT|UPDATE|ALTER")
  (#set! injection.language "sql"))

; Identify SQL strings by which variable they are assigned to
(assignment
  left: (identifier) @name (#any-of? @name "sql")
  right: (string (string_content) @injection.content
				 (#set! injection.language "sql")
				 (#set! injection.combined)))


