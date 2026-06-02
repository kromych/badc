
divmod_preserves_rdx.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x80
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	mov	x15, #0x64              // =100
               	mov	x14, #0x32              // =50
               	mov	x13, #0x19              // =25
               	mov	x12, #0xc               // =12
               	mov	x11, #0x8               // =8
               	sdiv	x10, x15, x11
               	sdiv	x9, x14, x11
               	sdiv	x8, x13, x11
               	sdiv	x7, x12, x11
               	sxtw	x10, w10
               	sxtw	x9, w9
               	add	x10, x10, x9
               	sxtw	x10, w10
               	sxtw	x8, w8
               	add	x10, x10, x8
               	sxtw	x10, w10
               	sxtw	x7, w7
               	add	x10, x10, x7
               	sxtw	x10, w10
               	add	x10, x10, x15
               	sxtw	x10, w10
               	add	x10, x10, x14
               	sxtw	x10, w10
               	add	x10, x10, x13
               	sxtw	x10, w10
               	add	x10, x10, x12
               	sxtw	x20, w10
               	adrp	x0, <page>
               	add	x0, x0, #0x150
               	sxtw	x1, w20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x14, x0
               	sxtw	x20, w20
               	cmp	x20, #0xd1
               	b.ne	<addr>
               	mov	x14, #0x0               // =0
               	stur	x14, [x29, #-0x60]
               	b	<addr>
               	mov	x14, #0x1               // =1
               	stur	x14, [x29, #-0x60]
               	b	<addr>
               	ldur	x14, [x29, #-0x60]
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
