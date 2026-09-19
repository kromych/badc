
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

<is_ready>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	add	x0, x0, #0x38
               	ldarb	w0, [x0]
               	sub	x1, x29, #0x8
               	strb	w0, [x1]
               	ldurb	w0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xc0
               	sub	x0, x29, #0xc0
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	str	xzr, [x0, #0x30]
               	strb	wzr, [x0, #0x38]
               	mov	x0, #0x0                // =0
               	cmp	w0, #0x10
               	b.ge	<addr>
               	sub	x1, x29, #0x80
               	sxtw	x2, w0
               	lsl	x2, x2, #3
               	add	x1, x1, x2
               	mov	x2, #-0x1               // =-1
               	str	x2, [x1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xc0
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xc0
               	mov	x1, #0x1                // =1
               	strb	w1, [x0, #0x38]
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
