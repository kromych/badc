
layout_goto_block_addr.aarch64:	file format elf64-littleaarch64

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

<dispatch>:
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	stur	w0, [x29, #0x10]
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	adr	x2, <addr>
               	str	x2, [x0]
               	adr	x2, <addr>
               	str	x2, [x0, #0x8]
               	stur	w1, [x29, #-0x18]
               	stur	w1, [x29, #-0x20]
               	b	<addr>
               	ldursw	x1, [x29, #-0x18]
               	add	x1, x1, #0x2
               	stur	w1, [x29, #-0x18]
               	ldursw	x1, [x29, #-0x20]
               	add	x1, x1, #0x1
               	stur	w1, [x29, #-0x20]
               	b	<addr>
               	ldursw	x1, [x29, #-0x18]
               	add	x1, x1, #0x1
               	stur	w1, [x29, #-0x18]
               	ldursw	x1, [x29, #-0x20]
               	add	x1, x1, #0x1
               	stur	w1, [x29, #-0x20]
               	ldursw	x1, [x29, #-0x20]
               	ldursw	x2, [x29, #0x10]
               	cmp	w1, w2
               	b.lt	<addr>
               	ldursw	x0, [x29, #-0x18]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret
               	ldursw	x1, [x29, #-0x20]
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	ldr	x1, [x0, x1, lsl #3]
               	br	x1

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	add	x20, x0, #0x0
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	add	x20, x20, x0
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	add	x20, x20, x0
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	add	x20, x20, x0
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	add	x0, x20, x0
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
