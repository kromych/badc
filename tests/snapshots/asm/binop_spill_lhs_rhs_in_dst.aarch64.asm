
binop_spill_lhs_rhs_in_dst.aarch64:	file format elf64-littleaarch64

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

<sum_at_high>:
               	ldrsw	x5, [x0, w2, sxtw #2]
               	mov	x3, #0x0                // =0
               	cmp	w1, w2
               	b.gt	<addr>
               	ldrsw	x4, [x0, w1, sxtw #2]
               	add	x3, x3, x4
               	add	x1, x1, #0x1
               	cmp	w1, w2
               	b.le	<addr>
               	add	x0, x3, x5
               	sxtw	x0, w0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x2, x29, #0x18
               	mov	x0, #0xc                // =12
               	str	w0, [x2]
               	mov	x0, #0x7                // =7
               	str	w0, [x2, #0x4]
               	mov	x0, #0xf                // =15
               	str	w0, [x2, #0x8]
               	mov	x0, #0x5                // =5
               	str	w0, [x2, #0xc]
               	mov	x1, #0xa                // =10
               	str	w1, [x2, #0x10]
               	mov	x0, #0x0                // =0
               	mov	x4, x1
               	mov	x1, x0
               	ldrsw	x3, [x2, x1, lsl #2]
               	add	x0, x0, x3
               	add	x1, x1, #0x1
               	cmp	w1, #0x4
               	b.le	<addr>
               	add	x0, x0, x4
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
