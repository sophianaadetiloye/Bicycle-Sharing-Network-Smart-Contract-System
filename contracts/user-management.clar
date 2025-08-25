;; User Management Contract
;; Handles user registration, balance management, and user status

;; Constants
(define-constant CONTRACT-OWNER tx-sender)
(define-constant ERR-NOT-AUTHORIZED (err u100))
(define-constant ERR-USER-EXISTS (err u101))
(define-constant ERR-USER-NOT-FOUND (err u102))
(define-constant ERR-INSUFFICIENT-BALANCE (err u103))
(define-constant ERR-INVALID-AMOUNT (err u104))
(define-constant ERR-USER-SUSPENDED (err u105))

;; Data Variables
(define-data-var next-user-id uint u1)

;; Data Maps
(define-map users principal {
    user-id: uint,
    balance: uint,
    status: (string-ascii 20),
    registration-time: uint,
    total-rentals: uint
})

(define-map user-ids uint principal)

;; Public Functions

;; Register a new user
(define-public (register-user)
    (let ((user-principal tx-sender)
          (current-id (var-get next-user-id)))
        (asserts! (is-none (map-get? users user-principal)) ERR-USER-EXISTS)
        (map-set users user-principal {
            user-id: current-id,
            balance: u0,
            status: "active",
            registration-time: block-height,
            total-rentals: u0
        })
        (map-set user-ids current-id user-principal)
        (var-set next-user-id (+ current-id u1))
        (ok current-id)))

;; Add balance to user account
(define-public (add-balance (amount uint))
    (let ((user-data (unwrap! (map-get? users tx-sender) ERR-USER-NOT-FOUND)))
        (asserts! (> amount u0) ERR-INVALID-AMOUNT)
        (map-set users tx-sender (merge user-data {
            balance: (+ (get balance user-data) amount)
        }))
        (ok (+ (get balance user-data) amount))))

;; Deduct balance from user account (internal function)
(define-public (deduct-balance (user principal) (amount uint))
    (let ((user-data (unwrap! (map-get? users user) ERR-USER-NOT-FOUND)))
        (asserts! (>= (get balance user-data) amount) ERR-INSUFFICIENT-BALANCE)
        (asserts! (is-eq (get status user-data) "active") ERR-USER-SUSPENDED)
        (map-set users user (merge user-data {
            balance: (- (get balance user-data) amount)
        }))
        (ok (- (get balance user-data) amount))))

;; Update user status (admin only)
(define-public (update-user-status (user principal) (new-status (string-ascii 20)))
    (begin
        (asserts! (is-eq tx-sender CONTRACT-OWNER) ERR-NOT-AUTHORIZED)
        (let ((user-data (unwrap! (map-get? users user) ERR-USER-NOT-FOUND)))
            (map-set users user (merge user-data {
                status: new-status
            }))
            (ok true))))

;; Increment user rental count
(define-public (increment-rental-count (user principal))
    (let ((user-data (unwrap! (map-get? users user) ERR-USER-NOT-FOUND)))
        (map-set users user (merge user-data {
            total-rentals: (+ (get total-rentals user-data) u1)
        }))
        (ok (+ (get total-rentals user-data) u1))))

;; Read-only Functions

;; Get user information
(define-read-only (get-user-info (user principal))
    (map-get? users user))

;; Get user by ID
(define-read-only (get-user-by-id (user-id uint))
    (map-get? user-ids user-id))

;; Check if user is active
(define-read-only (is-user-active (user principal))
    (match (map-get? users user)
        user-data (is-eq (get status user-data) "active")
        false))

;; Get user balance
(define-read-only (get-user-balance (user principal))
    (match (map-get? users user)
        user-data (some (get balance user-data))
        none))

;; Get total registered users
(define-read-only (get-total-users)
    (- (var-get next-user-id) u1))
