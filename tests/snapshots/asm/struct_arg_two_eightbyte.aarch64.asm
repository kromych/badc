
struct_arg_two_eightbyte.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x1111             // =4369
               	mov	x1, #0x2222             // =8738
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #0x9                // =9
               	str	w3, [x2]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x0, [x2]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #0x4                // =4
               	str	w3, [x2]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x1, [x2]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x4, #0x6                // =6
               	str	w4, [x2]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x2, [x2]
               	cmp	w2, #0x9
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	mov	x17, #0x1111            // =4369
               	cmp	x2, x17
               	b.ne	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	w2, [x2]
               	mov	x17, #0x4               // =4
               	eor	x2, x2, x17
               	mov	w2, w2
               	cmp	w2, #0x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	mov	x17, #0x2222            // =8738
               	cmp	x2, x17
               	b.ne	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	w2, [x2]
               	mov	x17, #0x6               // =6
               	eor	x2, x2, x17
               	mov	w2, w2
               	cmp	w2, #0x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x0, [x2]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	w3, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	w4, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x17, #0x1111            // =4369
               	cmp	x0, x17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w0, [x0]
               	mov	x17, #0x4               // =4
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x17, #0x2222            // =8738
               	cmp	x0, x17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w0, [x0]
               	mov	x17, #0x6               // =6
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x0                // =0
               	ret
