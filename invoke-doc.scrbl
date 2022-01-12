#lang scribble/manual

@(require (for-label racket/base
                     raco/invoke))

@title{@tt{raco-invoke}: invoke @exec{raco} commands}
@author[@author+email["bogdan@defn.io"]{Bogdan Popa}]
@defmodule[raco/invoke]

This module provides a function for invoking @exec{raco} commands in a
way that cooperates with @tt{raco-cross}.

@defproc[(raco [command-name string?]
               [arg string?] ...) byte?]{

  Invokes the command named @racket[command-name] with the given set
  of @racket[arg]s.  If the command doesn't exist, an error is raised.
  It invokes the command inside the current process via
  @racket[dynamic-require], so it doesn't create a subprocess.

  @racketblock[
  (raco "exe" "--help")
  (raco "exe" "-o" "test" "test.rkt")
  ]
}
