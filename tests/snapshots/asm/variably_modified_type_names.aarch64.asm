
variably_modified_type_names.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x30
               	add	x0, x0, #0x2
               	sxtw	x1, w0
               	sub	x0, x29, #0x30
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	mov	x17, #0xc               // =12
               	mul	x2, x1, x17
               	add	x1, x1, x1, lsl #1
               	sxtw	x1, w1
               	lsl	x1, x1, #2
               	cmp	x2, x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x1, x0, #0x10
               	mov	x2, #0x7                // =7
               	str	w2, [x1, #0x8]
               	ldursw	x2, [x29, #-0x18]
               	cmp	w2, #0x7
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x1, x0
               	cmp	x0, #0x10
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x8]
               	mov	x1, #0x1                // =1
               	stur	w1, [x29, #-0x8]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
