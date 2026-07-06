
struct_array_designator.aarch64:	file format elf64-littleaarch64

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
               	ldrsw	x1, [x0]
               	cmp	x1, #0xa
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldrsw	x1, [x0, #0x4]
               	cmp	x1, #0xb
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldrsw	x1, [x0, #0x8]
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldrsw	x1, [x0, #0xc]
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldrsw	x1, [x0, #0x10]
               	cmp	x1, #0x1e
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldrsw	x0, [x0, #0x14]
               	cmp	x0, #0x1f
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
