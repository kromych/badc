
brace_elided_struct_array_init.aarch64:	file format elf64-littleaarch64

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
               	cmp	w1, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldrsw	x1, [x0, #0x8]
               	cmp	w1, #0x1
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldr	x1, [x0, #0x10]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	cmp	x1, x2
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldr	x2, [x0, #0x18]
               	cmp	x2, #0x0
               	cset	x1, eq
               	cbz	x2, <addr>
               	ldr	x1, [x0, #0x20]
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldrsw	x1, [x0, #0x28]
               	cmp	w1, #0x2
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldr	x1, [x0, #0x40]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	cmp	x1, x2
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	ldrsw	x1, [x0, #0x48]
               	cmp	w1, #0x3
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldr	x1, [x0, #0x50]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	cmp	x1, x2
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	ldrsw	x2, [x0, #0x68]
               	cmp	w2, #0x0
               	cset	x1, ne
               	cbnz	x2, <addr>
               	ldr	x0, [x0, #0x70]
               	cmp	x0, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
