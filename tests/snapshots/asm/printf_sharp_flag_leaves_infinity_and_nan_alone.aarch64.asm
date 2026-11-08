
printf_sharp_flag_leaves_infinity_and_nan_alone.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x180
               	sub	x0, x29, #0x180
               	mov	x1, #0x80               // =128
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x16, #0x7ff0000000000000 // =9218868437227405312
               	fmov	d0, x16
               	mov	x16, #-0x10000000000000 // =-4503599627370496
               	fmov	d1, x16
               	mov	x16, #0x7fc00000        // =2143289344
               	fmov	s2, w16
               	fcvt	d2, s2
               	fmov	d3, #1.00000000
               	mov	x3, #0x7                // =7
               	mov	x4, #0xff               // =255
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	fmov	d4, d0
               	fmov	d5, d3
               	fmov	d3, d1
               	bl	<addr>
               	sub	x0, x29, #0x180
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x100
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x16, #-0x10000000000000 // =-4503599627370496
               	fmov	d0, x16
               	mov	x16, #0x7ff0000000000000 // =9218868437227405312
               	fmov	d1, x16
               	fmov	d2, #1.50000000
               	bl	<addr>
               	sub	x0, x29, #0x100
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
