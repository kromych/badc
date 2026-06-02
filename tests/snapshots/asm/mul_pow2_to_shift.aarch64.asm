
mul_pow2_to_shift.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xf0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x21, <page>
               	add	x21, x21, #0x100
               	lsl	x13, x20, #3
               	add	x13, x21, x13
               	ldr	x13, [x13]
               	cbz	x13, <addr>
               	lsl	x12, x20, #3
               	add	x12, x21, x12
               	ldr	x12, [x12]
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x18
               	mov	x0, #0x0                // =0
               	adrp	x11, <page>
               	add	x11, x11, #0x118
               	str	x11, [x13]
               	sub	x10, x29, #0x18
               	add	x10, x10, #0x8
               	adrp	x11, <page>
               	add	x11, x11, #0x11e
               	str	x11, [x10]
               	sub	x13, x29, #0x18
               	add	x13, x13, #0x10
               	adrp	x11, <page>
               	add	x11, x11, #0x125
               	str	x11, [x13]
               	sub	x10, x29, #0x18
               	lsl	x11, x20, #3
               	add	x10, x10, x11
               	ldr	x1, [x10]
               	bl	<addr>
               	mov	x10, x0
               	cbz	x10, <addr>
               	lsl	x1, x20, #3
               	add	x1, x21, x1
               	ldr	x10, [x10]
               	str	x10, [x1]
               	b	<addr>
               	lsl	x20, x20, #3
               	add	x21, x21, x20
               	ldr	x21, [x21]
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xb0
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	mov	x15, #0x7               // =7
               	lsl	x14, x15, #1
               	sxtw	x14, w14
               	lsl	x13, x15, #2
               	sxtw	x13, w13
               	lsl	x12, x15, #3
               	sxtw	x12, w12
               	lsl	x11, x15, #4
               	sxtw	x11, w11
               	lsl	x10, x15, #10
               	sxtw	x10, w10
               	lsl	x9, x15, #1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x9, x9, x17
               	lsl	x8, x15, #8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x8, x8, x17
               	lsl	x7, x15, #5
               	lsl	x15, x15, #16
               	sxtw	x14, w14
               	sxtw	x13, w13
               	add	x14, x14, x13
               	sxtw	x14, w14
               	sxtw	x12, w12
               	add	x14, x14, x12
               	sxtw	x14, w14
               	sxtw	x11, w11
               	add	x14, x14, x11
               	sxtw	x14, w14
               	sxtw	x10, w10
               	add	x14, x14, x10
               	sxtw	x14, w14
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x9, x9, x17
               	add	x14, x14, x9
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x14, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x8, x8, x17
               	add	x14, x14, x8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x14, x17
               	add	x14, x14, x7
               	add	x20, x14, x15
               	adrp	x0, <page>
               	add	x0, x0, #0x150
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x15, x0
               	mov	x17, #0x24c0            // =9408
               	movk	x17, #0x7, lsl #16
               	cmp	x20, x17
               	b.ne	<addr>
               	mov	x15, #0x0               // =0
               	stur	x15, [x29, #-0x88]
               	b	<addr>
               	mov	x15, #0x1               // =1
               	stur	x15, [x29, #-0x88]
               	b	<addr>
               	ldur	x15, [x29, #-0x88]
               	mov	x0, x15
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
