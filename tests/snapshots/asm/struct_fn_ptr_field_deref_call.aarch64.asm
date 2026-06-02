
struct_fn_ptr_field_deref_call.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	sxtw	x15, w0
               	add	x15, x15, #0x3
               	sxtw	x0, w15
               	ret
               	sxtw	x15, w0
               	add	x15, x15, #0x7
               	sxtw	x0, w15
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	adrp	x20, <page>
               	add	x20, x20, #0xd0
               	adrp	x14, <page>
               	add	x14, x14, #0x238
               	str	x14, [x20]
               	add	x13, x20, #0x8
               	mov	x14, #0x0               // =0
               	str	w14, [x13]
               	ldr	x12, [x20]
               	mov	x0, #0xa                // =10
               	mov	x9, x12
               	str	x0, [sp, #-0x10]!
               	ldr	x0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	mov	x21, x0
               	ldr	x0, [x20]
               	mov	x12, #0x14              // =20
               	mov	x9, x0
               	str	x12, [sp, #-0x10]!
               	ldr	x0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	mov	x11, x0
               	sxtw	x21, w21
               	cmp	x21, #0xd
               	b.eq	<addr>
               	mov	x12, #0x1               // =1
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x11, w11
               	cmp	x11, #0x17
               	b.eq	<addr>
               	mov	x12, #0x2               // =2
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x11, <page>
               	add	x11, x11, #0x248
               	str	x11, [x20]
               	ldr	x12, [x20]
               	mov	x0, #0x64               // =100
               	mov	x9, x12
               	str	x0, [sp, #-0x10]!
               	ldr	x0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	mov	x22, x0
               	ldr	x20, [x20]
               	mov	x0, #0xc8               // =200
               	mov	x9, x20
               	str	x0, [sp, #-0x10]!
               	ldr	x0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	mov	x12, x0
               	sxtw	x22, w22
               	cmp	x22, #0x6b
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x12, w12
               	cmp	x12, #0xcf
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x12, #0x0               // =0
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
