
empty_declaration.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x40
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x10
               	mov	x1, #0x7                // =7
               	str	w1, [x0]
               	sub	x0, x29, #0x10
               	mov	x1, #0x9                // =9
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x10
               	ldrsw	x0, [x0]
               	cmp	x0, #0x7
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x10
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x9
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x3                // =3
               	str	w1, [x0]
               	sub	x0, x29, #0x18
               	ldrsw	x0, [x0]
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x4                // =4
               	str	x1, [x0]
               	sub	x0, x29, #0x18
               	ldr	x0, [x0]
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	ldrsw	x0, [x0]
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x20
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x2
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x28
               	mov	x1, #0x7a               // =122
               	strb	w1, [x0]
               	sub	x0, x29, #0x28
               	ldrb	w0, [x0]
               	mov	x17, #0x7a              // =122
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xb                // =11
               	str	w1, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x1, #0xc                // =12
               	str	w1, [x2]
               	ldrsw	x0, [x0]
               	sxtw	x1, w1
               	add	x0, x0, x1
               	sxtw	x0, w0
               	cmp	x0, #0x17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
