	.size	bitreverse_krukar_512, .-bitreverse_krukar_512
	.section	.text.bitreverse_krukar,"ax",%progbits
	.align	2
	.global	bitreverse_krukar
	.code	16
	.thumb_func
	.type	bitreverse_krukar, %function
bitreverse_krukar:
	.fnstart
.LFB22:
	.loc 1 251 0
	.save	{r3, r4, r5, r6, r7, lr}
	push	{r3, r4, r5, r6, r7, lr}
.LCFI16:
.LVL1727:
	.loc 1 256 0
	mov	r3, #128
	lsl	r3, r3, #2
	cmp	r0, r3
	ble	.L169
	.loc 1 261 0
	asr	r6, r0, #1
.LVL1728:
	.loc 1 263 0
	mov	r4, #0
.LVL1729:
.L166:
	.loc 1 267 0
	mov	r2, r6
.LVL1730:
	mov	r3, #1
.LVL1731:
	.loc 1 265 0
	mov	r5, #0
.LVL1732:
	b	.L164
.LVL1733:
.L170:
	.loc 1 267 0
	asr	r2, r2, #1
.LVL1734:
.L164:
	.loc 1 268 0
	tst	r3, r4
	beq	.L162
	.loc 1 269 0
	orr	r5, r5, r2
.L162:
	.loc 1 267 0
	lsl	r3, r3, #1
	cmp	r0, r3
	bgt	.L170
	.loc 1 271 0
	cmp	r5, r4
	ble	.L165
	.loc 1 272 0
	lsl	r3, r4, #3
.LVL1735:
	.loc 1 273 0
	lsl	r5, r5, #3
.LVL1736:
	.loc 1 272 0
	add	r3, r1, r3
.LVL1737:
	.loc 1 273 0
	add	r5, r1, r5
.LVL1738:
	.loc 1 275 0
	ldr	r2, [r3]
.LVL1739:
	.loc 1 276 0
	ldr	r7, [r5]
	str	r7, [r3]
	.loc 1 277 0
	str	r2, [r5]
	.loc 1 282 0
	ldr	r2, [r3, #4]
.LVL1740:
	.loc 1 283 0
	ldr	r7, [r5, #4]
	str	r7, [r3, #4]
	.loc 1 284 0
	str	r2, [r5, #4]
.LVL1741:
.L165:
	.loc 1 263 0
	add	r4, r4, #1
	cmp	r4, r0
	bne	.L166
.L167:
	.loc 1 287 0
	@ sp needed for prologue
.LVL1742:
.LVL1743:
.LVL1744:
	pop	{r3, r4, r5, r6, r7, pc}
.LVL1745:
.L169:
	.loc 1 257 0
	bl	bitreverse_krukar_512
.LVL1746:
	.loc 1 258 0
	b	.L167
.LFE22:
	.fnend
	.size	bitreverse_krukar, .-bitreverse_krukar
