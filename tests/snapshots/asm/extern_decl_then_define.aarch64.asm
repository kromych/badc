
extern_decl_then_define.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	adrp	x19, <page>
               	add	x19, x19, #0x110
               	mov	x0, x19
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	adrp	x19, <page>
               	add	x19, x19, #0xd0
               	mov	x15, x19
               	adrp	x19, <page>
               	add	x19, x19, #0xf0
               	mov	x14, x19
               	cmp	x15, x14
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xd0
               	mov	x15, x19
               	ldr	w0, [x15]
               	mov	x17, #0x9ed8            // =40664
               	movk	x17, #0xc105, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x15, #0x2               // =2
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xf0
               	mov	x0, x19
               	ldr	w15, [x0]
               	mov	x17, #0xe667            // =58983
               	movk	x17, #0x6a09, lsl #16
               	cmp	x15, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xd0
               	mov	x15, x19
               	add	x15, x15, #0x1c
               	ldr	w0, [x15]
               	mov	x17, #0x4fa4            // =20388
               	movk	x17, #0xbefa, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x15, #0x4               // =4
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xf0
               	mov	x0, x19
               	add	x0, x0, #0x1c
               	ldr	w15, [x0]
               	mov	x17, #0xcd19            // =52505
               	movk	x17, #0x5be0, lsl #16
               	cmp	x15, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x110
               	mov	x15, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x110
               	mov	x0, x19
               	cmp	x15, x0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x110
               	mov	x15, x19
               	ldr	w0, [x15]
               	mov	x17, #0xa5a5            // =42405
               	movk	x17, #0xa5a5, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x15, #0x7               // =7
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x110
               	mov	x0, x19
               	add	x0, x0, #0x8
               	ldr	x15, [x0]
               	mov	x17, #0xbeef            // =48879
               	movk	x17, #0xdead, lsl #16
               	cmp	x15, x17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
