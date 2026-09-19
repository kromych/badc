
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
               	mov	x2, #0x1111             // =4369
               	mov	x3, #0x2222             // =8738
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x9                // =9
               	str	w0, [x1]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	str	x2, [x4]
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x0, #0x4                // =4
               	str	w0, [x5]
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	str	x3, [x6]
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	mov	x8, #0x6                // =6
               	str	w8, [x7]
               	ldrsw	x1, [x1]
               	cmp	w1, #0x9
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldr	x1, [x4]
               	mov	x17, #0x1111            // =4369
               	cmp	x1, x17
               	b.ne	<addr>
               	ldr	w1, [x5]
               	eor	x1, x1, #0x4
               	cbz	w1, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldr	x1, [x6]
               	mov	x17, #0x2222            // =8738
               	cmp	x1, x17
               	b.ne	<addr>
               	ldr	w1, [x7]
               	eor	x1, x1, #0x6
               	cbz	w1, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x2, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	w0, [x2]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	str	x3, [x4]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	w8, [x3]
               	ldr	x1, [x1]
               	mov	x17, #0x1111            // =4369
               	cmp	x1, x17
               	b.ne	<addr>
               	ldr	w1, [x2]
               	eor	x1, x1, #0x4
               	cbz	w1, <addr>
               	ret
               	ldr	x0, [x4]
               	mov	x17, #0x2222            // =8738
               	cmp	x0, x17
               	b.ne	<addr>
               	ldr	w0, [x3]
               	eor	x0, x0, #0x6
               	cbz	w0, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x0                // =0
               	ret
