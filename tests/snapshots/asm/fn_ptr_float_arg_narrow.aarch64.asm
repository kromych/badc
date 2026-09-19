
fn_ptr_float_arg_narrow.aarch64:	file format elf64-littleaarch64

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

<scale2>:
               	fmov	s1, #2.00000000
               	fmul	s0, s0, s1
               	ret

<negf>:
               	fneg	s0, s0
               	ret

<addf>:
               	fadd	s0, s0, s1
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	fmov	s0, #3.00000000
               	bl	<addr>
               	fmov	s1, #6.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	s0, #3.00000000
               	bl	<addr>
               	fmov	s1, #3.00000000
               	fneg	s1, s1
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	s0, #4.00000000
               	bl	<addr>
               	fmov	s1, #8.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	s0, #1.50000000
               	fmov	s1, #2.00000000
               	bl	<addr>
               	fmov	s1, #3.50000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	s0, #5.00000000
               	fmov	s1, #2.00000000
               	fmul	s0, s0, s1
               	fmov	s1, #10.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	s0, #7.00000000
               	bl	<addr>
               	fmov	s1, #14.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	s0, #3.00000000
               	bl	<addr>
               	fmov	s1, #6.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	s0, #3.00000000
               	bl	<addr>
               	fmov	s1, #6.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	s0, #1.50000000
               	fmov	s1, #2.00000000
               	bl	<addr>
               	fmov	s1, #3.50000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
