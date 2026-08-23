
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
               	sub	sp, sp, #0x20
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
               	mov	x3, #0x8                // =8
               	strb	w3, [x0, #0x7]
               	sub	x4, x29, #0x8
               	stur	x3, [x29, #-0x18]
               	ldur	w1, [x29, #-0x18]
               	sub	x1, x1, #0x1
               	mov	w1, w1
               	add	x1, x4, x1
               	b	<addr>
               	sub	x2, x1, #0x1
               	add	x5, x0, #0x1
               	ldrb	w0, [x0]
               	strb	w0, [x1]
               	mov	x1, x2
               	mov	x0, x5
               	ldur	w2, [x29, #-0x18]
               	sub	x5, x2, #0x1
               	stur	w5, [x29, #-0x18]
               	cbnz	x2, <addr>
               	mov	x0, #0x0                // =0
               	mov	x5, #0xff               // =255
               	b	<addr>
               	sxtw	x1, w0
               	add	x2, x4, x1
               	ldrb	w6, [x2]
               	sub	x2, x3, x1
               	and	x2, x2, x5
               	cmp	w6, w2
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x3, x29, #0x8
               	sub	x1, x29, #0x10
               	mov	x2, #0x8                // =8
               	mov	x0, #0x0                // =0
               	stur	x2, [x29, #-0x18]
               	ldur	w2, [x29, #-0x18]
               	stur	x2, [x29, #-0x18]
               	mov	x4, x3
               	b	<addr>
               	add	x2, x4, #0x1
               	add	x5, x1, #0x1
               	ldrb	w1, [x1]
               	strb	w1, [x4]
               	mov	x4, x2
               	mov	x1, x5
               	ldur	w2, [x29, #-0x18]
               	sub	x5, x2, #0x1
               	stur	w5, [x29, #-0x18]
               	cbnz	x2, <addr>
               	mov	x4, #0xff               // =255
               	b	<addr>
               	sxtw	x1, w0
               	add	x2, x3, x1
               	ldrb	w5, [x2]
               	add	x2, x1, #0x1
               	and	x2, x2, x4
               	cmp	w5, w2
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x0, #0x14
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x0, #0xa
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
