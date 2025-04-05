; Treesitter injections for python


; Inject SQL highlighting into python
(assignment
	left: (identifier) @a_var (#any-of? @a_var "sql" "query")
	right: (string (string_content) @injection.content)
	(#set! injection.language "sql")
  )

(keyword_argument
	name: (identifier) @kw_arg (#any-of? @kw_arg "sql" "query")
	value: (string (string_content) @injection.content)
	(#set! injection.language "sql")
  )
