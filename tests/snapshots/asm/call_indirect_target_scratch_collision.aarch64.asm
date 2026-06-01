
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
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x13, x19
               	lsl	x14, x20, #3
               	add	x13, x13, x14
               	ldr	x13, [x13]
               	mov	x0, x13
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
               	ldr	x0, [x0]
               	str	x0, [x22]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x0, x19
               	lsl	x20, x20, #3
               	add	x0, x0, x20
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
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
               	sub	sp, sp, #0x40
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x19, [sp, #0x30]
               	mov	x20, x0
               	mov	x21, x1
               	mov	x22, x2
               	sxtw	x3, w3
               	mov	x23, x4
               	ldr	x24, [x20]
               	mov	x17, #0xffff            // =65535
               	and	x25, x3, x17
               	mov	x9, x24
               	str	x23, [sp, #-0x10]!
               	str	x25, [sp, #-0x10]!
               	str	x22, [sp, #-0x10]!
               	str	x21, [sp, #-0x10]!
               	str	x20, [sp, #-0x10]!
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	ldr	x2, [sp, #0x20]
               	ldr	x3, [sp, #0x30]
               	ldr	x4, [sp, #0x40]
               	blr	x9
               	add	sp, sp, #0x50
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x26, [sp, #0x30]
               	str	x19, [sp, #0x40]
               	sub	x15, x29, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x408
               	mov	x14, x19
               	str	x14, [x15]
               	mov	x20, #0x0               // =0
               	stur	w20, [x29, #-0x10]
               	sub	x21, x29, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x150
               	mov	x22, x19
               	mov	x23, #0xffff            // =65535
               	movk	x23, #0x1, lsl #16
               	sub	x24, x29, #0x10
               	mov	x0, x21
               	mov	x4, x24
               	mov	x3, x23
               	mov	x2, x20
               	mov	x1, x22
               	bl	<addr>
               	mov	x25, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x152
               	mov	x26, x19
               	sxtw	x24, w25
               	ldursw	x23, [x29, #-0x10]
               	mov	x0, x26
               	mov	x2, x23
               	mov	x1, x24
               	bl	<addr>
               	sxtw	x0, w0
               	sxtw	x25, w25
               	cmp	x25, #0x0
               	cset	x25, eq
               	stur	x25, [x29, #-0x48]
               	cbz	x25, <addr>
               	ldursw	x0, [x29, #-0x10]
               	mov	x17, #0x40              // =64
               	movk	x17, #0x1, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	stur	x0, [x29, #-0x48]
               	b	<addr>
               	ldur	x0, [x29, #-0x48]
               	cbz	x0, <addr>
               	mov	x25, #0x0               // =0
               	stur	x25, [x29, #-0x50]
               	b	<addr>
               	mov	x25, #0x1               // =1
               	stur	x25, [x29, #-0x50]
               	b	<addr>
               	ldur	x25, [x29, #-0x50]
               	mov	x0, x25
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
