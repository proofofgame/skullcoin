;; Storage
(define-map presale-count principal uint)

;; Constats and Errors
(define-constant CONTRACT-OWNER tx-sender)
(define-constant ERR-NOT-AUTHORIZED (err u100))
(define-constant ERR-NOT-FOUND (err u101))
(define-constant ERR-SALE-NOT-ACTIVE (err u102))
(define-constant ERR-NO-MINTPASS-REMAINING (err u103))
(define-constant ERR-FATAL (err u104))

;; Variables
(define-data-var mint-price uint u0)
(define-data-var mintpass-sale-active bool false)
(define-data-var sale-active bool false)

;; Get presale balance
(define-read-only (get-presale-balance (account principal))
  (default-to u0
    (map-get? presale-count account)))

;; Check mintpass sales active
(define-read-only (mintpass-enabled)
  (ok (var-get mintpass-sale-active)))

;; Check public sales active
(define-read-only (public-enabled)
  (ok (var-get sale-active)))

;; Get the mint price
(define-read-only (get-mint-price)
  (ok (var-get mint-price)))

;; Set mintpass sale flag (only contract owner)
(define-public (flip-mintpass-sale)
  (begin
    (asserts! (is-eq tx-sender CONTRACT-OWNER)  ERR-NOT-AUTHORIZED)
    (var-set sale-active false)
    (var-set mintpass-sale-active (not (var-get mintpass-sale-active)))
    (ok (var-get mintpass-sale-active))))

;; Set public sale flag (only contract owner)
(define-public (flip-sale)
  (begin
    (asserts! (is-eq tx-sender CONTRACT-OWNER) ERR-NOT-AUTHORIZED)
    (var-set mintpass-sale-active false)
    (var-set sale-active (not (var-get sale-active)))
    (ok (var-get sale-active))))

;; Set mint price in uSTX (only contract owner)
(define-public (set-mint-price-in-ustx (price uint))
  (begin
    (asserts! (is-eq tx-sender CONTRACT-OWNER) ERR-NOT-AUTHORIZED)
    (var-set mint-price price)
    (ok (var-get mint-price))))

;; Claim NFT
(define-public (claim)
  (if (var-get mintpass-sale-active)
    (mintpass-mint tx-sender)
    (public-mint tx-sender)))

;; Claim 2 NFT
(define-public (claim-two)
  (begin
    (try! (claim))
    (try! (claim))
    (ok true)))

;; Claim 3 NFT
(define-public (claim-three)
  (begin
    (try! (claim))
    (try! (claim))
    (try! (claim))
    (ok true)))

;; Claim 4 NFT
(define-public (claim-four)
  (begin
    (try! (claim))
    (try! (claim))
    (try! (claim))
    (try! (claim))
    (ok true)))

;; Claim 5 NFT
(define-public (claim-five)
  (begin
    (try! (claim))
    (try! (claim))
    (try! (claim))
    (try! (claim))
    (try! (claim))
    (ok true)))

;; Claim 6 NFT
(define-public (claim-six)
  (begin
    (try! (claim))
    (try! (claim))
    (try! (claim))
    (try! (claim))
    (try! (claim))
    (try! (claim))
    (ok true)))

;; Claim 7 NFT
(define-public (claim-seven)
  (begin
    (try! (claim))
    (try! (claim))
    (try! (claim))
    (try! (claim))
    (try! (claim))
    (try! (claim))
    (try! (claim))
    (ok true)))

;; Claim 8 NFT
(define-public (claim-eight)
  (begin
    (try! (claim))
    (try! (claim))
    (try! (claim))
    (try! (claim))
    (try! (claim))
    (try! (claim))
    (try! (claim))
    (try! (claim))
    (ok true)))

;; Claim 9 NFT
(define-public (claim-nine)
  (begin
    (try! (claim))
    (try! (claim))
    (try! (claim))
    (try! (claim))
    (try! (claim))
    (try! (claim))
    (try! (claim))
    (try! (claim))
    (try! (claim))
    (ok true)))

;; Claim 10 NFT
(define-public (claim-ten)
  (begin
    (try! (claim))
    (try! (claim))
    (try! (claim))
    (try! (claim))
    (try! (claim))
    (try! (claim))
    (try! (claim))
    (try! (claim))
    (try! (claim))
    (try! (claim))
    (ok true)))

;; Internal - Mint NFT using Mintpass
(define-private (mintpass-mint (new-owner principal))
  (let ((presale-balance (get-presale-balance new-owner)))
    (asserts! (> presale-balance u0) ERR-NO-MINTPASS-REMAINING)
    (map-set presale-count
              new-owner
              (- presale-balance u1))
  (try! (contract-call? .skullcoin-souls-nft mint new-owner))
  (ok true)))

;; Internal - Mint NFT via public sale
(define-private (public-mint (new-owner principal))
  (begin
    (asserts! (var-get sale-active) ERR-SALE-NOT-ACTIVE)
    (try! (contract-call? .skullcoin-souls-nft mint new-owner))
    (ok true)))

;; Register this contract as allowed to mint
(as-contract (contract-call? .skullcoin-souls-nft set-mint-address))

;; Mintpasses
(map-set presale-count 'ST262CK3VPG6PDF4S96TTXFBVV9Y9Z75F51T7CSRM u5)
(map-set presale-count 'ST30GF338DH3TTJA9GYCQZRQ50H78YXF672KZHTSN u5)
(map-set presale-count 'STF3ZMTX0K3ZB7J4MH4RKEWVAJY3VSW28RB0W06Y u5)
(map-set presale-count 'ST3J9082D872Z0QHNRPS4QRW7SW17SXQG6HJX812G u5)