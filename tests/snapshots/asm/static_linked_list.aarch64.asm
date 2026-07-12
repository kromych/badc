
static_linked_list.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x290              // =656
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x1                // =1
               	str	w0, [x1]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x0, [x1, #0x8]
               	mov	x1, #0x2                // =2
               	str	w1, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x1, [x0, #0x8]
               	mov	x0, #0x3                // =3
               	str	w0, [x1]
               	mov	x0, #0x0                // =0
               	str	x0, [x1, #0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	b	<addr>
               	ldrsw	x2, [x1]
               	add	x0, x0, x2
               	ldr	x1, [x1, #0x8]
               	cmp	x1, #0x0
               	b.ne	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret
