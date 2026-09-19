
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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x3, x29, #0x10
               	mov	x1, #0x0                // =0
               	adr	x2, <addr>
               	str	x2, [x3]
               	adr	x2, <addr>
               	str	x2, [x3, #0x8]
               	mov	x2, x1
               	cmp	w1, w0
               	b.ge	<addr>
               	and	x4, x1, #0x1
               	ldr	x4, [x3, x4, lsl #3]
               	br	x4
               	add	x2, x2, #0x2
               	add	x1, x1, #0x1
               	b	<addr>
               	add	x2, x2, #0x1
               	add	x1, x1, #0x1
               	cmp	w1, w0
               	b.lt	<addr>
               	sxtw	x0, w2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	mov	x20, x0
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
