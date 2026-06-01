
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
               	str	x19, [sp, #0x10]
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
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x0, #0x0                // =0
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
               	ldr	x1, [x11]
               	bl	<addr>
               	mov	x11, x0
               	cbz	x11, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x1, x19
               	lsl	x0, x20, #3
               	add	x1, x1, x0
               	ldr	x11, [x11]
               	str	x11, [x1]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x11, x19
               	lsl	x20, x20, #3
               	add	x11, x11, x20
               	ldr	x11, [x11]
               	mov	x0, x11
               	ldr	x20, [sp]
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
               	adrp	x19, <page>
               	add	x19, x19, #0x150
               	mov	x0, x19
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
