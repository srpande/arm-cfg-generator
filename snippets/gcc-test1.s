	.arch armv8-a
	.file	"test.cc"
	.text
	.align	2
	.p2align 3,,7
	.global	v8::internal::Scanner::Next()
	.type	v8::internal::Scanner::Next(), %function
v8::internal::Scanner::Next():
.LFB15882:
	.cfi_startproc
	ldr	w1, [x0, 284]
	cbnz	w1, .L2
	ldp	w3, w2, [x0, 208]
	str	w3, [x0, 256]
	str	w2, [x0, 260]
.L2:
	ldp	x4, x5, [x0, 256]
	stp	x4, x5, [x0, 208]
	ldr	w4, [x0, 332]
	ldp	x8, x9, [x0, 272]
	stp	x8, x9, [x0, 224]
	cmp	w4, 104
	ldp	x6, x7, [x0, 288]
	stp	x6, x7, [x0, 240]
	bne	.L24
	stp	x29, x30, [sp, -32]!
	.cfi_def_cfa_offset 32
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	str	x19, [sp, 16]
	.cfi_offset 19, -16
	mov	x19, x0
	ldr	w1, [x0, 372]
	strb	wzr, [x0, 376]
	strb	wzr, [x0, 377]
	cmp	w1, 127
	bhi	.L5
	adrp	x0, .LANCHOR0
	add	x0, x0, :lo12:.LANCHOR0
	ldrb	w1, [x0, w1, sxtw]
	cmp	w1, 100
	bne	.L25
.L5:
	mov	x0, x19
	bl	v8::internal::Scanner::Scan()
	ldr	w1, [x19, 236]
	ldr	x19, [sp, 16]
	mov	w0, w1
	ldp	x29, x30, [sp], 32
	.cfi_remember_state
	.cfi_restore 30
	.cfi_restore 29
	.cfi_restore 19
	.cfi_def_cfa 31, 0
	ret
	.p2align 2
.L25:
	.cfi_restore_state
	str	x20, [x29, 24]
	.cfi_offset 20, -8
	ldr	x20, [x19, 352]
	ldp	x0, x2, [x20, 8]
	ldp	x3, x5, [x20, 24]
	stp	xzr, xzr, [x19, 264]
	str	w1, [x19, 284]
	sub	x0, x2, x0
	str	wzr, [x19, 288]
	str	w4, [x19, 300]
	add	x0, x5, x0, asr 1
	str	w0, [x19, 260]
	sub	w0, w0, #1
	str	w0, [x19, 256]
	cmp	x2, x3
	bcs	.L6
	add	x1, x2, 2
	ldrh	w0, [x2]
	str	x1, [x20, 16]
.L7:
	str	w0, [x19, 372]
	and	w0, w0, 64512
	mov	w1, 55296
	cmp	w0, w1
	bne	.L9
	ldr	x20, [x19, 352]
	ldp	x0, x1, [x20, 16]
	cmp	x0, x1
	bcs	.L10
	add	x1, x0, 2
	ldrh	w0, [x0]
	str	x1, [x20, 16]
.L11:
	and	w2, w0, 64512
	mov	w1, 56320
	cmp	w2, w1
	bne	.L16
	ldr	w1, [x19, 372]
	and	w0, w0, 1023
	ubfiz	w1, w1, 10, 10
	orr	w0, w1, w0
	add	w0, w0, 65536
	str	w0, [x19, 372]
.L9:
	ldr	w1, [x19, 236]
	ldr	x20, [x29, 24]
	.cfi_restore 20
	mov	w0, w1
	ldr	x19, [sp, 16]
	ldp	x29, x30, [sp], 32
	.cfi_restore 30
	.cfi_restore 29
	.cfi_restore 19
	.cfi_def_cfa 31, 0
	ret
	.p2align 2
.L24:
	ldp	x6, x7, [x0, 304]
	mov	w2, 104
	ldp	x8, x9, [x0, 320]
	stp	x6, x7, [x0, 256]
	ldrb	w3, [x0, 378]
	ldp	x4, x5, [x0, 336]
	stp	x8, x9, [x0, 272]
	stp	x4, x5, [x0, 288]
	str	w2, [x0, 332]
	str	w2, [x0, 348]
	strb	w3, [x0, 376]
	mov	w0, w1
	ret
	.p2align 2
.L6:
	.cfi_def_cfa 29, 32
	.cfi_offset 19, -16
	.cfi_offset 20, -8
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	ldr	x1, [x20]
	mov	x0, x20
	ldr	x1, [x1, 24]
	blr	x1
	tst	w0, 255
	ldr	x0, [x20, 16]
	beq	.L8
	add	x1, x0, 2
	ldrh	w0, [x0]
	str	x1, [x20, 16]
	b	.L7
	.p2align 2
.L10:
	ldr	x1, [x20]
	mov	x0, x20
	ldr	x1, [x1, 24]
	blr	x1
	tst	w0, 255
	ldr	x0, [x20, 16]
	beq	.L12
	add	x1, x0, 2
	ldrh	w0, [x0]
	str	x1, [x20, 16]
	b	.L11
.L12:
	add	x0, x0, 2
	str	x0, [x20, 16]
	.p2align 3
.L16:
	ldr	x2, [x19, 352]
	ldp	x3, x0, [x2, 8]
	cmp	x0, x3
	bls	.L13
	sub	x0, x0, #2
	str	x0, [x2, 16]
	b	.L9
.L13:
	ldr	x5, [x2]
	sub	x1, x0, x3
	ldr	x4, [x2, 32]
	str	x3, [x2, 16]
	mov	x0, x2
	sub	x3, x4, #1
	ldr	x4, [x5, 24]
	add	x1, x3, x1, asr 1
	str	x1, [x2, 32]
	blr	x4
	b	.L9
.L8:
	add	x0, x0, 2
	str	x0, [x20, 16]
	mov	w1, -1
	str	w1, [x19, 372]
	b	.L9
	.cfi_endproc
.LFE15882:
	.size	v8::internal::Scanner::Next(), .-v8::internal::Scanner::Next()
	.section	.rodata
	.align	3
	.set	.LANCHOR0,. + 0
	.type	v8::internal::one_char_tokens, %object
	.size	v8::internal::one_char_tokens, 128
v8::internal::one_char_tokens:
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	1
	.byte	2
	.byte	100
	.byte	100
	.byte	29
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	7
	.byte	8
	.byte	100
	.byte	100
	.byte	100
	.byte	11
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	3
	.byte	100
	.byte	4
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	100
	.byte	5
	.byte	100
	.byte	6
	.byte	55
	.byte	100
	.ident	"GCC: (Built at SARC from internal patch SHA:620f2f4) 8.0.0 20170916 (experimental)"
	.section	.note.GNU-stack,"",@progbits
