
brace_elision_anon_and_automatic.aarch64:	file format elf64-littleaarch64

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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	mov	x1, #0x7                // =7
               	mov	x5, #0x2                // =2
               	mov	x2, #0x3                // =3
               	mov	x3, #0x4                // =4
               	mov	x6, #0x5                // =5
               	mov	x7, #0xe                // =14
               	sub	x4, x29, #0xa0
               	stp	xzr, xzr, [x4]
               	stp	xzr, xzr, [x4, #0x10]
               	stp	xzr, xzr, [x4, #0x20]
               	stp	xzr, xzr, [x4, #0x30]
               	stp	xzr, xzr, [x4, #0x40]
               	stp	xzr, xzr, [x4, #0x50]
               	stp	xzr, xzr, [x4, #0x60]
               	stp	xzr, xzr, [x4, #0x70]
               	stp	xzr, xzr, [x4, #0x80]
               	stp	xzr, xzr, [x4, #0x90]
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0xa0]
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x98]
               	stur	w5, [x29, #-0x78]
               	adrp	x5, <addr>
               	add	x5, x5, <lo12>
               	add	x4, x4, #0x30
               	ldr	x16, [x5]
               	str	x16, [x4]
               	stur	w2, [x29, #-0x68]
               	stur	x0, [x29, #-0x60]
               	stur	w3, [x29, #-0x58]
               	stur	w2, [x29, #-0x50]
               	stur	w1, [x29, #-0x48]
               	mov	x2, #0x8                // =8
               	stur	w2, [x29, #-0x44]
               	stur	w6, [x29, #-0x40]
               	stur	x0, [x29, #-0x38]
               	mov	x2, #0x6                // =6
               	stur	w2, [x29, #-0x30]
               	sub	x2, x29, #0xa0
               	stur	w3, [x29, #-0x28]
               	add	x2, x2, #0x80
               	str	w1, [x2]
               	str	w7, [x2, #0x4]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
