
param_incoming_reg_clobber.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x2, [sp, #-0x10]!
               	sub	sp, sp, #0x20
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	stur	x2, [x29, #0x30]
               	b	<addr>
               	add	x2, x0, #0x1
               	add	x3, x1, #0x1
               	ldrb	w1, [x1]
               	strb	w1, [x0]
               	mov	x0, x2
               	mov	x1, x3
               	ldur	w2, [x29, #0x30]
               	sub	x3, x2, #0x1
               	stur	w3, [x29, #0x30]
               	cmp	x2, #0x0
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x30
               	ret

<swap_or_copy>:
               	sub	sp, sp, #0x10
               	str	x2, [sp, #-0x10]!
               	sub	sp, sp, #0x20
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sxtw	x3, w3
               	stur	x2, [x29, #0x30]
               	cmp	x3, #0x0
               	b.ne	<addr>
               	ldur	w2, [x29, #0x30]
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x40
               	ret
               	ldur	w2, [x29, #0x30]
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
               	ldur	w2, [x29, #0x30]
               	sub	x3, x2, #0x1
               	stur	w3, [x29, #0x30]
               	cmp	x2, #0x0
               	b.eq	<addr>
               	b	<addr>
               	b	<addr>

<main>:
               	str	x20, [sp, #-0x60]!
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
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
               	mov	x3, #0x1                // =1
               	bl	<addr>
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
               	sub	x0, x29, #0x10
               	sub	x1, x29, #0x8
               	mov	x2, #0x8                // =8
               	mov	x20, #0x0               // =0
               	mov	x3, x20
               	bl	<addr>
               	b	<addr>
               	sub	x1, x29, #0x10
               	add	x1, x1, x0
               	ldrb	w2, [x1]
               	add	x1, x0, #0x1
               	sxtw	x1, w1
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	cmp	x2, x1
               	b.ne	<addr>
               	add	x20, x0, #0x1
               	sxtw	x0, w20
               	cmp	x0, #0x8
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	add	x0, x20, #0x14
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	add	x0, x0, #0xa
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	b	<addr>
               	b	<addr>
