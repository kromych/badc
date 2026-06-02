
macro_arg_blue_paint.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	mov	x15, x0
               	mov	x14, x1
               	str	x14, [x15]
               	mov	x0, #0x0                // =0
               	ret
               	mov	x15, x0
               	ldr	x15, [x15]
               	ldrsw	x0, [x15]
               	ret
               	mov	x15, x0
               	ldr	x15, [x15]
               	ldrsw	x0, [x15]
               	ret
               	mov	x15, x0
               	ldr	x15, [x15]
               	ldrsw	x15, [x15]
               	add	x15, x15, #0x7
               	sxtw	x0, w15
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x15, x29, #0x8
               	mov	x14, #0x64              // =100
               	str	w14, [x15]
               	sub	x0, x29, #0x10
               	sub	x1, x29, #0x8
               	bl	<addr>
               	sub	x0, x29, #0x10
               	ldr	x0, [x0]
               	ldrsw	x0, [x0]
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x1, #0xb                // =11
               	mov	x0, x1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	x0, [x0]
               	ldrsw	x0, [x0]
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x1, #0xc                // =12
               	mov	x0, x1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	x0, [x0]
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x7
               	sxtw	x0, w0
               	cmp	x0, #0x6b
               	b.eq	<addr>
               	mov	x1, #0xd                // =13
               	mov	x0, x1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
