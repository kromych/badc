
array_field_designator.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<main>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	cmp	w1, #0xa
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldrsw	x1, [x0, #0x4]
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldrsw	x1, [x0, #0x8]
               	cmp	w1, #0x1e
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldrsw	x1, [x0, #0xc]
               	cbz	x1, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	ldrsw	x0, [x0, #0x10]
               	cmp	w0, #0x32
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x0                // =0
               	ret
