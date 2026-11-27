
struct_arg_two_eightbyte.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<main>:
               	mov	x5, #0x1111             // =4369
               	mov	x6, #0x2222             // =8738
               	adrp	x1, <page>
               	mov	x0, #0x9                // =9
               	str	w0, [x1, #0x38]
               	adrp	x2, <page>
               	str	x5, [x2, #0x20]
               	adrp	x3, <page>
               	mov	x0, #0x4                // =4
               	str	w0, [x3, #0x30]
               	adrp	x4, <page>
               	str	x6, [x4, #0x28]
               	adrp	x8, <page>
               	mov	x7, #0x6                // =6
               	str	w7, [x8, #0x34]
               	ldrsw	x1, [x1, #0x38]
               	cmp	w1, #0x9
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldr	x1, [x2, #0x20]
               	mov	x17, #0x1111            // =4369
               	cmp	x1, x17
               	b.ne	<addr>
               	ldr	w1, [x3, #0x30]
               	cmp	w1, #0x4
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldr	x1, [x4, #0x28]
               	mov	x17, #0x2222            // =8738
               	cmp	x1, x17
               	b.ne	<addr>
               	adrp	x1, <page>
               	str	x5, [x1, #0x40]
               	adrp	x2, <page>
               	str	w0, [x2, #0x50]
               	adrp	x3, <page>
               	str	x6, [x3, #0x48]
               	adrp	x4, <page>
               	str	w7, [x4, #0x54]
               	ldr	x1, [x1, #0x40]
               	mov	x17, #0x1111            // =4369
               	cmp	x1, x17
               	b.ne	<addr>
               	ldr	w1, [x2, #0x50]
               	cmp	w1, #0x4
               	b.eq	<addr>
               	ret
               	ldr	x0, [x3, #0x48]
               	mov	x17, #0x2222            // =8738
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x3                // =3
               	ret
