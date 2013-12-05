.section	.text.bitreverse_gold_rader_ref,"ax",%progbits
	.align	2
	.global	bitreverse_gold_rader_ref
	.code	16
	.thumb_func
	.type	bitreverse_gold_rader_ref, %function
bitreverse_gold_rader_ref:
	.fnstart
.LFB15:
	.file 1 "/home/karel/Documents/SVN/devogele/programs/bit-reverse/trunk/jni/reverse.c"
	.loc 1 21 0
	.save	{r4, r5, r6, r7, lr}
	push	{r4, r5, r6, r7, lr}
.LCFI0:
	mov	r7, r9
	mov	r6, r8
	.save	{r8, r9}
	push	{r6, r7}
.LCFI1:
.LVL0:
	.loc 1 24 0
	lsr	r3, r0, #31
	add	r0, r3, r0
.LVL1:
	asr	r7, r0, #1
	.loc 1 21 0
	.pad #20
	sub	sp, sp, #20
.LCFI2:
	.loc 1 29 0
	cmp	r7, #1
	ble	.L9
.LBB2:
	.loc 1 35 0
	asr	r0, r0, #2
.LVL2:
	.loc 1 21 0
	sub	r7, r7, #1
	.loc 1 27 0
	mov	r3, #0
.LVL3:
	.loc 1 26 0
	mov	r2, #0
.LVL4:
.L14:
	.loc 1 46 0
	mov	r4, r0
	cmp	r3, r0
	blt	.L6
.L11:
	.loc 1 48 0
	sub	r3, r3, r4
.LVL5:
	.loc 1 50 0
	asr	r4, r4, #1
.LVL6:
	.loc 1 46 0
	cmp	r3, r4
	bge	.L11
.LVL7:
.L6:
.LBE2:
	.loc 1 29 0
	add	r2, r2, #1
.LVL8:
	cmp	r2, r7
	beq	.L9
.LBB4:
	.loc 1 52 0
	add	r3, r3, r4
.LVL9:
	.loc 1 37 0
	cmp	r3, r2
	ble	.L14
.LBB3:
	.loc 1 38 0
	lsl	r6, r2, #4
	add	r6, r6, r1
	ldr	r4, [r6]
	ldr	r5, [r6, #4]
.LVL10:
	str	r4, [sp, #8]
	str	r5, [sp, #12]
	.loc 1 39 0
	lsl	r5, r2, #4
	add	r5, r5, #8
	add	r5, r5, r1
	mov	r8, r5
	ldr	r4, [r5]
	ldr	r5, [r5, #4]
	str	r4, [sp]
	str	r5, [sp, #4]
	.loc 1 40 0
	lsl	r4, r3, #4
	add	r4, r4, r1
	mov	ip, r4
	ldr	r5, [r4, #4]
	ldr	r4, [r4]
	str	r4, [r6]
	str	r5, [r6, #4]
	.loc 1 41 0
	lsl	r6, r3, #4
	add	r6, r6, #8
	add	r6, r6, r1
	mov	r4, r8
	mov	r9, r6
	ldr	r5, [r6]
	ldr	r6, [r6, #4]
	str	r5, [r4]
	str	r6, [r4, #4]
	.loc 1 42 0
	ldr	r4, [sp, #8]
	ldr	r5, [sp, #12]
	mov	r6, ip
	str	r4, [r6]
	str	r5, [r6, #4]
	.loc 1 43 0
	ldr	r4, [sp]
	ldr	r5, [sp, #4]
	mov	r6, r9
	str	r4, [r6]
	str	r5, [r6, #4]
	b	.L14
.LVL11:
.L9:
.LBE3:
.LBE4:
	.loc 1 54 0
	add	sp, sp, #20
	@ sp needed for prologue
.LVL12:
	pop	{r2, r3}
	mov	r8, r2
	mov	r9, r3
	pop	{r4, r5, r6, r7, pc}
.LFE15:
	.fnend
