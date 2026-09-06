
builtin_choose_expr.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0xd0
               	mov	x2, #0xffff             // =65535
               	movk	x2, #0xffff, lsl #16
               	movk	x2, #0xffff, lsl #32
               	movk	x2, #0xffff, lsl #48
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x3, x29, #0x80
               	sxtw	x1, w0
               	lsl	x4, x1, #3
               	add	x3, x3, x4
               	str	x2, [x3]
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	sub	x0, x29, #0x10
               	strb	w1, [x0]
               	mov	x1, #0x1                // =1
               	strb	w1, [x0]
               	ldurb	w0, [x29, #-0x10]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
