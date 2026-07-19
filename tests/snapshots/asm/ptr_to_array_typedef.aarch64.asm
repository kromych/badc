
ptr_to_array_typedef.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xb0
               	mov	x1, #0x0                // =0
               	stur	x1, [x29, #-0x28]
               	b	<addr>
               	sub	x2, x29, #0x88
               	lsl	x3, x0, #5
               	add	x2, x2, x3
               	add	x3, x2, #0x0
               	lsl	x2, x0, #2
               	add	x2, x2, #0x0
               	sxtw	x2, w2
               	str	x2, [x3]
               	sub	x2, x29, #0x88
               	lsl	x3, x0, #5
               	add	x3, x2, x3
               	lsl	x2, x0, #2
               	add	x2, x2, #0x1
               	sxtw	x2, w2
               	str	x2, [x3, #0x8]
               	sub	x2, x29, #0x88
               	lsl	x3, x0, #5
               	add	x3, x2, x3
               	lsl	x2, x0, #2
               	add	x2, x2, #0x2
               	sxtw	x2, w2
               	str	x2, [x3, #0x10]
               	sub	x2, x29, #0x88
               	lsl	x3, x0, #5
               	add	x3, x2, x3
               	lsl	x2, x0, #2
               	add	x2, x2, #0x3
               	sxtw	x2, w2
               	str	x2, [x3, #0x18]
               	add	x1, x0, #0x1
               	sxtw	x0, w1
               	cmp	x0, #0x3
               	b.lt	<addr>
               	sub	x1, x29, #0x28
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, #0x2                // =2
               	str	x2, [x0, #0x18]
               	str	x0, [x1]
               	ldur	x0, [x29, #-0x28]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x28]
               	ldr	x0, [x0, #0x18]
               	cmp	x0, #0x2
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x28]
               	ldr	x0, [x0, #0x18]
               	cmp	x0, #0x2
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x28]
               	ldr	x0, [x0, #0x18]
               	add	x1, x0, #0x1e
               	sub	x0, x29, #0x88
               	ldr	x2, [x0, #0x30]
               	ldr	x0, [x0, #0x58]
               	add	x0, x2, x0
               	add	x0, x1, x0
               	sub	x0, x0, #0x7
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
