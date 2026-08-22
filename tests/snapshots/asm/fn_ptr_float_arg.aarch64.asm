
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
               	mov	x0, #0x40200000         // =1075838976
               	mov	x1, #0x40000000         // =1073741824
               	fmov	s16, w0
               	fmov	s17, w1
               	fmul	s0, s16, s17
               	fcvtzs	x0, s0
               	sxtw	x0, w0
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x40900000         // =1083179008
               	fmov	s16, w0
               	fcvtzs	x0, s16
               	add	x0, x0, #0x3
               	sxtw	x0, w0
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x40200000         // =1075838976
               	fmov	s16, w0
               	fcvtzs	x0, s16
               	add	x0, x0, #0xa
               	sxtw	x0, w0
               	cmp	x0, #0xc
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x40600000         // =1080033280
               	mov	x1, #0x40000000         // =1073741824
               	fmov	s16, w0
               	fmov	s17, w1
               	fmul	s0, s16, s17
               	fcvtzs	x0, s0
               	sxtw	x0, w0
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
