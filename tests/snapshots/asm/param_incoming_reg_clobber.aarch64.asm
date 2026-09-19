
param_incoming_reg_clobber.aarch64:	file format elf64-littleaarch64

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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x10
               	add	x1, x0, #0x0
               	mov	x2, #0x1                // =1
               	strb	w2, [x1]
               	mov	x1, #0x2                // =2
               	strb	w1, [x0, #0x1]
               	mov	x1, #0x3                // =3
               	strb	w1, [x0, #0x2]
               	mov	x1, #0x4                // =4
               	strb	w1, [x0, #0x3]
               	mov	x1, #0x5                // =5
               	strb	w1, [x0, #0x4]
               	mov	x1, #0x6                // =6
               	strb	w1, [x0, #0x5]
               	mov	x1, #0x7                // =7
               	strb	w1, [x0, #0x6]
               	mov	x1, #0x8                // =8
               	strb	w1, [x0, #0x7]
               	sub	x2, x29, #0x8
               	add	x2, x2, #0x7
               	mov	w3, w1
               	sub	x1, x3, #0x1
               	cbz	x3, <addr>
               	sub	x3, x2, #0x1
               	add	x4, x0, #0x1
               	ldrb	w0, [x0]
               	strb	w0, [x2]
               	mov	x2, x3
               	mov	x0, x4
               	mov	w3, w1
               	sub	x1, x3, #0x1
               	cbnz	x3, <addr>
               	mov	x4, #0x0                // =0
               	sub	x0, x29, #0x8
               	add	x1, x0, #0x0
               	ldrb	w1, [x1]
               	cmp	w1, #0x8
               	b.eq	<addr>
               	add	x0, x4, #0xa
               	sxtw	x0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x1                // =1
               	ldrb	w2, [x0, #0x1]
               	cmp	w2, #0x7
               	b.eq	<addr>
               	mov	x4, x1
               	b	<addr>
               	mov	x1, #0x2                // =2
               	ldrb	w2, [x0, #0x2]
               	cmp	w2, #0x6
               	b.eq	<addr>
               	mov	x4, x1
               	b	<addr>
               	mov	x1, #0x3                // =3
               	ldrb	w2, [x0, #0x3]
               	cmp	w2, #0x5
               	b.eq	<addr>
               	mov	x4, x1
               	b	<addr>
               	mov	x1, #0x4                // =4
               	ldrb	w2, [x0, #0x4]
               	cmp	w2, #0x4
               	b.eq	<addr>
               	mov	x4, x1
               	b	<addr>
               	mov	x1, #0x5                // =5
               	ldrb	w2, [x0, #0x5]
               	cmp	w2, #0x3
               	b.eq	<addr>
               	mov	x4, x1
               	b	<addr>
               	mov	x1, #0x6                // =6
               	ldrb	w2, [x0, #0x6]
               	cmp	w2, #0x2
               	b.eq	<addr>
               	mov	x4, x1
               	b	<addr>
               	mov	x1, #0x7                // =7
               	ldrb	w2, [x0, #0x7]
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x4, x1
               	b	<addr>
               	sub	x1, x29, #0x10
               	mov	x2, #0x8                // =8
               	mov	w3, w2
               	sub	x2, x3, #0x1
               	cbz	x3, <addr>
               	add	x3, x0, #0x1
               	add	x5, x1, #0x1
               	ldrb	w1, [x1]
               	strb	w1, [x0]
               	mov	x0, x3
               	mov	x1, x5
               	mov	w3, w2
               	sub	x2, x3, #0x1
               	cbnz	x3, <addr>
               	sub	x0, x29, #0x8
               	add	x1, x0, #0x0
               	ldrb	w1, [x1]
               	cmp	w1, #0x1
               	b.eq	<addr>
               	add	x0, x4, #0x14
               	sxtw	x0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x4, #0x1                // =1
               	ldrb	w1, [x0, #0x1]
               	cmp	w1, #0x2
               	b.ne	<addr>
               	mov	x4, #0x2                // =2
               	ldrb	w1, [x0, #0x2]
               	cmp	w1, #0x3
               	b.ne	<addr>
               	mov	x4, #0x3                // =3
               	ldrb	w1, [x0, #0x3]
               	cmp	w1, #0x4
               	b.ne	<addr>
               	mov	x4, #0x4                // =4
               	ldrb	w1, [x0, #0x4]
               	cmp	w1, #0x5
               	b.ne	<addr>
               	mov	x4, #0x5                // =5
               	ldrb	w1, [x0, #0x5]
               	cmp	w1, #0x6
               	b.ne	<addr>
               	mov	x4, #0x6                // =6
               	ldrb	w1, [x0, #0x6]
               	cmp	w1, #0x7
               	b.ne	<addr>
               	mov	x4, #0x7                // =7
               	ldrb	w0, [x0, #0x7]
               	cmp	w0, #0x8
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
