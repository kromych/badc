
variadic_agg_return_classes.aarch64:	file format elf64-littleaarch64

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
               	sub	x0, x29, #0x10
               	mov	x1, #0x3ff8000000000000 // =4609434218613702656
               	mov	x2, #0x2                // =2
               	scvtf	d0, x2
               	fmov	d16, x1
               	fmul	d0, d16, d0
               	str	d0, [x0]
               	mov	x3, #0x4002000000000000 // =4612248968380809216
               	fmov	d16, x3
               	str	d16, [x0, #0x8]
               	sub	x1, x29, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	ldr	d0, [x1]
               	mov	x4, #0x4008000000000000 // =4613937818241073152
               	fmov	d17, x4
               	fcmp	d0, d17
               	b.ne	<addr>
               	ldr	d0, [x1, #0x8]
               	fmov	d17, x3
               	fcmp	d0, d17
               	cset	x3, ne
               	cbz	x3, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d16, x3
               	str	d16, [x0]
               	mov	x4, #0x2a               // =42
               	str	x4, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	ldr	d0, [x1]
               	fmov	d17, x3
               	fcmp	d0, d17
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
