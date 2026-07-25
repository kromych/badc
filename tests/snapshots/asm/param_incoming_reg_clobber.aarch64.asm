
param_incoming_reg_clobber.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x8
               	add	x0, x0, #0x0
               	mov	x1, #0x1                // =1
               	strb	w1, [x0]
               	sub	x0, x29, #0x8
               	mov	x1, #0x2                // =2
               	strb	w1, [x0, #0x1]
               	sub	x0, x29, #0x8
               	mov	x1, #0x3                // =3
               	strb	w1, [x0, #0x2]
               	sub	x0, x29, #0x8
               	mov	x1, #0x4                // =4
               	strb	w1, [x0, #0x3]
               	sub	x0, x29, #0x8
               	mov	x1, #0x5                // =5
               	strb	w1, [x0, #0x4]
               	sub	x0, x29, #0x8
               	mov	x1, #0x6                // =6
               	strb	w1, [x0, #0x5]
               	sub	x0, x29, #0x8
               	mov	x1, #0x7                // =7
               	strb	w1, [x0, #0x6]
               	sub	x0, x29, #0x8
               	mov	x1, #0x8                // =8
               	strb	w1, [x0, #0x7]
               	sub	x0, x29, #0x10
               	sub	x1, x29, #0x8
               	mov	x2, #0x8                // =8
               	stur	x2, [x29, #-0x18]
               	ldur	w2, [x29, #-0x18]
               	sub	x2, x2, #0x1
               	mov	w2, w2
               	add	x0, x0, x2
               	b	<addr>
               	sub	x2, x0, #0x1
               	add	x3, x1, #0x1
               	ldrb	w1, [x1]
               	strb	w1, [x0]
               	mov	x0, x2
               	mov	x1, x3
               	ldur	w2, [x29, #-0x18]
               	sub	x3, x2, #0x1
               	stur	w3, [x29, #-0x18]
               	cmp	x2, #0x0
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x10
               	add	x2, x2, x1
               	ldrb	w3, [x2]
               	mov	x2, #0x8                // =8
               	sub	x2, x2, x1
               	sxtw	x2, w2
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	cmp	x3, x2
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x8
               	b.lt	<addr>
               	sub	x1, x29, #0x10
               	sub	x2, x29, #0x8
               	mov	x3, #0x8                // =8
               	mov	x0, #0x0                // =0
               	stur	x3, [x29, #-0x18]
               	ldur	w3, [x29, #-0x18]
               	stur	x3, [x29, #-0x18]
               	b	<addr>
               	add	x3, x1, #0x1
               	add	x4, x2, #0x1
               	ldrb	w2, [x2]
               	strb	w2, [x1]
               	mov	x1, x3
               	mov	x2, x4
               	ldur	w3, [x29, #-0x18]
               	sub	x4, x3, #0x1
               	stur	w4, [x29, #-0x18]
               	cmp	x3, #0x0
               	b.ne	<addr>
               	b	<addr>
               	sub	x2, x29, #0x10
               	add	x2, x2, x1
               	ldrb	w3, [x2]
               	add	x2, x1, #0x1
               	sxtw	x2, w2
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	cmp	x3, x2
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x8
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x0, #0x14
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x0, #0xa
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
