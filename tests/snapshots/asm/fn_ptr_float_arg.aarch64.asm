
fn_ptr_float_arg.aarch64:	file format elf64-littleaarch64

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
               	fmov	s0, #2.50000000
               	fmov	s1, #2.00000000
               	fmul	s2, s0, s1
               	fcvtzs	x0, s2
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fmov	s2, #4.50000000
               	fcvtzs	x0, s2
               	add	x0, x0, #0x3
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	fcvtzs	x0, s0
               	add	x0, x0, #0xa
               	cmp	w0, #0xc
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	fmov	s0, #3.50000000
               	fmul	s0, s0, s1
               	fcvtzs	x0, s0
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
