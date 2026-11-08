
small_fp_aggregate_arguments.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x10
               	mov	x1, #0x4008000000000000 // =4613937818241073152
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x10]
               	stur	w0, [x29, #-0xc]
               	mov	x3, #0x41               // =65
               	sturb	w3, [x29, #-0x10]
               	fmov	s0, #2.50000000
               	stur	s0, [x29, #-0xc]
               	sub	x3, x29, #0x8
               	mov	x4, #0x3f800000         // =1065353216
               	stur	w4, [x29, #-0x8]
               	mov	x4, #0x40000000         // =1073741824
               	stur	w4, [x29, #-0x4]
               	ldur	x4, [x29, #-0x8]
               	mov	x17, #0x3f800000        // =1065353216
               	movk	x17, #0x4000, lsl #48
               	cmp	x4, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	x1, [x29, #-0x8]
               	mov	x1, #0x3fc00000         // =1069547520
               	stur	w1, [x29, #-0x8]
               	ldur	w1, [x29, #-0x8]
               	mov	x17, #0x3fc00000        // =1069547520
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x16, [x2]
               	str	x16, [x3]
               	ldur	x1, [x29, #-0x8]
               	and	x1, x1, #0xffffffff000000ff
               	mov	x17, #0x41              // =65
               	movk	x17, #0x4020, lsl #48
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	s0, #3.00000000
               	fmov	s1, #4.00000000
               	stur	s0, [x29, #-0x8]
               	stur	s1, [x29, #-0x4]
               	ldur	x1, [x29, #-0x8]
               	mov	x17, #0x40400000        // =1077936128
               	movk	x17, #0x4080, lsl #48
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
