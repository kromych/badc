
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
               	sxtw	x4, w4
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldrsw	x6, [x5]
               	add	x6, x6, #0x1
               	str	w6, [x5]
               	cmp	w4, #0x3e8
               	b.le	<addr>
               	mov	w0, w0
               	mov	w1, w1
               	sub	x4, x4, #0x1
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	w0, w0
               	mov	x17, #0x1               // =1
               	movk	x17, #0x4, lsl #16
               	cmp	w0, w17
               	b.ne	<addr>
               	mov	w0, w1
               	cmp	w0, #0x2
               	cset	x0, ne
               	cbnz	x0, <addr>
               	cmp	x2, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	cmp	x3, #0x7
               	cset	x0, ne
               	cbnz	x0, <addr>
               	cmp	w4, #0x3
               	cset	x0, ne
               	cbz	x0, <addr>
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
               	sxtw	x4, w4
               	mov	w0, w0
               	mov	x17, #0x40000           // =262144
               	orr	x0, x0, x17
               	mov	w1, w1
               	bl	<addr>
               	cbz	x0, <addr>
               	add	x1, x0, #0x18
               	ldr	x1, [x1]
               	mov	x17, #0x4               // =4
               	and	x1, x1, x17
               	cbz	x1, <addr>
               	mov	x1, #0x0                // =0
               	cbz	x1, <addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x1, x0, #0x10
               	ldr	x1, [x1]
               	mov	x17, #0x2               // =2
               	and	x1, x1, x17
               	cbz	x1, <addr>
               	mov	x1, #0x1                // =1
               	sxtw	x1, w1
               	b	<addr>
               	add	x1, x0, #0x8
               	ldr	x1, [x1]
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	cbz	x1, <addr>
               	mov	x1, #0x0                // =0
               	sxtw	x1, w1
               	b	<addr>
               	ldr	x1, [x0]
               	mov	x17, #0x40              // =64
               	and	x1, x1, x17
               	cmp	w1, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	b	<addr>

<main>:
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x1, #0x1                // =1
               	mov	x2, #0x2                // =2
               	mov	x3, #0x0                // =0
               	mov	x4, #0x7                // =7
               	mov	x5, #0x3                // =3
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	mov	x2, x3
               	mov	x3, x4
               	mov	x4, x5
               	blr	x9
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
