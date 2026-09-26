
goto_cleanup_shared.aarch64:	file format elf64-littleaarch64

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

<many>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	wzr, [x29, #-0x8]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x3, [x1]
               	add	x4, x3, #0x1
               	str	w4, [x1]
               	mov	x4, #0x61               // =97
               	strb	w4, [x2, x3]
               	ldrsw	x4, [x1]
               	strb	wzr, [x2, x4]
               	ldrsw	x4, [x1]
               	add	x5, x4, #0x1
               	str	w5, [x1]
               	mov	x5, #0x7c               // =124
               	strb	w5, [x2, x4]
               	ldrsw	x1, [x1]
               	strb	wzr, [x2, x1]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	w0, #0x2
               	b.eq	<addr>
               	cmp	w0, #0x3
               	b.eq	<addr>
               	sub	x1, x0, #0x3
               	sxtw	x1, w1
               	cmp	w1, #0x1
               	b.eq	<addr>
               	sub	x1, x0, #0x4
               	sxtw	x1, w1
               	cmp	w1, #0x1
               	b.eq	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x0, [x1]
               	add	x3, x0, #0x1
               	str	w3, [x1]
               	mov	x3, #0x2d               // =45
               	strb	w3, [x2, x0]
               	ldrsw	x3, [x1]
               	mov	x0, #0x0                // =0
               	strb	w0, [x2, x3]
               	ldrsw	x3, [x1]
               	add	x4, x3, #0x1
               	str	w4, [x1]
               	mov	x4, #0x61               // =97
               	strb	w4, [x2, x3]
               	ldrsw	x3, [x1]
               	strb	w0, [x2, x3]
               	ldrsw	x3, [x1]
               	add	x4, x3, #0x1
               	str	w4, [x1]
               	mov	x4, #0x2e               // =46
               	strb	w4, [x2, x3]
               	ldrsw	x1, [x1]
               	strb	w0, [x2, x1]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<nested>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x1, x0
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x8]
               	cmp	w1, #0x1
               	b.ne	<addr>
               	mov	x2, x0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x4, [x1]
               	add	x5, x4, #0x1
               	str	w5, [x1]
               	mov	x5, #0x61               // =97
               	strb	w5, [x3, x4]
               	ldrsw	x1, [x1]
               	strb	w0, [x3, x1]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x4, [x1]
               	add	x5, x4, #0x1
               	str	w5, [x1]
               	mov	x5, #0x7c               // =124
               	strb	w5, [x3, x4]
               	ldrsw	x1, [x1]
               	strb	w0, [x3, x1]
               	add	x0, x2, #0xa
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x2, x1, #0x1
               	cmp	w1, #0x2
               	b.ne	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x4, [x1]
               	add	x5, x4, #0x1
               	str	w5, [x1]
               	mov	x5, #0x61               // =97
               	strb	w5, [x3, x4]
               	ldrsw	x1, [x1]
               	strb	w0, [x3, x1]
               	b	<addr>
               	cmp	w1, #0x3
               	b.eq	<addr>
               	cmp	w1, #0x4
               	b.eq	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x4, [x1]
               	add	x5, x4, #0x1
               	str	w5, [x1]
               	mov	x5, #0x2d               // =45
               	strb	w5, [x3, x4]
               	ldrsw	x4, [x1]
               	strb	w0, [x3, x4]
               	ldrsw	x4, [x1]
               	add	x5, x4, #0x1
               	str	w5, [x1]
               	mov	x5, #0x61               // =97
               	strb	w5, [x3, x4]
               	ldrsw	x1, [x1]
               	strb	w0, [x3, x1]
               	mov	x0, x2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<lists>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	wzr, [x29, #-0x8]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x3, [x0]
               	add	x4, x3, #0x1
               	str	w4, [x0]
               	mov	x4, #0x61               // =97
               	strb	w4, [x2, x3]
               	ldrsw	x0, [x0]
               	strb	wzr, [x2, x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x3, [x0]
               	add	x4, x3, #0x1
               	str	w4, [x0]
               	mov	x4, #0x7c               // =124
               	strb	w4, [x2, x3]
               	ldrsw	x0, [x0]
               	strb	wzr, [x2, x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	wzr, [x29, #-0x8]
               	cmp	w0, #0x2
               	b.ne	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x3, [x0]
               	add	x4, x3, #0x1
               	str	w4, [x0]
               	mov	x4, #0x62               // =98
               	strb	w4, [x2, x3]
               	ldrsw	x3, [x0]
               	strb	wzr, [x2, x3]
               	ldrsw	x3, [x0]
               	add	x4, x3, #0x1
               	str	w4, [x0]
               	mov	x4, #0x61               // =97
               	strb	w4, [x2, x3]
               	ldrsw	x0, [x0]
               	strb	wzr, [x2, x0]
               	b	<addr>
               	cmp	w0, #0x3
               	b.eq	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x3, [x0]
               	add	x4, x3, #0x1
               	str	w4, [x0]
               	mov	x4, #0x2d               // =45
               	strb	w4, [x2, x3]
               	ldrsw	x3, [x0]
               	strb	wzr, [x2, x3]
               	ldrsw	x3, [x0]
               	add	x4, x3, #0x1
               	str	w4, [x0]
               	mov	x4, #0x62               // =98
               	strb	w4, [x2, x3]
               	ldrsw	x3, [x0]
               	strb	wzr, [x2, x3]
               	ldrsw	x3, [x0]
               	add	x4, x3, #0x1
               	str	w4, [x0]
               	mov	x4, #0x61               // =97
               	strb	w4, [x2, x3]
               	ldrsw	x0, [x0]
               	strb	wzr, [x2, x0]
               	b	<addr>

<vla>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x9, #0x10               // =16
               	mov	x0, #0x0                // =0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x4, x0
               	mov	x5, x0
               	stur	wzr, [x29, #-0x10]
               	mov	x7, sp
               	add	x17, x9, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x6, sp
               	sub	x6, x6, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x6
               	strb	w0, [x6]
               	cbnz	x5, <addr>
               	mov	x5, x6
               	cmp	w1, #0x1
               	b.ne	<addr>
               	tbz	w0, #0x0, <addr>
               	ldrsw	x6, [x2]
               	add	x8, x6, #0x1
               	str	w8, [x2]
               	mov	x8, #0x61               // =97
               	strb	w8, [x3, x6]
               	ldrsw	x6, [x2]
               	strb	wzr, [x3, x6]
               	mov	sp, x7
               	b	<addr>
               	cmp	w1, #0x1
               	b.eq	<addr>
               	ldrsw	x6, [x2]
               	add	x8, x6, #0x1
               	str	w8, [x2]
               	mov	x8, #0x2d               // =45
               	strb	w8, [x3, x6]
               	ldrsw	x8, [x2]
               	strb	wzr, [x3, x8]
               	ldrsw	x8, [x2]
               	add	x10, x8, #0x1
               	str	w10, [x2]
               	mov	x10, #0x61              // =97
               	strb	w10, [x3, x8]
               	ldrsw	x8, [x2]
               	strb	wzr, [x3, x8]
               	mov	sp, x7
               	b	<addr>
               	cmp	x6, x5
               	b.eq	<addr>
               	mov	x4, #0x1                // =1
               	b	<addr>
               	ldrsw	x6, [x2]
               	add	x7, x6, #0x1
               	str	w7, [x2]
               	mov	x7, #0x2e               // =46
               	strb	w7, [x3, x6]
               	ldrsw	x6, [x2]
               	strb	wzr, [x3, x6]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	mov	x0, x4
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	add	x2, x2, #0x1
               	str	w2, [x1]
               	cbz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	cbnz	w2, <addr>
               	ldrsw	x1, [x1]
               	str	w1, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	cbz	x3, <addr>
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldrb	w3, [x1, x0]
               	cbnz	x3, <addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldrb	w1, [x20, x0]
               	ldrb	w0, [x2, x0]
               	cmp	w1, w0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	ldrsw	x0, [x0]
               	str	w0, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	wzr, [x1]
               	strb	wzr, [x20]
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	w0, #0x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	ldrsw	x0, [x0]
               	str	w0, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x20, x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x20, x0]
               	ldrb	w3, [x1, x0]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldrb	w2, [x20, x0]
               	cbnz	x2, <addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldrb	w2, [x20, x0]
               	ldrb	w0, [x1, x0]
               	cmp	w2, w0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	ldrsw	x0, [x0]
               	str	w0, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	wzr, [x1]
               	strb	wzr, [x20]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	cmp	w0, #0x2
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	ldrsw	x0, [x0]
               	str	w0, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x20, x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x20, x0]
               	ldrb	w3, [x1, x0]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldrb	w2, [x20, x0]
               	cbnz	x2, <addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldrb	w2, [x20, x0]
               	ldrb	w0, [x1, x0]
               	cmp	w2, w0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	ldrsw	x0, [x0]
               	str	w0, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	wzr, [x1]
               	strb	wzr, [x20]
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	cmp	w0, #0x3
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	ldrsw	x0, [x0]
               	str	w0, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x20, x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x20, x0]
               	ldrb	w3, [x1, x0]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldrb	w2, [x20, x0]
               	cbnz	x2, <addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldrb	w2, [x20, x0]
               	ldrb	w0, [x1, x0]
               	cmp	w2, w0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	ldrsw	x0, [x0]
               	str	w0, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	wzr, [x1]
               	strb	wzr, [x20]
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	cmp	w0, #0x4
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	ldrsw	x0, [x0]
               	str	w0, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x20, x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x20, x0]
               	ldrb	w3, [x1, x0]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldrb	w2, [x20, x0]
               	cbnz	x2, <addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldrb	w2, [x20, x0]
               	ldrb	w0, [x1, x0]
               	cmp	w2, w0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	ldrsw	x0, [x0]
               	str	w0, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	wzr, [x1]
               	strb	wzr, [x20]
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	cmp	w0, #0x5
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	ldrsw	x0, [x0]
               	str	w0, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x20, x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x20, x0]
               	ldrb	w3, [x1, x0]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldrb	w2, [x20, x0]
               	cbnz	x2, <addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldrb	w2, [x20, x0]
               	ldrb	w0, [x1, x0]
               	cmp	w2, w0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	ldrsw	x0, [x0]
               	str	w0, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x1]
               	strb	w0, [x20]
               	bl	<addr>
               	cmp	w0, #0x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	ldrsw	x0, [x0]
               	str	w0, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x20, x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x20, x0]
               	ldrb	w3, [x1, x0]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldrb	w2, [x20, x0]
               	cbnz	x2, <addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldrb	w2, [x20, x0]
               	ldrb	w0, [x1, x0]
               	cmp	w2, w0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	ldrsw	x0, [x0]
               	str	w0, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	wzr, [x1]
               	strb	wzr, [x20]
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	w0, #0xa
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	ldrsw	x0, [x0]
               	str	w0, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x20, x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x20, x0]
               	ldrb	w3, [x1, x0]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldrb	w2, [x20, x0]
               	cbnz	x2, <addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldrb	w2, [x20, x0]
               	ldrb	w0, [x1, x0]
               	cmp	w2, w0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	ldrsw	x0, [x0]
               	str	w0, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	wzr, [x1]
               	strb	wzr, [x20]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	cmp	w0, #0xd
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	ldrsw	x0, [x0]
               	str	w0, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x20, x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x20, x0]
               	ldrb	w3, [x1, x0]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldrb	w2, [x20, x0]
               	cbnz	x2, <addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldrb	w2, [x20, x0]
               	ldrb	w0, [x1, x0]
               	cmp	w2, w0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	ldrsw	x0, [x0]
               	str	w0, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	wzr, [x1]
               	strb	wzr, [x20]
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	cmp	w0, #0xe
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	ldrsw	x0, [x0]
               	str	w0, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x20, x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x20, x0]
               	ldrb	w3, [x1, x0]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldrb	w2, [x20, x0]
               	cbnz	x2, <addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldrb	w2, [x20, x0]
               	ldrb	w0, [x1, x0]
               	cmp	w2, w0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	ldrsw	x0, [x0]
               	str	w0, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	wzr, [x1]
               	strb	wzr, [x20]
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	cmp	w0, #0xf
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	ldrsw	x0, [x0]
               	str	w0, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x20, x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x20, x0]
               	ldrb	w3, [x1, x0]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldrb	w2, [x20, x0]
               	cbnz	x2, <addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldrb	w2, [x20, x0]
               	ldrb	w0, [x1, x0]
               	cmp	w2, w0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	ldrsw	x0, [x0]
               	str	w0, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x1]
               	strb	w0, [x20]
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x20, x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x20, x0]
               	ldrb	w3, [x1, x0]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldrb	w2, [x20, x0]
               	cbnz	x2, <addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldrb	w2, [x20, x0]
               	ldrb	w0, [x1, x0]
               	cmp	w2, w0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	ldrsw	x0, [x0]
               	str	w0, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	wzr, [x1]
               	strb	wzr, [x20]
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x20, x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x20, x0]
               	ldrb	w3, [x1, x0]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldrb	w2, [x20, x0]
               	cbnz	x2, <addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldrb	w2, [x20, x0]
               	ldrb	w0, [x1, x0]
               	cmp	w2, w0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	ldrsw	x0, [x0]
               	str	w0, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	wzr, [x1]
               	strb	wzr, [x20]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x20, x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x20, x0]
               	ldrb	w3, [x1, x0]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldrb	w2, [x20, x0]
               	cbnz	x2, <addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldrb	w2, [x20, x0]
               	ldrb	w0, [x1, x0]
               	cmp	w2, w0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	ldrsw	x0, [x0]
               	str	w0, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	wzr, [x1]
               	strb	wzr, [x20]
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x20, x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x20, x0]
               	ldrb	w3, [x1, x0]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldrb	w2, [x20, x0]
               	cbnz	x2, <addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldrb	w2, [x20, x0]
               	ldrb	w0, [x1, x0]
               	cmp	w2, w0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	ldrsw	x0, [x0]
               	str	w0, [x1]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	strb	w1, [x20]
               	mov	x0, #0x10               // =16
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	add	x2, x2, #0x1
               	str	w2, [x1]
               	cbz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	cbnz	w2, <addr>
               	ldrsw	x1, [x1]
               	str	w1, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x20, x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x20, x0]
               	ldrb	w3, [x1, x0]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldrb	w2, [x20, x0]
               	cbnz	x2, <addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldrb	w2, [x20, x0]
               	ldrb	w0, [x1, x0]
               	cmp	w2, w0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	ldrsw	x0, [x0]
               	str	w0, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	wzr, [x1]
               	strb	wzr, [x20]
               	mov	x0, #0x10               // =16
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	add	x2, x2, #0x1
               	str	w2, [x1]
               	cbz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	cbnz	w2, <addr>
               	ldrsw	x1, [x1]
               	str	w1, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x20, x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x20, x0]
               	ldrb	w3, [x1, x0]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldrb	w2, [x20, x0]
               	cbnz	x2, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w3, [x2, x0]
               	ldrb	w0, [x1, x0]
               	cmp	w3, w0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x3, [x0]
               	add	x3, x3, #0x1
               	str	w3, [x0]
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x3, [x1]
               	cbnz	w3, <addr>
               	ldrsw	x0, [x0]
               	str	w0, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	wzr, [x1]
               	strb	wzr, [x2]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
