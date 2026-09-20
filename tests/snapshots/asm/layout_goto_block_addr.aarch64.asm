
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
               	mov	x3, x0
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	adr	x1, <addr>
               	str	x1, [x2]
               	adr	x1, <addr>
               	str	x1, [x2, #0x8]
               	mov	x1, x0
               	cmp	w0, w3
               	b.ge	<addr>
               	and	x4, x0, #0x1
               	ldr	x4, [x2, x4, lsl #3]
               	br	x4
               	add	x1, x1, #0x2
               	add	x0, x0, #0x1
               	b	<addr>
               	add	x1, x1, #0x1
               	add	x0, x0, #0x1
               	cmp	w0, w3
               	b.lt	<addr>
               	mov	x0, x1
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
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
