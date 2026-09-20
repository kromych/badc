
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
               	mov	x1, #0x1111             // =4369
               	mov	x2, #0x2222             // =8738
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, #0x9                // =9
               	str	w0, [x3]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	str	x1, [x4]
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x0, #0x4                // =4
               	str	w0, [x5]
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	str	x2, [x6]
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	mov	x8, #0x6                // =6
               	str	w8, [x7]
               	ldrsw	x3, [x3]
               	cmp	w3, #0x9
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldr	x3, [x4]
               	mov	x17, #0x1111            // =4369
               	cmp	x3, x17
               	b.ne	<addr>
               	ldr	w3, [x5]
               	eor	x3, x3, #0x4
               	cbz	w3, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldr	x3, [x6]
               	mov	x17, #0x2222            // =8738
               	cmp	x3, x17
               	b.ne	<addr>
               	ldr	w3, [x7]
               	eor	x3, x3, #0x6
               	cbz	w3, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x1, [x3]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	w0, [x1]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	str	x2, [x4]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	w8, [x2]
               	ldr	x3, [x3]
               	mov	x17, #0x1111            // =4369
               	cmp	x3, x17
               	b.ne	<addr>
               	ldr	w1, [x1]
               	eor	x1, x1, #0x4
               	cbz	w1, <addr>
               	ret
               	ldr	x0, [x4]
               	mov	x17, #0x2222            // =8738
               	cmp	x0, x17
               	b.ne	<addr>
               	ldr	w0, [x2]
               	eor	x0, x0, #0x6
               	cbz	w0, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x0                // =0
               	ret
