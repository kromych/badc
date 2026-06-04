
local_array_partial_init_zero.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xb0
               	mov	x1, #0x0                // =0
               	stur	w1, [x29, #-0xa8]
               	b	<addr>
               	ldursw	x1, [x29, #-0xa8]
               	cmp	x1, #0x28
               	b.ge	<addr>
               	b	<addr>
               	sub	x1, x29, #0xa8
               	ldrsw	x2, [x1]
               	add	x2, x2, #0x1
               	str	w2, [x1]
               	b	<addr>
               	sub	x1, x29, #0xa0
               	ldursw	x2, [x29, #-0xa8]
               	lsl	x2, x2, #2
               	add	x1, x1, x2
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x2, x0, x17
               	str	w2, [x1]
               	b	<addr>
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	sub	x0, x29, #0x68
               	adrp	x1, <page>
               	add	x1, x1, #0xd0
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
               	stur	w0, [x29, #-0x70]
               	stur	w0, [x29, #-0x78]
               	b	<addr>
               	ldursw	x0, [x29, #-0x78]
               	cmp	x0, #0x19
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x78
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x70
               	ldr	w1, [x0]
               	sub	x2, x29, #0x68
               	ldursw	x3, [x29, #-0x78]
               	lsl	x3, x3, #2
               	add	x2, x2, x3
               	ldr	w2, [x2]
               	add	x1, x1, x2
               	str	w1, [x0]
               	b	<addr>
               	ldur	w0, [x29, #-0x70]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x20, [sp]
               	mov	x0, #0xbeef             // =48879
               	movk	x0, #0xdead, lsl #16
               	bl	<addr>
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x5678             // =22136
               	movk	x0, #0x1234, lsl #16
               	bl	<addr>
               	bl	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x20, x17
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
