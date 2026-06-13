
multi_declarator_prototypes.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x0, w0
               	ret

<g>:
               	sxtw	x0, w0
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	ret

<main>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xa                // =10
               	str	w1, [x0]
               	mov	x1, #0x3                // =3
               	cmp	x1, #0x3
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x1, #0x3                // =3
               	lsl	x1, x1, #1
               	sxtw	x1, w1
               	cmp	x1, #0x6
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldrsw	x0, [x0]
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x0                // =0
               	ret
