
loop_carried_low_words.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<zero_extended>:
               	mvn	x0, x0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	w0, w0
               	subs	x2, x2, #0x1
               	b.lo	<addr>
               	ldrb	w4, [x1], #0x1
               	eor	x4, x0, x4
               	and	x4, x4, #0xff
               	ldr	w4, [x3, x4, lsl #2]
               	eor	x0, x4, x0, lsr #8
               	subs	x2, x2, #0x1
               	b.hs	<addr>
               	mvn	x0, x0
               	ret

<zero_extended_ref>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mvn	x3, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	w3, [x29, #-0x8]
               	subs	x2, x2, #0x1
               	b.lo	<addr>
               	ldur	w3, [x29, #-0x8]
               	ldrb	w4, [x1], #0x1
               	eor	x3, x3, x4
               	and	x3, x3, #0xff
               	ldr	w3, [x0, x3, lsl #2]
               	ldur	w4, [x29, #-0x8]
               	eor	x3, x3, x4, lsr #8
               	stur	w3, [x29, #-0x8]
               	subs	x2, x2, #0x1
               	b.hs	<addr>
               	ldur	w0, [x29, #-0x8]
               	mvn	x0, x0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<sign_extended>:
               	mov	x17, #0x7c15            // =31765
               	movk	x17, #0x7f4a, lsl #16
               	movk	x17, #0x79b9, lsl #32
               	movk	x17, #0x9e37, lsl #48
               	mul	x0, x0, x17
               	mov	x3, #0x0                // =0
               	mov	x5, #0x2493             // =9363
               	movk	x5, #0x9249, lsl #16
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	sxtw	x0, w0
               	subs	x2, x2, #0x1
               	b.lo	<addr>
               	ldrb	w4, [x1], #0x1
               	ldrsw	x4, [x6, x4, lsl #2]
               	eor	x0, x4, x0, asr #3
               	mul	x4, x0, x5
               	asr	x4, x4, #34
               	add	x4, x4, x4, lsr #63
               	add	x3, x3, x4
               	subs	x2, x2, #0x1
               	b.hs	<addr>
               	eor	x0, x0, x3
               	ret

<sign_extended_ref>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x17, #0x7c15            // =31765
               	movk	x17, #0x7f4a, lsl #16
               	movk	x17, #0x79b9, lsl #32
               	movk	x17, #0x9e37, lsl #48
               	mul	x0, x0, x17
               	stur	w0, [x29, #-0x8]
               	mov	x3, #0x2493             // =9363
               	movk	x3, #0x9249, lsl #16
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	stur	xzr, [x29, #-0x10]
               	subs	x2, x2, #0x1
               	b.lo	<addr>
               	ldursw	x0, [x29, #-0x8]
               	ldrb	w5, [x1], #0x1
               	ldrsw	x5, [x4, x5, lsl #2]
               	eor	x0, x5, x0, asr #3
               	stur	w0, [x29, #-0x8]
               	ldur	x5, [x29, #-0x10]
               	ldursw	x0, [x29, #-0x8]
               	mul	x0, x0, x3
               	asr	x0, x0, #34
               	add	x0, x0, x0, lsr #63
               	add	x0, x5, x0
               	stur	x0, [x29, #-0x10]
               	subs	x2, x2, #0x1
               	b.hs	<addr>
               	ldursw	x0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x10]
               	eor	x0, x0, x1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<widened>:
               	lsr	x0, x0, #7
               	mov	x3, #0x0                // =0
               	mov	x4, #0x79b1             // =31153
               	movk	x4, #0x9e37, lsl #16
               	subs	x2, x2, #0x1
               	b.lo	<addr>
               	mul	x0, x0, x4
               	ldrb	w5, [x1], #0x1
               	add	x0, x0, x5
               	mov	w5, w0
               	add	x3, x3, x5, lsr #5
               	subs	x2, x2, #0x1
               	b.hs	<addr>
               	eor	x0, x0, x3
               	ret

<widened_ref>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	lsr	x0, x0, #7
               	stur	w0, [x29, #-0x8]
               	mov	x0, #0x79b1             // =31153
               	movk	x0, #0x9e37, lsl #16
               	stur	xzr, [x29, #-0x10]
               	subs	x2, x2, #0x1
               	b.lo	<addr>
               	ldur	w3, [x29, #-0x8]
               	mul	x3, x3, x0
               	ldrb	w4, [x1], #0x1
               	add	x3, x3, x4
               	stur	w3, [x29, #-0x8]
               	ldur	x3, [x29, #-0x10]
               	ldur	w4, [x29, #-0x8]
               	add	x3, x3, x4, lsr #5
               	stur	x3, [x29, #-0x10]
               	subs	x2, x2, #0x1
               	b.hs	<addr>
               	ldur	w0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x10]
               	eor	x0, x0, x1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x180]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x170]
               	add	x29, sp, #0x170
               	mov	x2, #0x0                // =0
               	mov	x3, #0x8320             // =33568
               	movk	x3, #0xedb8, lsl #16
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	mov	x1, #0x0                // =0
               	mov	x0, x2
               	eor	x4, x3, x0, lsr #1
               	lsr	x5, x0, #1
               	tst	x0, #0x1
               	csel	x0, x4, x5, ne
               	add	x1, x1, #0x1
               	cmp	w1, #0x8
               	b.lt	<addr>
               	str	w0, [x6, x2, lsl #2]
               	eor	x0, x0, #0x80000000
               	str	w0, [x7, x2, lsl #2]
               	add	x2, x2, #0x1
               	cmp	w2, #0x100
               	b.lo	<addr>
               	mov	x0, #0x0                // =0
               	mov	x1, #0x25               // =37
               	sub	x2, x29, #0x130
               	mul	x3, x0, x1
               	add	x3, x3, #0xb
               	and	x3, x3, #0xff
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x12c
               	b.lt	<addr>
               	sub	x21, x29, #0x148
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x21]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x21, #0x10]
               	mov	x20, #0x0               // =0
               	ldr	x0, [x21, x20, lsl #3]
               	sub	x22, x29, #0x130
               	mov	x2, #0x12c              // =300
               	mov	x1, x22
               	bl	<addr>
               	mov	x23, x0
               	ldr	x0, [x21, x20, lsl #3]
               	mov	x2, #0x12c              // =300
               	mov	x1, x22
               	bl	<addr>
               	cmp	w23, w0
               	b.ne	<addr>
               	sub	x22, x29, #0x148
               	ldr	x0, [x22, x20, lsl #3]
               	sub	x1, x29, #0x130
               	mov	x2, #0x0                // =0
               	bl	<addr>
               	mov	x23, x0
               	ldr	x0, [x22, x20, lsl #3]
               	sub	x1, x29, #0x130
               	mov	x2, #0x0                // =0
               	bl	<addr>
               	cmp	w23, w0
               	b.ne	<addr>
               	sub	x22, x29, #0x148
               	ldr	x0, [x22, x20, lsl #3]
               	sub	x1, x29, #0x130
               	mov	x2, #0x12c              // =300
               	bl	<addr>
               	mov	x23, x0
               	ldr	x0, [x22, x20, lsl #3]
               	sub	x1, x29, #0x130
               	mov	x2, #0x12c              // =300
               	bl	<addr>
               	cmp	w23, w0
               	b.ne	<addr>
               	sub	x22, x29, #0x148
               	ldr	x0, [x22, x20, lsl #3]
               	sub	x1, x29, #0x130
               	mov	x2, #0x0                // =0
               	bl	<addr>
               	mov	x23, x0
               	ldr	x0, [x22, x20, lsl #3]
               	sub	x1, x29, #0x130
               	mov	x2, #0x0                // =0
               	bl	<addr>
               	cmp	w23, w0
               	b.ne	<addr>
               	sub	x22, x29, #0x148
               	ldr	x0, [x22, x20, lsl #3]
               	sub	x1, x29, #0x130
               	mov	x2, #0x12c              // =300
               	bl	<addr>
               	mov	x23, x0
               	ldr	x0, [x22, x20, lsl #3]
               	sub	x1, x29, #0x130
               	mov	x2, #0x12c              // =300
               	bl	<addr>
               	cmp	w23, w0
               	b.ne	<addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0x3
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x170]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x180
               	ret
               	add	x0, x20, #0xd
               	ldp	x29, x30, [sp, #0x170]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x180
               	ret
               	add	x0, x20, #0xa
               	ldp	x29, x30, [sp, #0x170]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x180
               	ret
               	add	x0, x20, #0x7
               	ldp	x29, x30, [sp, #0x170]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x180
               	ret
               	add	x0, x20, #0x4
               	ldp	x29, x30, [sp, #0x170]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x180
               	ret
               	add	x0, x20, #0x1
               	ldp	x29, x30, [sp, #0x170]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x180
               	ret
