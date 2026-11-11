
addr_compare_same_function_inline.aarch64:	file format elf64-littleaarch64

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
               	ldrsw	x1, [x0, #0x30]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x30]
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldrsw	x0, [x0, #0x30]
               	mov	x1, #0x0                // =0
               	mov	x2, #0x3                // =3
               	cmp	w0, #0x1
               	csel	x0, x1, x2, eq
               	ret
