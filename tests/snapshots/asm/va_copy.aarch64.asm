
va_copy.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x30
               	str	x19, [sp]
               	sub	x0, x29, #0x8
               	add	x1, x29, #0x10
               	add	x17, x1, #0x10
               	str	x17, [x0]
               	sub	x0, x29, #0x10
               	sub	x1, x29, #0x8
               	ldr	x17, [x1]
               	str	x17, [x0]
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	b	<addr>
               	sxtw	x2, w1
               	ldursw	x3, [x29, #0x10]
               	cmp	x2, x3
               	b.ge	<addr>
               	sxtw	x0, w0
               	sub	x2, x29, #0x10
               	ldr	x17, [x2]
               	add	x16, x17, #0x10
               	str	x16, [x2]
               	mov	x2, x17
               	ldrsw	x2, [x2]
               	add	x0, x0, x2
               	sxtw	x0, w0
               	sxtw	x1, w1
               	add	x1, x1, #0x1
               	sxtw	x1, w1
               	b	<addr>
               	sub	x1, x29, #0x10
               	sub	x1, x29, #0x8
               	sxtw	x0, w0
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x4                // =4
               	mov	x1, #0xa                // =10
               	mov	x2, #0x14               // =20
               	mov	x3, #0x1e               // =30
               	mov	x4, #0x28               // =40
               	str	x4, [sp, #-0x10]!
               	str	x3, [sp, #-0x10]!
               	str	x2, [sp, #-0x10]!
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	bl	<addr>
               	add	sp, sp, #0x50
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
