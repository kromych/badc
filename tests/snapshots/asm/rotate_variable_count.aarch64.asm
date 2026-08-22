
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
               	sub	sp, sp, #0x50
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x1, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [x1, #0x28]
               	str	x10, [x0, #0x28]
               	ldr	x10, [sp], #0x10
               	mov	x7, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0x10]
               	b	<addr>
               	sub	x0, x29, #0x40
               	mov	w1, w7
               	ldr	x1, [x0, x1, lsl #3]
               	ldursw	x0, [x29, #-0x10]
               	ror	x8, x1, x0
               	sub	x0, x29, #0x40
               	mov	w1, w7
               	ldr	x5, [x0, x1, lsl #3]
               	ldursw	x4, [x29, #-0x10]
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	mov	x3, #0x1                // =1
               	lsl	x3, x3, x2
               	and	x3, x5, x3
               	cbz	x3, <addr>
               	sub	x3, x0, x4
               	mov	x17, #0x3f              // =63
               	and	x3, x3, x17
               	mov	x6, #0x1                // =1
               	sxtw	x3, w3
               	lsl	x3, x6, x3
               	orr	x1, x1, x3
               	b	<addr>
               	b	<addr>
               	add	x0, x2, #0x1
               	sxtw	x2, w0
               	cmp	x2, #0x40
               	b.lt	<addr>
               	cmp	x8, x1
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x0, #0x1
               	stur	w0, [x29, #-0x10]
               	ldursw	x0, [x29, #-0x10]
               	cmp	x0, #0x40
               	b.lt	<addr>
               	mov	w0, w7
               	add	x7, x0, #0x1
               	mov	w0, w7
               	cmp	x0, #0x6
               	b.lo	<addr>
               	mov	x4, #0xcdef             // =52719
               	movk	x4, #0x89ab, lsl #16
               	movk	x4, #0x4567, lsl #32
               	movk	x4, #0x123, lsl #48
               	stur	x4, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	lsr	x0, x0, #7
               	ldur	x1, [x29, #-0x8]
               	lsl	x1, x1, #57
               	orr	x6, x0, x1
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	mov	x3, #0x1                // =1
               	lsl	x3, x3, x2
               	and	x3, x4, x3
               	cbz	x3, <addr>
               	sub	x3, x0, #0x7
               	mov	x17, #0x3f              // =63
               	and	x3, x3, x17
               	mov	x5, #0x1                // =1
               	sxtw	x3, w3
               	lsl	x3, x5, x3
               	orr	x1, x1, x3
               	b	<addr>
               	b	<addr>
               	add	x0, x2, #0x1
               	sxtw	x2, w0
               	cmp	x2, #0x40
               	b.lt	<addr>
               	cmp	x6, x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
