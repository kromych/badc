
typeof_function_types.aarch64:	file format elf64-littleaarch64

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

<twice>:
               	lsl	x0, x0, #1
               	ret

<half>:
               	fmov	d1, #2.00000000
               	fdiv	d0, d0, d1
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	fmov	d1, #4.00000000
               	fmov	d0, #2.00000000
               	fdiv	d1, d1, d0
               	fcmp	d1, d0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	cmp	w0, #0xa
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	mov	x0, #0x7                // =7
               	blr	x1
               	cmp	w0, #0xe
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d1, #4.00000000
               	fmov	d0, #2.00000000
               	fdiv	d1, d1, d0
               	fcmp	d1, d0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #8.00000000
               	bl	<addr>
               	fmov	d1, #4.00000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	fmov	d0, #6.00000000
               	bl	<addr>
               	fmov	d1, #3.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
