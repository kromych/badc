
builtin_constant_p_choose_expr_init.aarch64:	file format elf64-littleaarch64

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
               	ldr	d0, [x0, #0x18]
               	fmov	d1, #2.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldr	d0, [x0, #0x38]
               	fmov	d1, #0.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	fmov	d0, #1.50000000
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	fmov	d0, #3.50000000
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ret
               	mov	x0, #0x0                // =0
               	ret
