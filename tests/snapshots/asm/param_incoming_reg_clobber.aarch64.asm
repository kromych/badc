
param_incoming_reg_clobber.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	str	x2, [sp, #-0x10]!
               	sub	sp, sp, #0x20
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x3, x1
               	mov	x1, x0
               	stur	x2, [x29, #0x30]
               	b	<addr>
               	ldur	w0, [x29, #0x30]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x2, x0, x17
               	stur	w2, [x29, #0x30]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	add	x0, x1, #0x1
               	add	x2, x3, #0x1
               	ldrb	w3, [x3]
               	strb	w3, [x1]
               	mov	x1, x0
               	mov	x3, x2
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x30
               	ret
               	sub	sp, sp, #0x10
               	str	x2, [sp, #-0x10]!
               	sub	sp, sp, #0x20
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x20, [sp]
               	mov	x20, x0
               	mov	x4, x1
               	sxtw	x3, w3
               	stur	x2, [x29, #0x30]
               	cmp	x3, #0x0
               	b.ne	<addr>
               	ldur	w2, [x29, #0x30]
               	mov	x0, x20
               	mov	x1, x4
               	bl	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x40
               	ret
               	ldur	w0, [x29, #0x30]
               	sub	x0, x0, #0x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	add	x1, x20, x0
               	b	<addr>
               	ldur	w0, [x29, #0x30]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x2, x0, x17
               	stur	w2, [x29, #0x30]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x0, x1, x17
               	add	x2, x4, #0x1
               	ldrb	w3, [x4]
               	strb	w3, [x1]
               	mov	x1, x0
               	mov	x4, x2
               	b	<addr>
               	b	<addr>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	mov	x1, #0x0                // =0
               	b	<addr>
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
               	sxtw	x2, w2
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	strb	w2, [x0]
               	b	<addr>
               	sub	x0, x29, #0x10
               	sub	x1, x29, #0x8
               	mov	x2, #0x8                // =8
               	mov	x3, #0x1                // =1
               	bl	<addr>
               	mov	x20, #0x0               // =0
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
               	mov	x2, #0x8                // =8
               	sub	x1, x2, x1
               	sxtw	x1, w1
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	cmp	x0, x1
               	b.eq	<addr>
               	b	<addr>
               	sub	x0, x29, #0x10
               	sub	x1, x29, #0x8
               	mov	x2, #0x8                // =8
               	mov	x20, #0x0               // =0
               	mov	x3, x20
               	bl	<addr>
               	b	<addr>
               	sxtw	x0, w20
               	add	x0, x0, #0xa
               	sxtw	x0, w0
               	ldr	x20, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
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
               	ldr	x20, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x0, w20
               	add	x0, x0, #0x14
               	sxtw	x0, w0
               	ldr	x20, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
