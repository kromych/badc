
const_addr_multidim_array_elem.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	sub	x2, x2, x1
               	cmp	x2, #0x300
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldr	x2, [x0, #0x8]
               	sub	x2, x2, x1
               	cmp	x2, #0x190
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldr	x0, [x0, #0x10]
               	sub	x0, x0, x1
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	sub	x1, x1, x0
               	cmp	x1, #0x80
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, #0x8]
               	sub	x0, x1, x0
               	cmp	x0, #0x48
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x0                // =0
               	ret
