
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
               	mov	x6, #0x0                // =0
               	mov	x2, #0x1                // =1
               	stur	w2, [x29, #-0x10]
               	b	<addr>
               	sub	x0, x29, #0x40
               	ldr	x4, [x0, x6, lsl #3]
               	ldursw	x1, [x29, #-0x10]
               	ror	x7, x4, x1
               	ldursw	x5, [x29, #-0x10]
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	lsl	x3, x2, x0
               	and	x3, x4, x3
               	cbz	x3, <addr>
               	sub	x3, x0, x5
               	and	x3, x3, #0x3f
               	lsl	x3, x2, x3
               	orr	x1, x1, x3
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
               	mov	x4, #0xcdef             // =52719
               	movk	x4, #0x89ab, lsl #16
               	movk	x4, #0x4567, lsl #32
               	movk	x4, #0x123, lsl #48
               	stur	x4, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	lsr	x0, x0, #7
               	ldur	x1, [x29, #-0x8]
               	lsl	x1, x1, #57
               	orr	x5, x0, x1
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mov	x2, #0x1                // =1
               	lsl	x3, x2, x0
               	and	x3, x4, x3
               	cbz	x3, <addr>
               	sub	x3, x0, #0x7
               	and	x3, x3, #0x3f
               	lsl	x2, x2, x3
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
