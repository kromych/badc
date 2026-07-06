
fn_ptr_float_arg.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x0, #0x40000000         // =1073741824
               	fmov	s17, w0
               	fmul	s0, s0, s17
               	fcvt	d0, s0
               	fcvtzs	x0, d0
               	ret

<mix>:
               	fcvt	d0, s0
               	fcvtzs	x1, d0
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ret

<run>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	sxtw	x0, w0
               	fmov	x16, d0
               	str	x16, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	mov	x9, x1
               	ldr	x0, [sp]
               	ldr	d0, [sp, #0x10]
               	blr	x9
               	add	sp, sp, #0x20
               	sxtw	x0, w0
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<cb_impl>:
               	fcvt	d0, s0
               	fcvtzs	x1, d0
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x0, #0x40200000         // =1075838976
               	str	x0, [sp, #-0x10]!
               	mov	x9, x20
               	ldr	d0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	sxtw	x0, w0
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x3                // =3
               	mov	x2, #0x40900000         // =1083179008
               	str	x2, [sp, #-0x10]!
               	str	x1, [sp, #-0x10]!
               	mov	x9, x0
               	ldr	x0, [sp]
               	ldr	d0, [sp, #0x10]
               	blr	x9
               	add	sp, sp, #0x20
               	sxtw	x0, w0
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x40200000         // =1075838976
               	fmov	d0, x2
               	bl	<addr>
               	cmp	x0, #0xc
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x40600000         // =1080033280
               	str	x0, [sp, #-0x10]!
               	mov	x9, x20
               	ldr	d0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	sxtw	x0, w0
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
