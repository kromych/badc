
multidim_struct_array_designator.aarch64:	file format elf64-littleaarch64

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
               	ldrsw	x1, [x0, #0x8]
               	cmp	x1, #0x5
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldrsw	x1, [x0, #0xc]
               	cmp	x1, #0x6
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldrsw	x1, [x0, #0x30]
               	cmp	x1, #0x7
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldrsw	x1, [x0, #0x34]
               	cmp	x1, #0x8
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldrsw	x1, [x0, #0x20]
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldrsw	x1, [x0, #0x24]
               	cmp	x1, #0x37
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldrsw	x1, [x0]
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldrsw	x0, [x0, #0x44]
               	cmp	x0, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x28]
               	cmp	x0, #0x3
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x2c]
               	cmp	x0, #0x4
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x10]
               	cmp	x0, #0x9
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x14]
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0xc
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x1c]
               	cmp	x0, #0x11
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
