
strtof_parses_float.aarch64:	file format elf64-littleaarch64

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
               	str	x20, [sp, #-0x40]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x8
               	bl	<addr>
               	mov	x0, #0x400c000000000000 // =4615063718147915776
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x40
               	ret
               	ldur	x0, [x29, #-0x8]
               	ldrb	w0, [x0]
               	mov	x17, #0x78              // =120
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x20, #0x0               // =0
               	mov	x1, x20
               	bl	<addr>
               	mov	x0, #0x3fd0000000000000 // =4598175219545276416
               	fmov	d16, x0
               	fneg	d1, d16
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x40
               	ret
