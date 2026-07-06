
param_incoming_reg_clobber.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x2, [sp, #-0x10]!
               	sub	sp, sp, #0x20
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x3, x0
               	stur	x2, [x29, #0x30]
               	ldur	w0, [x29, #0x30]
               	sub	x2, x0, #0x1
               	stur	w2, [x29, #0x30]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	add	x0, x3, #0x1
               	add	x2, x1, #0x1
               	ldrb	w1, [x1]
               	strb	w1, [x3]
               	mov	x3, x0
               	mov	x1, x2
               	b	<addr>
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
               	mov	x4, x1
               	sxtw	x3, w3
               	stur	x2, [x29, #0x30]
               	cmp	x3, #0x0
               	b.ne	<addr>
               	ldur	w2, [x29, #0x30]
               	mov	x1, x4
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x40
               	ret
               	ldur	w1, [x29, #0x30]
               	sub	x1, x1, #0x1
               	mov	w1, w1
               	add	x1, x0, x1
               	ldur	w0, [x29, #0x30]
               	sub	x2, x0, #0x1
               	stur	w2, [x29, #0x30]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	sub	x0, x1, #0x1
               	add	x2, x4, #0x1
               	ldrb	w3, [x4]
               	strb	w3, [x1]
               	mov	x1, x0
               	mov	x4, x2
               	b	<addr>
               	b	<addr>

<main>:
               	str	x20, [sp, #-0x60]!
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	mov	x1, #0x0                // =0
               	sxtw	x0, w1
               	cmp	x0, #0x8
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	b	<addr>
               	sub	x0, x29, #0x8
               	sxtw	x2, w1
               	add	x0, x0, x2
               	add	x2, x2, #0x1
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	strb	w2, [x0]
               	b	<addr>
               	sub	x0, x29, #0x10
               	sub	x1, x29, #0x8
               	mov	x2, #0x8                // =8
               	mov	x3, #0x1                // =1
               	bl	<addr>
               	mov	x1, #0x0                // =0
               	sxtw	x0, w1
               	cmp	x0, #0x8
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	b	<addr>
               	sub	x0, x29, #0x10
               	sxtw	x2, w1
               	add	x0, x0, x2
               	ldrb	w0, [x0]
               	mov	x3, #0x8                // =8
               	sub	x2, x3, x2
               	sxtw	x2, w2
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	cmp	x0, x2
               	b.eq	<addr>
               	b	<addr>
               	sub	x0, x29, #0x10
               	sub	x1, x29, #0x8
               	mov	x2, #0x8                // =8
               	mov	x20, #0x0               // =0
               	mov	x3, x20
               	bl	<addr>
               	b	<addr>
               	add	x0, x1, #0xa
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	b	<addr>
               	sxtw	x0, w20
               	cmp	x0, #0x8
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w20
               	add	x20, x0, #0x1
               	b	<addr>
               	sub	x0, x29, #0x10
               	sxtw	x1, w20
               	add	x0, x0, x1
               	ldrb	w0, [x0]
               	add	x1, x1, #0x1
               	sxtw	x1, w1
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	cmp	x0, x1
               	b.eq	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	add	x0, x20, #0x14
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	b	<addr>
