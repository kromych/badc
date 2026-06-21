
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
               	ldr	x1, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	cmp	x1, x2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldr	x1, [x0, #0x8]
               	cmp	x1, x2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldr	x1, [x0, #0x10]
               	cmp	x1, x2
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldr	x1, [x0, #0x18]
               	ldrsw	x1, [x1]
               	cmp	x1, #0xc8
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	ldr	x1, [x0, #0x20]
               	ldrsw	x1, [x1]
               	cmp	x1, #0xc8
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	ldr	x1, [x0, #0x28]
               	add	x3, x2, #0x4
               	cmp	x1, x3
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	ldr	x0, [x0, #0x30]
               	cmp	x0, x2
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	mov	x0, #0x0                // =0
               	ret
