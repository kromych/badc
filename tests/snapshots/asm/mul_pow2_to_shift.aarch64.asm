
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
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sxtw	x20, w0
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x13, [x14]
               	cbz	x13, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x0, [x14]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x21, #0x0               // =0
               	adrp	x19, <page>
               	add	x19, x19, #0x118
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x11e
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, <page>
               	add	x19, x19, #0x125
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x22]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x21, x19
               	lsl	x20, x20, #3
               	add	x21, x21, x20
               	ldr	x0, [x21]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xb0
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x15, #0x7               // =7
               	sxtw	x14, w15
               	lsl	x13, x14, #1
               	sxtw	x13, w13
               	lsl	x12, x14, #2
               	sxtw	x12, w12
               	lsl	x11, x14, #3
               	sxtw	x11, w11
               	lsl	x10, x14, #4
               	sxtw	x10, w10
               	lsl	x14, x14, #10
               	sxtw	x14, w14
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x9, x15, x17
               	lsl	x8, x9, #1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x8, x8, x17
               	lsl	x9, x9, #8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x9, x9, x17
               	lsl	x7, x15, #5
               	lsl	x15, x15, #16
               	sxtw	x13, w13
               	sxtw	x12, w12
               	add	x13, x13, x12
               	sxtw	x13, w13
               	sxtw	x11, w11
               	add	x13, x13, x11
               	sxtw	x13, w13
               	sxtw	x10, w10
               	add	x13, x13, x10
               	sxtw	x13, w13
               	sxtw	x14, w14
               	add	x13, x13, x14
               	sxtw	x13, w13
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x8, x8, x17
               	add	x13, x13, x8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x13, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x9, x9, x17
               	add	x13, x13, x9
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x13, x17
               	add	x13, x13, x7
               	add	x20, x13, x15
               	adrp	x19, <page>
               	add	x19, x19, #0x150
               	mov	x21, x19
               	mov	x0, x21
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x17, #0x24c0            // =9408
               	movk	x17, #0x7, lsl #16
               	cmp	x20, x17
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x88]
               	b	<addr>
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0x88]
               	b	<addr>
               	ldur	x0, [x29, #-0x88]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
