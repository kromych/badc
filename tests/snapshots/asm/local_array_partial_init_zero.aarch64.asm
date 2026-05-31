
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
               	mov	x15, x0
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0xa8]
               	b	<addr>
               	ldursw	x14, [x29, #-0xa8]
               	cmp	x14, #0x28
               	b.ge	<addr>
               	b	<addr>
               	sub	x13, x29, #0xa8
               	ldrsw	x14, [x13]
               	add	x14, x14, #0x1
               	str	w14, [x13]
               	b	<addr>
               	sub	x14, x29, #0xa0
               	ldursw	x12, [x29, #-0xa8]
               	lsl	x12, x12, #2
               	add	x14, x14, x12
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x15, x17
               	str	w12, [x14]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x90
               	str	x19, [sp]
               	sub	x15, x29, #0x68
               	adrp	x19, <page>
               	add	x19, x19, #0xd0
               	mov	x14, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x14]
               	str	x10, [x15]
               	ldr	x10, [x14, #0x8]
               	str	x10, [x15, #0x8]
               	ldr	x10, [x14, #0x10]
               	str	x10, [x15, #0x10]
               	ldr	x10, [x14, #0x18]
               	str	x10, [x15, #0x18]
               	ldr	x10, [x14, #0x20]
               	str	x10, [x15, #0x20]
               	ldr	x10, [x14, #0x28]
               	str	x10, [x15, #0x28]
               	ldr	x10, [x14, #0x30]
               	str	x10, [x15, #0x30]
               	ldr	x10, [x14, #0x38]
               	str	x10, [x15, #0x38]
               	ldr	x10, [x14, #0x40]
               	str	x10, [x15, #0x40]
               	ldr	x10, [x14, #0x48]
               	str	x10, [x15, #0x48]
               	ldr	x10, [x14, #0x50]
               	str	x10, [x15, #0x50]
               	ldr	x10, [x14, #0x58]
               	str	x10, [x15, #0x58]
               	ldrb	w10, [x14, #0x60]
               	strb	w10, [x15, #0x60]
               	ldrb	w10, [x14, #0x61]
               	strb	w10, [x15, #0x61]
               	ldrb	w10, [x14, #0x62]
               	strb	w10, [x15, #0x62]
               	ldrb	w10, [x14, #0x63]
               	strb	w10, [x15, #0x63]
               	ldr	x10, [sp], #0x10
               	mov	x13, x15
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x70]
               	stur	w13, [x29, #-0x78]
               	b	<addr>
               	ldursw	x13, [x29, #-0x78]
               	cmp	x13, #0x19
               	b.ge	<addr>
               	b	<addr>
               	sub	x14, x29, #0x78
               	ldrsw	x13, [x14]
               	add	x13, x13, #0x1
               	str	w13, [x14]
               	b	<addr>
               	sub	x13, x29, #0x70
               	ldr	w15, [x13]
               	sub	x14, x29, #0x68
               	ldursw	x12, [x29, #-0x78]
               	lsl	x12, x12, #2
               	add	x14, x14, x12
               	ldr	w12, [x14]
               	add	x15, x15, x12
               	str	w15, [x13]
               	b	<addr>
               	ldur	w0, [x29, #-0x70]
               	ldr	x19, [sp]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	mov	x20, #0xbeef            // =48879
               	movk	x20, #0xdead, lsl #16
               	mov	x0, x20
               	bl	<addr>
               	bl	<addr>
               	mov	x21, x0
               	mov	x22, #0x5678            // =22136
               	movk	x22, #0x1234, lsl #16
               	mov	x0, x22
               	bl	<addr>
               	bl	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x21, x17
               	cmp	x21, #0x0
               	b.eq	<addr>
               	mov	x22, #0x1               // =1
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x22, #0x2               // =2
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
