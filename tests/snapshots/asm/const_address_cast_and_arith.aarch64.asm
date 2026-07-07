
const_address_cast_and_arith.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cmp	x2, x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldr	x2, [x0, #0x8]
               	cmp	x2, x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldr	x2, [x0, #0x10]
               	cmp	x2, x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldr	x2, [x0, #0x18]
               	ldrsw	x2, [x2]
               	cmp	x2, #0xc8
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	ldr	x2, [x0, #0x20]
               	ldrsw	x2, [x2]
               	cmp	x2, #0xc8
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	ldr	x2, [x0, #0x28]
               	add	x3, x1, #0x4
               	cmp	x2, x3
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	ldr	x0, [x0, #0x30]
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	mov	x0, #0x0                // =0
               	ret
