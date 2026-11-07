
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
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	mov	x2, #0x8                // =8
               	bl	<addr>
               	mov	x0, #0x41               // =65
               	sturb	w0, [x29, #-0x18]
               	fmov	s0, #2.50000000
               	stur	s0, [x29, #-0x14]
               	sub	x1, x29, #0x10
               	mov	x0, #0x3f800000         // =1065353216
               	stur	w0, [x29, #-0x10]
               	mov	x0, #0x40000000         // =1073741824
               	stur	w0, [x29, #-0xc]
               	sub	x0, x29, #0x8
               	mov	x2, #0x8                // =8
               	bl	<addr>
               	ldur	x0, [x29, #-0x8]
               	mov	x17, #0x3f800000        // =1065353216
               	movk	x17, #0x4000, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x10
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	stur	x0, [x29, #-0x10]
               	sub	x0, x29, #0x8
               	mov	x2, #0x8                // =8
               	bl	<addr>
               	ldur	x0, [x29, #-0x8]
               	mov	x17, #0x4008000000000000 // =4613937818241073152
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x10
               	mov	x0, #0x3fc00000         // =1069547520
               	stur	w0, [x29, #-0x10]
               	sub	x0, x29, #0x8
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	ldur	w0, [x29, #-0x8]
               	mov	x17, #0x3fc00000        // =1069547520
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	sub	x1, x29, #0x10
               	ldr	x16, [x0]
               	str	x16, [x1]
               	sub	x0, x29, #0x8
               	mov	x2, #0x8                // =8
               	bl	<addr>
               	ldur	x0, [x29, #-0x8]
               	and	x0, x0, #0xffffffff000000ff
               	mov	x17, #0x41              // =65
               	movk	x17, #0x4020, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	s0, #3.00000000
               	fmov	s1, #4.00000000
               	sub	x1, x29, #0x10
               	stur	s0, [x29, #-0x10]
               	stur	s1, [x29, #-0xc]
               	sub	x0, x29, #0x8
               	mov	x2, #0x8                // =8
               	bl	<addr>
               	ldur	x0, [x29, #-0x8]
               	mov	x17, #0x40400000        // =1077936128
               	movk	x17, #0x4080, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
