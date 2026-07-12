
local_array_partial_init_zero.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0xb0
               	mov	x3, x0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0xa0
               	mov	w4, w3
               	str	w4, [x2, x1, lsl #2]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x28
               	b.lt	<addr>
               	sub	x0, x29, #0xa0
               	mov	x1, #0x0                // =0
               	ldr	w2, [x0]
               	sub	x0, x29, #0xa0
               	ldr	w0, [x0, #0x9c]
               	add	x0, x2, x0
               	mov	w0, w0
               	stur	w0, [x29, #-0xb0]
               	ldur	w0, [x29, #-0xb0]
               	mov	x0, x1
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret

<sum_partial_init>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	sub	x0, x29, #0x68
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x1, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [x1, #0x28]
               	str	x10, [x0, #0x28]
               	ldr	x10, [x1, #0x30]
               	str	x10, [x0, #0x30]
               	ldr	x10, [x1, #0x38]
               	str	x10, [x0, #0x38]
               	ldr	x10, [x1, #0x40]
               	str	x10, [x0, #0x40]
               	ldr	x10, [x1, #0x48]
               	str	x10, [x0, #0x48]
               	ldr	x10, [x1, #0x50]
               	str	x10, [x0, #0x50]
               	ldr	x10, [x1, #0x58]
               	str	x10, [x0, #0x58]
               	ldrb	w10, [x1, #0x60]
               	strb	w10, [x0, #0x60]
               	ldrb	w10, [x1, #0x61]
               	strb	w10, [x0, #0x61]
               	ldrb	w10, [x1, #0x62]
               	strb	w10, [x0, #0x62]
               	ldrb	w10, [x1, #0x63]
               	strb	w10, [x0, #0x63]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	b	<addr>
               	mov	w3, w2
               	sub	x2, x29, #0x68
               	ldr	w2, [x2, x1, lsl #2]
               	add	x2, x3, x2
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x19
               	b.lt	<addr>
               	mov	w0, w2
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0xbeef             // =48879
               	movk	x0, #0xdead, lsl #16
               	bl	<addr>
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x5678             // =22136
               	movk	x0, #0x1234, lsl #16
               	bl	<addr>
               	bl	<addr>
               	mov	w1, w20
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
