
call_indirect_target_scratch_collision.aarch64:	file format elf64-littleaarch64

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
               	sxtw	x3, w3
               	mov	x0, #0x0                // =0
               	ldrb	w1, [x1]
               	add	x3, x3, x1
               	sxtw	x3, w3
               	str	w3, [x4]
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	sxtw	x3, w3
               	ldr	x10, [x0]
               	mov	x17, #0xffff            // =65535
               	and	x9, x3, x17
               	str	x4, [sp, #-0x10]!
               	str	x9, [sp, #-0x10]!
               	str	x2, [sp, #-0x10]!
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	ldr	x2, [sp, #0x20]
               	ldr	x3, [sp, #0x30]
               	ldr	x4, [sp, #0x40]
               	blr	x10
               	add	sp, sp, #0x50
               	mov	x3, x0
               	mov	x0, x3
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sub	x15, x29, #0x8
               	adrp	x14, <page>
               	add	x14, x14, #0x3c8
               	str	x14, [x15]
               	mov	x2, #0x0                // =0
               	stur	w2, [x29, #-0x10]
               	sub	x0, x29, #0x8
               	adrp	x1, <page>
               	add	x1, x1, #0x150
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0x1, lsl #16
               	sub	x4, x29, #0x10
               	bl	<addr>
               	mov	x20, x0
               	adrp	x0, <page>
               	add	x0, x0, #0x152
               	sxtw	x1, w20
               	ldursw	x2, [x29, #-0x10]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x4, x0
               	sxtw	x20, w20
               	cmp	x20, #0x0
               	cset	x20, eq
               	stur	x20, [x29, #-0x48]
               	cbz	x20, <addr>
               	ldursw	x4, [x29, #-0x10]
               	mov	x17, #0x40              // =64
               	movk	x17, #0x1, lsl #16
               	cmp	x4, x17
               	cset	x4, eq
               	stur	x4, [x29, #-0x48]
               	b	<addr>
               	ldur	x4, [x29, #-0x48]
               	cbz	x4, <addr>
               	mov	x20, #0x0               // =0
               	stur	x20, [x29, #-0x50]
               	b	<addr>
               	mov	x20, #0x1               // =1
               	stur	x20, [x29, #-0x50]
               	b	<addr>
               	ldur	x20, [x29, #-0x50]
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
