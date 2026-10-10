
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
               	sub	x2, x29, #0x10
               	mov	x0, #0x1                // =1
               	sturb	w0, [x29, #-0x10]
               	mov	x0, #0x2                // =2
               	sturb	w0, [x29, #-0xf]
               	mov	x0, #0x3                // =3
               	sturb	w0, [x29, #-0xe]
               	mov	x0, #0x4                // =4
               	sturb	w0, [x29, #-0xd]
               	mov	x0, #0x5                // =5
               	sturb	w0, [x29, #-0xc]
               	mov	x0, #0x6                // =6
               	sturb	w0, [x29, #-0xb]
               	mov	x0, #0x7                // =7
               	sturb	w0, [x29, #-0xa]
               	mov	x0, #0x8                // =8
               	sturb	w0, [x29, #-0x9]
               	sub	x1, x29, #0x8
               	add	x1, x1, #0x7
               	sub	x3, x0, #0x1
               	sub	x0, x1, #0x1
               	add	x4, x2, #0x1
               	ldrb	w2, [x2]
               	strb	w2, [x1]
               	mov	x1, x0
               	mov	x0, x3
               	mov	x2, x4
               	sub	x3, x0, #0x1
               	cbnz	w0, <addr>
               	mov	x1, #0x0                // =0
               	sub	x0, x29, #0x8
               	ldurb	w2, [x29, #-0x8]
               	cmp	w2, #0x8
               	b.eq	<addr>
               	add	x0, x1, #0xa
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x1                // =1
               	ldurb	w2, [x29, #-0x7]
               	cmp	w2, #0x7
               	b.ne	<addr>
               	mov	x1, #0x2                // =2
               	ldurb	w2, [x29, #-0x6]
               	cmp	w2, #0x6
               	b.ne	<addr>
               	mov	x1, #0x3                // =3
               	ldurb	w2, [x29, #-0x5]
               	cmp	w2, #0x5
               	b.ne	<addr>
               	mov	x1, #0x4                // =4
               	ldurb	w2, [x29, #-0x4]
               	cmp	w2, #0x4
               	b.ne	<addr>
               	mov	x1, #0x5                // =5
               	ldurb	w2, [x29, #-0x3]
               	cmp	w2, #0x3
               	b.ne	<addr>
               	mov	x1, #0x6                // =6
               	ldurb	w2, [x29, #-0x2]
               	cmp	w2, #0x2
               	b.ne	<addr>
               	mov	x1, #0x7                // =7
               	ldurb	w2, [x29, #-0x1]
               	cmp	w2, #0x1
               	b.ne	<addr>
               	sub	x1, x29, #0x10
               	mov	x2, #0x8                // =8
               	sub	x3, x2, #0x1
               	add	x2, x0, #0x1
               	add	x4, x1, #0x1
               	ldrb	w1, [x1]
               	strb	w1, [x0]
               	mov	x0, x2
               	mov	x2, x3
               	mov	x1, x4
               	sub	x3, x2, #0x1
               	cbnz	w2, <addr>
               	mov	x0, #0x0                // =0
               	ldurb	w1, [x29, #-0x8]
               	cmp	w1, #0x1
               	b.eq	<addr>
               	add	x0, x0, #0x14
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x1                // =1
               	ldurb	w2, [x29, #-0x7]
               	cmp	w2, #0x2
               	b.eq	<addr>
               	mov	x0, x1
               	b	<addr>
               	mov	x1, #0x2                // =2
               	ldurb	w2, [x29, #-0x6]
               	cmp	w2, #0x3
               	b.eq	<addr>
               	mov	x0, x1
               	b	<addr>
               	mov	x1, #0x3                // =3
               	ldurb	w2, [x29, #-0x5]
               	cmp	w2, #0x4
               	b.eq	<addr>
               	mov	x0, x1
               	b	<addr>
               	mov	x1, #0x4                // =4
               	ldurb	w2, [x29, #-0x4]
               	cmp	w2, #0x5
               	b.eq	<addr>
               	mov	x0, x1
               	b	<addr>
               	mov	x1, #0x5                // =5
               	ldurb	w2, [x29, #-0x3]
               	cmp	w2, #0x6
               	b.eq	<addr>
               	mov	x0, x1
               	b	<addr>
               	mov	x1, #0x6                // =6
               	ldurb	w2, [x29, #-0x2]
               	cmp	w2, #0x7
               	b.eq	<addr>
               	mov	x0, x1
               	b	<addr>
               	mov	x1, #0x7                // =7
               	ldurb	w2, [x29, #-0x1]
               	cmp	w2, #0x8
               	b.eq	<addr>
               	mov	x0, x1
               	b	<addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
