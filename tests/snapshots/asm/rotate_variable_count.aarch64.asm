
rotate_variable_count.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x1, w1
               	ror	x0, x0, x1
               	ret

<ref_ror>:
               	mov	x4, x0
               	mov	x5, x1
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	mov	x3, #0x1                // =1
               	lsl	x3, x3, x2
               	and	x3, x4, x3
               	cbz	x3, <addr>
               	sub	x3, x0, x5
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
               	mov	x0, x1
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x80]!
               	stp	x29, x30, [sp, #0x70]
               	add	x29, sp, #0x70
               	sub	x0, x29, #0x30
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
               	mov	x20, #0x0               // =0
               	b	<addr>
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0x40]
               	b	<addr>
               	sub	x0, x29, #0x30
               	mov	w1, w20
               	ldr	x1, [x0, x1, lsl #3]
               	ldursw	x0, [x29, #-0x40]
               	ror	x21, x1, x0
               	sub	x0, x29, #0x30
               	mov	w1, w20
               	ldr	x0, [x0, x1, lsl #3]
               	ldursw	x1, [x29, #-0x40]
               	bl	<addr>
               	cmp	x21, x0
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x40]
               	add	x0, x0, #0x1
               	stur	w0, [x29, #-0x40]
               	ldursw	x0, [x29, #-0x40]
               	cmp	x0, #0x40
               	b.lt	<addr>
               	mov	w0, w20
               	add	x20, x0, #0x1
               	mov	w0, w20
               	cmp	x0, #0x6
               	b.lo	<addr>
               	mov	x0, #0xcdef             // =52719
               	movk	x0, #0x89ab, lsl #16
               	movk	x0, #0x4567, lsl #32
               	movk	x0, #0x123, lsl #48
               	stur	x0, [x29, #-0x48]
               	ldur	x1, [x29, #-0x48]
               	lsr	x1, x1, #7
               	ldur	x2, [x29, #-0x48]
               	lsl	x2, x2, #57
               	orr	x20, x1, x2
               	mov	x1, #0x7                // =7
               	bl	<addr>
               	cmp	x20, x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x70]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x70]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x70]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	b	<addr>
               	b	<addr>
