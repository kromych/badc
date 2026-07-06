
binop_spill_lhs_rhs_in_dst.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x3, x0
               	mov	x4, x2
               	sxtw	x1, w1
               	sxtw	x4, w4
               	ldrsw	x6, [x3, x4, lsl #2]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	ldrsw	x5, [x3, x2, lsl #2]
               	add	x0, x0, x5
               	sxtw	x0, w0
               	add	x1, x2, #0x1
               	sxtw	x2, w1
               	cmp	x2, x4
               	b.le	<addr>
               	add	x0, x0, x6
               	sxtw	x0, w0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	mov	x2, #0xc                // =12
               	str	w2, [x0]
               	sub	x0, x29, #0x18
               	mov	x2, #0x4                // =4
               	mov	x3, #0x7                // =7
               	str	w3, [x0, #0x4]
               	sub	x0, x29, #0x18
               	mov	x3, #0xf                // =15
               	str	w3, [x0, #0x8]
               	sub	x0, x29, #0x18
               	mov	x3, #0x5                // =5
               	str	w3, [x0, #0xc]
               	sub	x0, x29, #0x18
               	mov	x3, #0xa                // =10
               	str	w3, [x0, #0x10]
               	sub	x0, x29, #0x18
               	bl	<addr>
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
