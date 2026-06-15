
static_linked_list.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x230              // =560
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	str	w1, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x1, [x0, #0x8]
               	mov	x0, #0x2                // =2
               	str	w0, [x1]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x0, [x1, #0x8]
               	mov	x1, #0x3                // =3
               	str	w1, [x0]
               	mov	x2, #0x0                // =0
               	str	x2, [x0, #0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	cmp	x1, #0x0
               	b.eq	<addr>
               	sxtw	x0, w2
               	ldrsw	x2, [x1]
               	add	x0, x0, x2
               	sxtw	x2, w0
               	ldr	x1, [x1, #0x8]
               	b	<addr>
               	sxtw	x0, w2
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
