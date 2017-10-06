	.text
	.file	"test.cc"
	.globl	v8::internal::Scanner::Next() // -- Begin function v8::internal::Scanner::Next()
	.p2align	2
	.type	v8::internal::Scanner::Next(),@function
v8::internal::Scanner::Next():         // @v8::internal::Scanner::Next()
	.cfi_startproc
// BB#0:                                // %entry
	stp	x20, x19, [sp, #-32]!   // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 8-byte Folded Spill
	add	x29, sp, #16            // =16
.Lcfi0:
	.cfi_def_cfa w29, 16
.Lcfi1:
	.cfi_offset w30, -8
.Lcfi2:
	.cfi_offset w29, -16
.Lcfi3:
	.cfi_offset w19, -24
.Lcfi4:
	.cfi_offset w20, -32
	mov	 x19, x0
	ldr	w9, [x19, #284]
	add	x8, x19, #256           // =256
	cbnz	w9, .LBB0_2
// BB#1:                                // %if.then
	ldr	x9, [x19, #208]
	str	x9, [x19, #256]
.LBB0_2:                                // %if.end
	ldr	q0, [x8, #32]
	ldr	w9, [x19, #332]
	str	q0, [x19, #240]
	ldr	q0, [x8, #16]
	cmp		w9, #104        // =104
	str	q0, [x19, #224]
	ldr		q0, [x8]
	str	q0, [x19, #208]
	b.ne	.LBB0_14
// BB#3:                                // %if.end24
	ldrsw	x8, [x19, #372]
	strh	wzr, [x19, #376]
	cmp		w8, #127        // =127
	b.hi	.LBB0_5
// BB#4:                                // %if.then27
	adrp	x9, v8::internal::one_char_tokens
	add	x9, x9, :lo12:v8::internal::one_char_tokens
	ldrb		w9, [x9, x8]
	cmp		w9, #100        // =100
	b.ne	.LBB0_7
.LBB0_5:                                // %if.end49
	mov	 x0, x19
	bl	v8::internal::Scanner::Scan()
.LBB0_6:                                // %return
	ldr	w0, [x19, #236]
	ldp	x29, x30, [sp, #16]     // 8-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 8-byte Folded Reload
	ret
.LBB0_7:                                // %if.then32
	ldr	x20, [x19, #352]
	ldp	x11, x8, [x20, #8]
	ldr	w10, [x20, #32]
	str	w9, [x19, #284]
	mov	w9, #104
	str	w9, [x19, #300]
	sub		x9, x8, x11
	lsr	x9, x9, #1
	add		w9, w9, w10
	sub	w10, w9, #1             // =1
	str	wzr, [x19, #288]
	str	w9, [x19, #260]
	str	w10, [x19, #256]
	stp	xzr, xzr, [x19, #264]
	ldr	x9, [x20, #24]
	cmp		x9, x8
	b.ls	.LBB0_15
// BB#8:                                // %if.then.i.i
	add	x9, x8, #2              // =2
	str	x9, [x20, #16]
.LBB0_9:                                // %void v8::internal::Scanner::Advance<false, true>() [clone .exit]
	ldrh		w8, [x8]
	mov	w10, #55296
	and	w9, w8, #0xfc00
	cmp		w9, w10
	str	w8, [x19, #372]
	b.ne	.LBB0_6
// BB#10:                               // %if.then.i
	ldr	x20, [x19, #352]
	ldp	x8, x9, [x20, #16]
	cmp		x8, x9
	b.hs	.LBB0_17
// BB#11:                               // %if.then.i17.i
	add	x9, x8, #2              // =2
	str	x9, [x20, #16]
.LBB0_12:                               // %v8::internal::Utf16CharacterStream::Advance() [clone .exit] [clone .i]
	ldrh		w8, [x8]
	mov	w10, #56320
	and	w9, w8, #0xfc00
	cmp		w9, w10
	b.ne	.LBB0_18
// BB#13:                               // %if.else.i
	ldr	w9, [x19, #372]
	ubfiz	w9, w9, #10, #10
	add	w9, w9, #16, lsl #12    // =65536
	bfxil	w9, w8, #0, #10
	str	w9, [x19, #372]
	b	.LBB0_6
.LBB0_14:                               // %if.then15
	ldr	q0, [x19, #336]
	mov	w9, #104
	str	q0, [x8, #32]
	ldr	q0, [x19, #320]
	str	q0, [x8, #16]
	ldr	q0, [x19, #304]
	str		q0, [x8]
	ldrb	w8, [x19, #378]
	str	w9, [x19, #332]
	str	w9, [x19, #348]
	strb	w8, [x19, #376]
	b	.LBB0_6
.LBB0_15:                               // %if.else.i.i
	ldr		x8, [x20]
	mov	 x0, x20
	ldr	x8, [x8, #24]
	blr	x8
	ldr	x8, [x20, #16]
	add	x9, x8, #2              // =2
	str	x9, [x20, #16]
	tbnz	w0, #0, .LBB0_9
// BB#16:                               // %void v8::internal::Scanner::Advance<false, true>() [clone .exit] [clone .thread]
	mov	w8, #-1
	str	w8, [x19, #372]
	b	.LBB0_6
.LBB0_17:                               // %if.else.i18.i
	ldr		x8, [x20]
	mov	 x0, x20
	ldr	x8, [x8, #24]
	blr	x8
	ldr	x8, [x20, #16]
	add	x9, x8, #2              // =2
	str	x9, [x20, #16]
	tbnz	w0, #0, .LBB0_12
.LBB0_18:                               // %if.then4.i
	ldr	x0, [x19, #352]
	ldp	x8, x10, [x0, #8]
	subs		x9, x10, x8
	b.ls	.LBB0_20
// BB#19:                               // %if.then.i.i72
	sub	x8, x10, #2             // =2
	str	x8, [x0, #16]
	b	.LBB0_6
.LBB0_20:                               // %if.else.i.i73
	ldr	x10, [x0, #32]
	ldr		x11, [x0]
	str	x8, [x0, #16]
	add	x9, x10, x9, asr #1
	sub	x9, x9, #1              // =1
	str	x9, [x0, #32]
	ldr	x8, [x11, #24]
	blr	x8
	b	.LBB0_6
.Lfunc_end0:
	.size	v8::internal::Scanner::Next(), .Lfunc_end0-v8::internal::Scanner::Next()
	.cfi_endproc
                                        // -- End function
	.type	v8::internal::one_char_tokens,@object // @v8::internal::one_char_tokens
	.section	.rodata,"a",@progbits
v8::internal::one_char_tokens:
	.ascii	"dddddddddddddddddddddddddddddddddddddddd\001\002dd\035ddddddddddddd\007\bddd\013ddddddddddddddddddddddddddd\003d\004ddddddddddddddddddddddddddddd\005d\0067d"
	.size	v8::internal::one_char_tokens, 128


	.ident	"clang version 6.0.0 "
	.section	".note.GNU-stack","",@progbits
