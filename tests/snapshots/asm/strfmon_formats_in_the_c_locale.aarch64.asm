
strfmon_formats_in_the_c_locale.aarch64:	file format elf64-littleaarch64

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
               	str	x20, [sp, #-0x80]!
               	stp	x29, x30, [sp, #0x70]
               	add	x29, sp, #0x70
               	sub	x0, x29, #0x60
               	mov	x1, #0x60               // =96
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x16, <page>
               	ldr	d0, [x16, #0x48]
               	fmov	d1, #7.00000000
               	fmov	d2, #1.00000000
               	adrp	x16, <page>
               	ldr	d3, [x16, #0x50]
               	bl	<addr>
               	mov	x20, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cmp	x20, x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x20, [sp], #0x80
               	ret
               	sub	x0, x29, #0x60
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x20, [sp], #0x80
               	ret
               	sub	x0, x29, #0x60
               	mov	x1, #0x4                // =4
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x16, <page>
               	ldr	d0, [x16, #0x48]
               	bl	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x20, [sp], #0x80
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x20, [sp], #0x80
               	ret
