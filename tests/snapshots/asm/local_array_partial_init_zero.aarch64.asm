
local_array_partial_init_zero.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0xb0
               	mov	x3, #0xbeef             // =48879
               	movk	x3, #0xdead, lsl #16
               	mov	x0, #0x0                // =0
               	cmp	w0, #0x28
               	b.ge	<addr>
               	sub	x1, x29, #0xa8
               	sxtw	x2, w0
               	str	w3, [x1, x2, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x28
               	b.lt	<addr>
               	sub	x2, x29, #0xa8
               	ldr	w0, [x2]
               	ldr	w1, [x2, #0x9c]
               	add	x0, x0, x1
               	mov	w0, w0
               	stur	w0, [x29, #-0x8]
               	ldur	w0, [x29, #-0x8]
               	sub	x3, x29, #0x70
               	stp	xzr, xzr, [x3]
               	stp	xzr, xzr, [x3, #0x10]
               	stp	xzr, xzr, [x3, #0x20]
               	stp	xzr, xzr, [x3, #0x30]
               	stp	xzr, xzr, [x3, #0x40]
               	stp	xzr, xzr, [x3, #0x50]
               	str	wzr, [x3, #0x60]
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	cmp	w0, #0x19
               	b.ge	<addr>
               	mov	w4, w1
               	sxtw	x1, w0
               	ldr	w1, [x3, x1, lsl #2]
               	add	x1, x4, x1
               	add	x0, x0, #0x1
               	cmp	w0, #0x19
               	b.lt	<addr>
               	mov	w5, w1
               	mov	x3, #0x5678             // =22136
               	movk	x3, #0x1234, lsl #16
               	mov	x0, #0x0                // =0
               	cmp	w0, #0x28
               	b.ge	<addr>
               	sxtw	x1, w0
               	str	w3, [x2, x1, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x28
               	b.lt	<addr>
               	sub	x0, x29, #0xa8
               	ldr	w1, [x0]
               	ldr	w0, [x0, #0x9c]
               	add	x0, x1, x0
               	mov	w0, w0
               	stur	w0, [x29, #-0x8]
               	ldur	w0, [x29, #-0x8]
               	sub	x2, x29, #0x70
               	stp	xzr, xzr, [x2]
               	stp	xzr, xzr, [x2, #0x10]
               	stp	xzr, xzr, [x2, #0x20]
               	stp	xzr, xzr, [x2, #0x30]
               	stp	xzr, xzr, [x2, #0x40]
               	stp	xzr, xzr, [x2, #0x50]
               	str	wzr, [x2, #0x60]
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	cmp	w0, #0x19
               	b.ge	<addr>
               	mov	w3, w1
               	sxtw	x1, w0
               	ldr	w1, [x2, x1, lsl #2]
               	add	x1, x3, x1
               	add	x0, x0, #0x1
               	cmp	w0, #0x19
               	b.lt	<addr>
               	mov	w0, w1
               	cbz	x5, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
