;; Design Verification Contract
;; Validates product specifications and design requirements

;; Define data variables
(define-data-var contract-owner principal tx-sender)
(define-map designs
  { design-id: (string-ascii 36) }
  {
    name: (string-ascii 100),
    version: (string-ascii 20),
    specifications: (string-utf8 1000),
    status: (string-ascii 20),
    verified-by: principal,
    timestamp: uint
  }
)

(define-map design-approvals
  { design-id: (string-ascii 36), approver: principal }
  {
    approved: bool,
    comments: (string-utf8 500),
    timestamp: uint
  }
)

;; Error codes
(define-constant ERR_UNAUTHORIZED u1)
(define-constant ERR_ALREADY_EXISTS u2)
(define-constant ERR_NOT_FOUND u3)

;; Read-only functions
(define-read-only (get-design (design-id (string-ascii 36)))
  (map-get? designs { design-id: design-id })
)

(define-read-only (get-design-approval (design-id (string-ascii 36)) (approver principal))
  (map-get? design-approvals { design-id: design-id, approver: approver })
)

;; Public functions
(define-public (register-design
    (design-id (string-ascii 36))
    (name (string-ascii 100))
    (version (string-ascii 20))
    (specifications (string-utf8 1000))
  )
  (let ((existing-design (get-design design-id)))
    (asserts! (is-none existing-design) (err ERR_ALREADY_EXISTS))

    (map-set designs
      { design-id: design-id }
      {
        name: name,
        version: version,
        specifications: specifications,
        status: "pending",
        verified-by: tx-sender,
        timestamp: (unwrap-panic (get-block-info? time u0))
      }
    )
    (ok true)
  )
)

(define-public (approve-design (design-id (string-ascii 36)) (comments (string-utf8 500)))
  (let ((design (get-design design-id)))
    (asserts! (is-some design) (err ERR_NOT_FOUND))

    (map-set design-approvals
      { design-id: design-id, approver: tx-sender }
      {
        approved: true,
        comments: comments,
        timestamp: (unwrap-panic (get-block-info? time u0))
      }
    )
    (ok true)
  )
)

(define-public (reject-design (design-id (string-ascii 36)) (comments (string-utf8 500)))
  (let ((design (get-design design-id)))
    (asserts! (is-some design) (err ERR_NOT_FOUND))

    (map-set design-approvals
      { design-id: design-id, approver: tx-sender }
      {
        approved: false,
        comments: comments,
        timestamp: (unwrap-panic (get-block-info? time u0))
      }
    )
    (ok true)
  )
)

(define-public (update-design-status (design-id (string-ascii 36)) (status (string-ascii 20)))
  (let ((design (get-design design-id)))
    (asserts! (is-some design) (err ERR_NOT_FOUND))
    (asserts! (is-eq tx-sender (var-get contract-owner)) (err ERR_UNAUTHORIZED))

    (map-set designs
      { design-id: design-id }
      (merge (unwrap-panic design) { status: status })
    )
    (ok true)
  )
)
