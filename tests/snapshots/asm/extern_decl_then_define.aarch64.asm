
extern_decl_then_define.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ret

<main>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldr	w2, [x0]
               	mov	x17, #0x9ed8            // =40664
               	movk	x17, #0xc105, lsl #16
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldr	w2, [x1]
               	mov	x17, #0xe667            // =58983
               	movk	x17, #0x6a09, lsl #16
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldr	w0, [x0, #0x1c]
               	mov	x17, #0x4fa4            // =20388
               	movk	x17, #0xbefa, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	ldr	w0, [x1, #0x1c]
               	mov	x17, #0xcd19            // =52505
               	movk	x17, #0x5be0, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w0, [x0]
               	mov	x17, #0xa5a5            // =42405
               	movk	x17, #0xa5a5, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0xbeef            // =48879
               	movk	x17, #0xdead, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	mov	x0, #0x0                // =0
               	ret
