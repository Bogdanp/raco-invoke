# raco-invoke

Invoke `raco` commands from Racket without starting a subprocess and
in a way that cooperates with `raco cross`.

## Usage

```racket
#lang racket/base

(require raco/invoke)

(raco "exe" "--help")
(raco "exe" "-o" "test" "test.rkt")
```

## License

    raco-invoke is licensed under the 3-Clause BSD license.
