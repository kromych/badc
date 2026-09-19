
libc_math_minmax.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	mov	x1, #0x4010000000000000 // =4616189618054758400
               	fmov	d0, x0
               	fmov	d1, x1
               	bl	<addr>
               	mov	x0, #0x4014000000000000 // =4617315517961601024
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	mov	x1, #0x4008000000000000 // =4613937818241073152
               	fmov	d0, x0
               	fmov	d1, x1
               	bl	<addr>
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x4008000000000000 // =4613937818241073152
               	fmov	d0, x0
               	fmov	d1, x1
               	bl	<addr>
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	fmov	d17, x0
               	fdiv	d0, d16, d17
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	fmov	d1, x0
               	bl	<addr>
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x4014000000000000 // =4617315517961601024
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	fmov	d17, x0
               	fdiv	d0, d16, d17
               	fmov	d1, d0
               	fmov	d0, x1
               	bl	<addr>
               	mov	x0, #0x4014000000000000 // =4617315517961601024
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x40400000         // =1077936128
               	mov	x1, #0x40800000         // =1082130432
               	fmov	d0, x0
               	fmov	d1, x1
               	bl	<addr>
               	mov	x0, #0x40a00000         // =1084227584
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x40000000         // =1073741824
               	mov	x1, #0x40400000         // =1077936128
               	fmov	d0, x0
               	fmov	d1, x1
               	bl	<addr>
               	mov	x0, #0x40000000         // =1073741824
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x40400000         // =1077936128
               	fmov	d0, x0
               	fmov	d1, x1
               	bl	<addr>
               	mov	x0, #0x40400000         // =1077936128
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
