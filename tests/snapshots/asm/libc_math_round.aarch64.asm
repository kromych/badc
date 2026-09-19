
libc_math_round.aarch64:	file format elf64-littleaarch64

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
               	fmov	d0, #2.50000000
               	bl	<addr>
               	fmov	d1, #2.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #3.50000000
               	bl	<addr>
               	fmov	d1, #4.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #2.50000000
               	bl	<addr>
               	fmov	d1, #2.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #2.50000000
               	bl	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #-2.50000000
               	bl	<addr>
               	mov	x17, #-0x3              // =-3
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x16, <page>
               	ldr	d0, [x16]
               	bl	<addr>
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x16, <page>
               	ldr	d0, [x16, #0x8]
               	fmov	d1, #0.50000000
               	fadd	d0, d0, d1
               	bl	<addr>
               	mov	x17, #0x1001            // =4097
               	movk	x17, #0xd4a5, lsl #16
               	movk	x17, #0xe8, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	s0, #2.50000000
               	bl	<addr>
               	fmov	s1, #2.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	s0, #3.50000000
               	bl	<addr>
               	fmov	s1, #4.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
