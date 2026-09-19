
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
               	mov	x1, #0x1                // =1
               	strb	w1, [x0]
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
               	sub	x3, x1, #0x1
               	sub	x1, x2, #0x1
               	add	x4, x0, #0x1
               	ldrb	w0, [x0]
               	strb	w0, [x2]
               	mov	x2, x1
               	mov	x1, x3
               	mov	x0, x4
               	sub	x3, x1, #0x1
               	cbnz	w1, <addr>
               	mov	x3, #0x0                // =0
               	sub	x0, x29, #0x8
               	ldrb	w1, [x0]
               	cmp	w1, #0x8
               	b.eq	<addr>
               	add	x0, x3, #0xa
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x1                // =1
               	ldrb	w2, [x0, #0x1]
               	cmp	w2, #0x7
               	b.eq	<addr>
               	mov	x3, x1
               	b	<addr>
               	mov	x1, #0x2                // =2
               	ldrb	w2, [x0, #0x2]
               	cmp	w2, #0x6
               	b.eq	<addr>
               	mov	x3, x1
               	b	<addr>
               	mov	x1, #0x3                // =3
               	ldrb	w2, [x0, #0x3]
               	cmp	w2, #0x5
               	b.eq	<addr>
               	mov	x3, x1
               	b	<addr>
               	mov	x1, #0x4                // =4
               	ldrb	w2, [x0, #0x4]
               	cmp	w2, #0x4
               	b.eq	<addr>
               	mov	x3, x1
               	b	<addr>
               	mov	x1, #0x5                // =5
               	ldrb	w2, [x0, #0x5]
               	cmp	w2, #0x3
               	b.eq	<addr>
               	mov	x3, x1
               	b	<addr>
               	mov	x1, #0x6                // =6
               	ldrb	w2, [x0, #0x6]
               	cmp	w2, #0x2
               	b.eq	<addr>
               	mov	x3, x1
               	b	<addr>
               	mov	x1, #0x7                // =7
               	ldrb	w2, [x0, #0x7]
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x3, x1
               	b	<addr>
               	sub	x1, x29, #0x10
               	mov	x2, #0x8                // =8
               	sub	x4, x2, #0x1
               	add	x2, x0, #0x1
               	add	x5, x1, #0x1
               	ldrb	w1, [x1]
               	strb	w1, [x0]
               	mov	x0, x2
               	mov	x2, x4
               	mov	x1, x5
               	sub	x4, x2, #0x1
               	cbnz	w2, <addr>
               	sub	x0, x29, #0x8
               	ldrb	w1, [x0]
               	cmp	w1, #0x1
               	b.eq	<addr>
               	add	x0, x3, #0x14
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x1                // =1
               	ldrb	w1, [x0, #0x1]
               	cmp	w1, #0x2
               	b.ne	<addr>
               	mov	x3, #0x2                // =2
               	ldrb	w1, [x0, #0x2]
               	cmp	w1, #0x3
               	b.ne	<addr>
               	mov	x3, #0x3                // =3
               	ldrb	w1, [x0, #0x3]
               	cmp	w1, #0x4
               	b.ne	<addr>
               	mov	x3, #0x4                // =4
               	ldrb	w1, [x0, #0x4]
               	cmp	w1, #0x5
               	b.ne	<addr>
               	mov	x3, #0x5                // =5
               	ldrb	w1, [x0, #0x5]
               	cmp	w1, #0x6
               	b.ne	<addr>
               	mov	x3, #0x6                // =6
               	ldrb	w1, [x0, #0x6]
               	cmp	w1, #0x7
               	b.ne	<addr>
               	mov	x3, #0x7                // =7
               	ldrb	w0, [x0, #0x7]
               	cmp	w0, #0x8
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
