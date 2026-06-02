
function_type_typedef.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	sxtw	x15, w0
               	sxtw	x14, w1
               	add	x15, x15, x14
               	sxtw	x0, w15
               	ret
               	sxtw	x15, w0
               	sxtw	x14, w1
               	sub	x15, x15, x14
               	sxtw	x0, w15
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	mov	x15, x0
               	sxtw	x0, w1
               	sxtw	x1, w2
               	mov	x9, x15
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	blr	x9
               	add	sp, sp, #0x20
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	mov	x15, x0
               	sxtw	x0, w1
               	sxtw	x1, w2
               	mov	x9, x15
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	blr	x9
               	add	sp, sp, #0x20
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, #0x238
               	mov	x1, #0x3                // =3
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x1, #0x1                // =1
               	mov	x0, x1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x24c
               	mov	x1, #0xa                // =10
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x1, #0x2                // =2
               	mov	x0, x1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x238
               	mov	x1, #0x5                // =5
               	mov	x2, #0x6                // =6
               	bl	<addr>
               	cmp	x0, #0xb
               	b.eq	<addr>
               	mov	x1, #0x3                // =3
               	mov	x0, x1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x24c
               	mov	x1, #0x14               // =20
               	mov	x2, #0x8                // =8
               	bl	<addr>
               	cmp	x0, #0xc
               	b.eq	<addr>
               	mov	x1, #0x4                // =4
               	mov	x0, x1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
