
array_compound_literal_address_const.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2b0              // =688
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldrsw	x1, [x1]
               	cmp	x1, #0xa
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldr	x1, [x0, #0x8]
               	ldrsw	x1, [x1]
               	cmp	x1, #0x2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldr	x0, [x0, #0x10]
               	ldrsw	x0, [x0]
               	cmp	x0, #0x12c
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x0                // =0
               	ret
