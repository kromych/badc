
float_literal_variadic_printf.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2b0              // =688
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	str	x19, [sp]
               	sub	x0, x29, #0x40
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #0x3fc00000         // =1069547520
               	fmov	s16, w3
               	fcvt	d0, s16
               	mov	x3, #0xcccd             // =52429
               	movk	x3, #0x3dcc, lsl #16
               	fmov	s16, w3
               	fcvt	d1, s16
               	bl	<addr>
               	sxtw	x0, w0
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
