
extern_decl_then_define.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	adrp	x0, <page>
               	add	x0, x0, #0x110
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0xd0
               	adrp	x14, <page>
               	add	x14, x14, #0xf0
               	cmp	x15, x14
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0xd0
               	ldr	w15, [x15]
               	mov	x17, #0x9ed8            // =40664
               	movk	x17, #0xc105, lsl #16
               	cmp	x15, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0xf0
               	ldr	w15, [x15]
               	mov	x17, #0xe667            // =58983
               	movk	x17, #0x6a09, lsl #16
               	cmp	x15, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0xd0
               	add	x15, x15, #0x1c
               	ldr	w15, [x15]
               	mov	x17, #0x4fa4            // =20388
               	movk	x17, #0xbefa, lsl #16
               	cmp	x15, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0xf0
               	add	x15, x15, #0x1c
               	ldr	w15, [x15]
               	mov	x17, #0xcd19            // =52505
               	movk	x17, #0x5be0, lsl #16
               	cmp	x15, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0x110
               	adrp	x0, <page>
               	add	x0, x0, #0x110
               	cmp	x15, x0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0x110
               	ldr	w15, [x15]
               	mov	x17, #0xa5a5            // =42405
               	movk	x17, #0xa5a5, lsl #16
               	cmp	x15, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0x110
               	add	x15, x15, #0x8
               	ldr	x15, [x15]
               	mov	x17, #0xbeef            // =48879
               	movk	x17, #0xdead, lsl #16
               	cmp	x15, x17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	mov	x15, #0x0               // =0
               	mov	x0, x15
               	ret
