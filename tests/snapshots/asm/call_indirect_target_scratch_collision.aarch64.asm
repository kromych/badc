
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
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x14, <page>
               	add	x14, x14, #0x100
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x13, <page>
               	add	x13, x13, #0x100
               	lsl	x14, x20, #3
               	add	x13, x13, x14
               	ldr	x13, [x13]
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x0, #0x0                // =0
               	adrp	x12, <page>
               	add	x12, x12, #0x118
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x12, <page>
               	add	x12, x12, #0x11e
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x12, <page>
               	add	x12, x12, #0x125
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x1, [x11]
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x100
               	lsl	x11, x20, #3
               	add	x1, x1, x11
               	ldr	x0, [x0]
               	str	x0, [x1]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x100
               	lsl	x20, x20, #3
               	add	x0, x0, x20
               	ldr	x0, [x0]
               	ldr	x20, [sp]
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
               	add	x14, x14, #0x3cc
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
               	sxtw	x20, w20
               	cmp	x20, #0x0
               	cset	x20, eq
               	stur	x20, [x29, #-0x48]
               	cbz	x20, <addr>
               	ldursw	x0, [x29, #-0x10]
               	mov	x17, #0x40              // =64
               	movk	x17, #0x1, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	stur	x0, [x29, #-0x48]
               	b	<addr>
               	ldur	x0, [x29, #-0x48]
               	cbz	x0, <addr>
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
