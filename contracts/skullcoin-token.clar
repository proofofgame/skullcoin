(impl-trait .ft-trait.sip-010-trait)

(define-fungible-token SKUL u2000000000000000)

;; Errors
(define-constant ERR-NOT-AUTHORIZED u101)

;; Constants
(define-constant CONTRACT-OWNER tx-sender)

;; Variables
(define-data-var token-uri (optional (string-utf8 256)) none)

(define-public (transfer (amount uint) (sender principal) (recipient principal) (memo (optional (buff 34))))
    (if (is-eq tx-sender sender)
        (begin
            (try! (ft-transfer? SKUL amount sender recipient))
            (print memo)
            (ok true)
        )
        (err u4)
    )
)

(define-public (set-token-uri (value (string-utf8 256)))
    (if (is-eq tx-sender CONTRACT-OWNER)
        (ok (var-set token-uri (some value)))
        (err ERR-NOT-AUTHORIZED)
    )
)

(define-public (burn (burn-amount uint))
    (begin
        (try! (ft-burn? SKUL burn-amount tx-sender))
        (ok true)
    )
)

(define-read-only (get-name)
    (ok "SKULLCOIN")
)

(define-read-only (get-symbol)
    (ok "SKUL")
)

(define-read-only (get-decimals)
    (ok u6)
)

(define-read-only (get-balance (user principal))
    (ok (ft-get-balance SKUL user))
)

(define-read-only (get-total-supply)
    (ok (ft-get-supply SKUL))
)

(define-read-only (get-token-uri)
    (ok (var-get token-uri))
)

;; (begin
;;    (try! (ft-mint? SKUL u400000000000000 'SP...))
;;    (try! (ft-mint? SKUL u200000000000000 'SP...))
;; )