
builtin_type_macros.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0xa0
               	mov	x2, #0x1                // =1
               	sub	x0, x29, #0x40
               	str	x2, [x0]
               	mov	x1, #0x0                // =0
               	str	x1, [x0, #0x8]
               	lsl	x2, x2, #36
               	sub	x0, x29, #0x50
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	add	x3, x1, #0x3
               	cmp	x3, x1
               	cset	x0, lo
               	add	x2, x2, #0x0
               	add	x2, x2, x0
               	sub	x0, x29, #0x60
               	str	x3, [x0]
               	str	x2, [x0, #0x8]
               	sub	x2, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	sub	x0, x29, #0x30
               	ldr	x0, [x0, #0x8]
               	lsr	x2, x0, #36
               	sub	x0, x29, #0x70
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	cmp	x2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x30
               	ldr	x0, [x1]
               	ldr	x7, [x1, #0x8]
               	mov	x1, #0x5                // =5
               	mov	x2, #0x0                // =0
               	mul	x3, x0, x1
               	mov	w4, w0
               	lsr	x5, x0, #32
               	mul	x6, x4, x1
               	lsr	x6, x6, #32
               	mul	x8, x5, x1
               	add	x6, x8, x6
               	mov	w8, w6
               	lsr	x6, x6, #32
               	mul	x4, x4, x2
               	add	x4, x4, x8
               	lsr	x4, x4, #32
               	mul	x5, x5, x2
               	add	x5, x5, x6
               	add	x4, x5, x4
               	mul	x0, x0, x2
               	mul	x1, x7, x1
               	add	x0, x4, x0
               	add	x1, x0, x1
               	sub	x0, x29, #0x80
               	str	x3, [x0]
               	str	x1, [x0, #0x8]
               	cmp	x3, #0xf
               	cset	x0, lo
               	sub	x2, x3, #0xf
               	sub	x1, x1, #0x0
               	sub	x1, x1, x0
               	sub	x0, x29, #0x90
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	cmp	x2, #0x0
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	ldr	x4, [x0]
               	ldr	x2, [x0, #0x8]
               	mov	x3, #0x1                // =1
               	sub	x0, x29, #0xa0
               	str	x3, [x0]
               	mov	x1, #0x0                // =0
               	str	x1, [x0, #0x8]
               	cmp	x1, x2
               	cset	x0, lo
               	cmp	x1, x2
               	cset	x1, eq
               	cmp	x3, x4
               	cset	x2, lo
               	and	x1, x1, x2
               	orr	x0, x0, x1
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
