
macro_arg_blue_paint.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	str	x1, [x0]
               	mov	x0, #0x0                // =0
               	ret
               	ldr	x0, [x0]
               	ldrsw	x0, [x0]
               	ret
               	ldr	x0, [x0]
               	ldrsw	x0, [x0]
               	ret
               	ldr	x0, [x0]
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x7
               	sxtw	x0, w0
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x8
               	mov	x1, #0x64               // =100
               	str	w1, [x0]
               	sub	x0, x29, #0x10
               	sub	x1, x29, #0x8
               	bl	<addr>
               	sub	x0, x29, #0x10
               	ldr	x0, [x0]
               	ldrsw	x0, [x0]
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	x0, [x0]
               	ldrsw	x0, [x0]
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
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
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
