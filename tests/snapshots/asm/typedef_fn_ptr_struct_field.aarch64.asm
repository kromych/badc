
typedef_fn_ptr_struct_field.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	sxtw	x0, w0
               	sxtw	x1, w1
               	mul	x0, x0, x1
               	sxtw	x1, w0
               	mov	x0, x1
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sub	x15, x29, #0x10
               	adrp	x19, <page>
               	add	x19, x19, #0x238
               	mov	x14, x19
               	str	x14, [x15]
               	sub	x13, x29, #0x10
               	add	x13, x13, #0x8
               	mov	x14, #0x0               // =0
               	str	w14, [x13]
               	sub	x20, x29, #0x10
               	ldr	x14, [x20]
               	mov	x0, #0x3                // =3
               	mov	x1, #0x7                // =7
               	mov	x9, x14
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	blr	x9
               	add	sp, sp, #0x20
               	mov	x11, x0
               	cmp	x11, #0x15
               	b.eq	<addr>
               	mov	x1, #0x1                // =1
               	mov	x0, x1
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x20, [x20]
               	mov	x0, #0x4                // =4
               	mov	x1, #0x5                // =5
               	mov	x9, x20
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	blr	x9
               	add	sp, sp, #0x20
               	mov	x11, x0
               	cmp	x11, #0x14
               	b.eq	<addr>
               	mov	x1, #0x2                // =2
               	mov	x0, x1
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x11, x29, #0x10
               	ldr	x11, [x11]
               	mov	x0, #0x2                // =2
               	mov	x1, #0x9                // =9
               	mov	x9, x11
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	blr	x9
               	add	sp, sp, #0x20
               	mov	x20, x0
               	cmp	x20, #0x12
               	b.eq	<addr>
               	mov	x1, #0x3                // =3
               	mov	x0, x1
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x10
               	ldr	x20, [x20]
               	mov	x0, #0x6                // =6
               	mov	x1, #0x4                // =4
               	mov	x9, x20
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	blr	x9
               	add	sp, sp, #0x20
               	mov	x11, x0
               	cmp	x11, #0x18
               	b.eq	<addr>
               	mov	x1, #0x4                // =4
               	mov	x0, x1
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x11, #0x0               // =0
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
