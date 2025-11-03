; extends

((jinja_comment) @injection.content
  (#set! injection.language "jinja"))

((jinja_statement) @injection.content
  (#set! injection.language "jinja"))

((jinja_expression) @injection.content
  (#set! injection.language "jinja"))

