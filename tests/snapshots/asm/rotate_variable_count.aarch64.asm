
rotate_variable_count.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x40
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	mov	x6, #0x0                // =0
               	mov	x2, #0x1                // =1
               	stur	w2, [x29, #-0x10]
               	b	<addr>
               	sub	x0, x29, #0x40
               	ldr	x3, [x0, x6, lsl #3]
               	ldursw	x0, [x29, #-0x10]
               	ror	x7, x3, x0
               	ldursw	x4, [x29, #-0x10]
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	lsl	x5, x2, x0
               	and	x5, x3, x5
               	cbz	x5, <addr>
               	sub	x5, x0, x4
               	and	x5, x5, #0x3f
               	lsl	x5, x2, x5
               	orr	x1, x1, x5
               	add	x0, x0, #0x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	cmp	x7, x1
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x0, #0x1
               	stur	w0, [x29, #-0x10]
               	ldursw	x0, [x29, #-0x10]
               	cmp	w0, #0x40
               	b.lt	<addr>
               	add	x6, x6, #0x1
               	cmp	w6, #0x6
               	b.lo	<addr>
               	mov	x3, #0xcdef             // =52719
               	movk	x3, #0x89ab, lsl #16
               	movk	x3, #0x4567, lsl #32
               	movk	x3, #0x123, lsl #48
               	stur	x3, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	lsr	x0, x0, #7
               	ldur	x1, [x29, #-0x8]
               	lsl	x1, x1, #57
               	orr	x5, x0, x1
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mov	x2, #0x1                // =1
               	lsl	x4, x2, x0
               	and	x4, x3, x4
               	cbz	x4, <addr>
               	sub	x4, x0, #0x7
               	and	x4, x4, #0x3f
               	lsl	x2, x2, x4
               	orr	x1, x1, x2
               	add	x0, x0, #0x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	cmp	x5, x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
