#lang racket/base

(require racket/contract
         raco/all-tools
         raco/command-name)

(provide
 (contract-out
  [raco (-> string? string? ... byte?)]))

(define (raco command-name . args)
  (define command-spec
    (hash-ref (all-tools) command-name #f))
  (unless command-spec
    (raise-argument-error 'raco "a registered command" command-name))
  (define plumber (make-plumber))
  (define custodian (make-custodian))
  (define exit-code
    (call-with-escape-continuation
     (lambda (ec)
       (parameterize ([exit-handler (λ (res) (void (ec res)))]
                      [current-custodian custodian]
                      [current-namespace (make-base-empty-namespace)]
                      [current-plumber plumber]
                      [current-command-line-arguments (list->vector args)]
                      [current-command-name (car command-spec)])
         (dynamic-require (cadr command-spec) #f)))))
  (custodian-shutdown-all custodian)
  (plumber-flush-all plumber)
  (if (byte? exit-code)
      exit-code
      0))
