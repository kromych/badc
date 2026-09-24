
tail_call_outside_return_block.aarch64:	file format elf64-littleaarch64

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

<make>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldrsw	x6, [x5]
               	add	x6, x6, #0x1
               	str	w6, [x5]
               	cmp	w4, #0x3e8
               	b.le	<addr>
               	sub	x4, x4, #0x1
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0x1               // =1
               	movk	x17, #0x4, lsl #16
               	cmp	w0, w17
               	b.ne	<addr>
               	cmp	w1, #0x2
               	b.ne	<addr>
               	cbnz	x2, <addr>
               	cmp	x3, #0x7
               	b.ne	<addr>
               	cmp	w4, #0x3
               	b.eq	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x29, x30, [sp], #0x10
               	ret

<wrap>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	orr	x0, x0, #0x40000
               	bl	<addr>
               	cbz	x0, <addr>
               	ldr	x1, [x0, #0x18]
               	tbz	w1, #0x2, <addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x1, [x0, #0x10]
               	tbnz	w1, #0x1, <addr>
               	ldr	x1, [x0, #0x8]
               	tbnz	w1, #0x0, <addr>
               	ldr	x1, [x0]
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	mov	x2, #0x0                // =0
               	mov	x3, #0x7                // =7
               	mov	x4, #0x3                // =3
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldr	x5, [x5]
               	blr	x5
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
