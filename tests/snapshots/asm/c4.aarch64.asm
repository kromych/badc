
c4.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x520              // =1312
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x1
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0xa
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldr	x2, [x20]
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	ldr	x3, [x21]
               	sub	x2, x2, x3
               	bl	<addr>
               	sxtw	x0, w0
               	ldr	x0, [x20]
               	str	x0, [x21]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldr	x2, [x20]
               	add	x2, x2, #0x8
               	str	x2, [x20]
               	ldr	x2, [x2]
               	mov	x17, #0x5               // =5
               	mul	x2, x2, x17
               	add	x1, x1, x2
               	bl	<addr>
               	sxtw	x0, w0
               	ldr	x0, [x20]
               	ldr	x0, [x0]
               	cmp	x0, #0x7
               	b.gt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1]
               	add	x2, x2, #0x8
               	str	x2, [x1]
               	ldr	x1, [x2]
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	cmp	x0, x1
               	b.ge	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x23
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	cmp	x0, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0xa               // =10
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x1
               	str	x1, [x0]
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x61
               	cset	x0, ge
               	mov	x2, #0x0                // =0
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x7a
               	cset	x0, le
               	cmp	x0, #0x0
               	cset	x2, ne
               	mov	x1, #0x1                // =1
               	cbnz	x2, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x41
               	cset	x0, ge
               	mov	x2, #0x0                // =0
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x5a
               	cset	x0, le
               	cmp	x0, #0x0
               	cset	x2, ne
               	cmp	x2, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x5f
               	cset	x1, eq
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x30
               	cset	x1, ge
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x39
               	cset	x1, le
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x2f
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0x2f              // =47
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x1
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	cmp	x0, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0xa               // =10
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x1
               	str	x1, [x0]
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x27
               	cset	x1, eq
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x22
               	cset	x1, eq
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x3d
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x2b
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x2d
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x21
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x3c
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x3e
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x7c
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x26
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x5e
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x25
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x5b
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x3f
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x7e
               	cset	x0, eq
               	mov	x2, #0x1                // =1
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x3b
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x2, ne
               	mov	x1, #0x1                // =1
               	cbnz	x2, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x7b
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x2, #0x1                // =1
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x7d
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x2, ne
               	mov	x1, #0x1                // =1
               	cbnz	x2, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x28
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x2, #0x1                // =1
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x29
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x2, ne
               	mov	x1, #0x1                // =1
               	cbnz	x2, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x5d
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x2, #0x1                // =1
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x2c
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x2, ne
               	cbnz	x2, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x3a
               	cset	x2, eq
               	cbz	x2, <addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x1
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	ldrb	w1, [x1]
               	str	x1, [x0]
               	cbnz	x1, <addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x8f               // =143
               	str	x1, [x0]
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xa4               // =164
               	str	x1, [x0]
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x9f               // =159
               	str	x1, [x0]
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xa1               // =161
               	str	x1, [x0]
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x93               // =147
               	str	x1, [x0]
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0x26              // =38
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x1
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x91               // =145
               	str	x1, [x0]
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x94               // =148
               	str	x1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0x7c              // =124
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x1
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x90               // =144
               	str	x1, [x0]
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x92               // =146
               	str	x1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0x3d              // =61
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x1
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x9a               // =154
               	str	x1, [x0]
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0x3e              // =62
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x1
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x9c               // =156
               	str	x1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x98               // =152
               	str	x1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0x3d              // =61
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x1
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x99               // =153
               	str	x1, [x0]
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0x3c              // =60
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x1
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x9b               // =155
               	str	x1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x97               // =151
               	str	x1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0x3d              // =61
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x1
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x96               // =150
               	str	x1, [x0]
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0x2d              // =45
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x1
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xa3               // =163
               	str	x1, [x0]
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x9e               // =158
               	str	x1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0x2b              // =43
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x1
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xa2               // =162
               	str	x1, [x0]
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x9d               // =157
               	str	x1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0x3d              // =61
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x1
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x95               // =149
               	str	x1, [x0]
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x8e               // =142
               	str	x1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	ldrb	w1, [x1]
               	cmp	x1, #0x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	ldrb	w1, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	cmp	x1, x2
               	cset	x2, ne
               	cbz	x2, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x3, [x2]
               	add	x4, x3, #0x1
               	str	x4, [x2]
               	ldrb	w2, [x3]
               	str	x2, [x1]
               	cmp	x2, #0x5c
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x3, [x2]
               	add	x4, x3, #0x1
               	str	x4, [x2]
               	ldrb	w2, [x3]
               	str	x2, [x1]
               	cmp	x2, #0x6e
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0xa                // =10
               	str	x2, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	cmp	x1, #0x22
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1]
               	add	x3, x2, #0x1
               	str	x3, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	strb	w1, [x2]
               	b	<addr>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1]
               	add	x2, x2, #0x1
               	str	x2, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	cmp	x1, #0x22
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x0, [x1]
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x80               // =128
               	str	x1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xa0               // =160
               	str	x1, [x0]
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	sub	x1, x1, #0x30
               	str	x1, [x0]
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	cmp	x0, #0x30
               	cset	x1, ge
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	cmp	x0, #0x39
               	cset	x1, le
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	mov	x17, #0xa               // =10
               	mul	x1, x1, x17
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x3, [x2]
               	add	x4, x3, #0x1
               	str	x4, [x2]
               	ldrb	w2, [x3]
               	add	x1, x1, x2
               	sub	x1, x1, #0x30
               	str	x1, [x0]
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x80               // =128
               	str	x1, [x0]
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0x78              // =120
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0x58              // =88
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1]
               	add	x2, x2, #0x1
               	str	x2, [x1]
               	ldrb	w1, [x2]
               	str	x1, [x0]
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x30
               	cset	x0, ge
               	mov	x2, #0x0                // =0
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x39
               	cset	x0, le
               	cmp	x0, #0x0
               	cset	x2, ne
               	mov	x3, #0x1                // =1
               	cbnz	x2, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x61
               	cset	x0, ge
               	mov	x2, #0x0                // =0
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x66
               	cset	x0, le
               	cmp	x0, #0x0
               	cset	x2, ne
               	cmp	x2, #0x0
               	cset	x3, ne
               	mov	x1, #0x1                // =1
               	cbnz	x3, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x41
               	cset	x0, ge
               	mov	x2, #0x0                // =0
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x46
               	cset	x0, le
               	cmp	x0, #0x0
               	cset	x2, ne
               	cmp	x2, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	lsl	x1, x1, #4
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x3, [x2]
               	mov	x17, #0xf               // =15
               	and	x4, x3, x17
               	add	x1, x1, x4
               	cmp	x3, #0x41
               	b.lt	<addr>
               	mov	x3, #0x9                // =9
               	add	x1, x1, x3
               	str	x1, [x0]
               	b	<addr>
               	mov	x3, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	cmp	x0, #0x30
               	cset	x1, ge
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	cmp	x0, #0x37
               	cset	x1, le
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	lsl	x1, x1, #3
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x3, [x2]
               	add	x4, x3, #0x1
               	str	x4, [x2]
               	ldrb	w2, [x3]
               	add	x1, x1, x2
               	sub	x1, x1, #0x30
               	str	x1, [x0]
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	sub	x20, x0, #0x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	cmp	x0, #0x61
               	cset	x0, ge
               	mov	x2, #0x0                // =0
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	cmp	x0, #0x7a
               	cset	x0, le
               	cmp	x0, #0x0
               	cset	x2, ne
               	mov	x1, #0x1                // =1
               	cbnz	x2, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	cmp	x0, #0x41
               	cset	x0, ge
               	mov	x2, #0x0                // =0
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	cmp	x0, #0x5a
               	cset	x0, le
               	cmp	x0, #0x0
               	cset	x2, ne
               	cmp	x2, #0x0
               	cset	x1, ne
               	mov	x2, #0x1                // =1
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	cmp	x0, #0x30
               	cset	x0, ge
               	mov	x2, #0x0                // =0
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	cmp	x0, #0x39
               	cset	x0, le
               	cmp	x0, #0x0
               	cset	x2, ne
               	cmp	x2, #0x0
               	cset	x2, ne
               	cbnz	x2, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0x5f              // =95
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x2, eq
               	cbz	x2, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	mov	x17, #0x93              // =147
               	mul	x1, x1, x17
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x3, [x2]
               	add	x4, x3, #0x1
               	str	x4, [x2]
               	ldrb	w2, [x3]
               	add	x1, x1, x2
               	str	x1, [x0]
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	lsl	x1, x1, #6
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	sub	x2, x2, x20
               	add	x1, x1, x2
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	str	x1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	ldr	x1, [x1, #0x8]
               	cmp	x0, x1
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldr	x0, [x0, #0x10]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	sub	x2, x1, x20
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x48
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldr	x0, [x0]
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	str	x20, [x1, #0x10]
               	ldr	x1, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x3, [x2]
               	str	x3, [x1, #0x8]
               	ldr	x0, [x0]
               	mov	x1, #0x0                // =0
               	mov	x3, #0x85               // =133
               	str	x3, [x0]
               	str	x3, [x2]
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x2, #0x0                // =0
               	ldr	x1, [x1]
               	str	x1, [x0]
               	mov	x0, x2
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>

<expr>:
               	stp	x20, x21, [sp, #-0x40]!
               	stp	x22, x23, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x20, x0
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	ldr	x0, [x21]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x22, [x0]
               	ldr	x0, [x21]
               	cmp	x0, #0x8e
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldr	x0, [x0]
               	cmp	x0, #0xa
               	cset	x1, eq
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldr	x0, [x0]
               	cmp	x0, #0x9
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x1, #0xd                // =13
               	str	x1, [x0]
               	mov	x0, #0x8e               // =142
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x22, [x0]
               	cmp	x22, #0x0
               	b.ne	<addr>
               	mov	x2, #0xc                // =12
               	str	x2, [x1]
               	b	<addr>
               	mov	x2, #0xb                // =11
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x8f
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x4                // =4
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x22, x1, #0x8
               	str	x22, [x0]
               	mov	x0, #0x8e               // =142
               	bl	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x3a
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x23, <page>
               	add	x23, x23, <lo12>
               	ldr	x0, [x23]
               	add	x0, x0, #0x18
               	str	x0, [x22]
               	ldr	x0, [x23]
               	add	x0, x0, #0x8
               	str	x0, [x23]
               	mov	x1, #0x2                // =2
               	str	x1, [x0]
               	ldr	x0, [x23]
               	add	x22, x0, #0x8
               	str	x22, [x23]
               	mov	x0, #0x8f               // =143
               	bl	<addr>
               	ldr	x0, [x23]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x90
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0x5                // =5
               	str	x1, [x0]
               	ldr	x0, [x22]
               	add	x23, x0, #0x8
               	str	x23, [x22]
               	mov	x0, #0x91               // =145
               	bl	<addr>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x23]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x91
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0x4                // =4
               	str	x1, [x0]
               	ldr	x0, [x22]
               	add	x23, x0, #0x8
               	str	x23, [x22]
               	mov	x0, #0x92               // =146
               	bl	<addr>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x23]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x92
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0xd                // =13
               	str	x1, [x0]
               	mov	x0, #0x93               // =147
               	bl	<addr>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0xe                // =14
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x93
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0xd                // =13
               	str	x1, [x0]
               	mov	x0, #0x94               // =148
               	bl	<addr>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0xf                // =15
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x94
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0xd                // =13
               	str	x1, [x0]
               	mov	x0, #0x95               // =149
               	bl	<addr>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0x10               // =16
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x95
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0xd                // =13
               	str	x1, [x0]
               	mov	x0, #0x97               // =151
               	bl	<addr>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0x11               // =17
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x96
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0xd                // =13
               	str	x1, [x0]
               	mov	x0, #0x97               // =151
               	bl	<addr>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0x12               // =18
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x97
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0xd                // =13
               	str	x1, [x0]
               	mov	x0, #0x9b               // =155
               	bl	<addr>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0x13               // =19
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x98
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0xd                // =13
               	str	x1, [x0]
               	mov	x0, #0x9b               // =155
               	bl	<addr>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0x14               // =20
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x99
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0xd                // =13
               	str	x1, [x0]
               	mov	x0, #0x9b               // =155
               	bl	<addr>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0x15               // =21
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x9a
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0xd                // =13
               	str	x1, [x0]
               	mov	x0, #0x9b               // =155
               	bl	<addr>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0x16               // =22
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x9b
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0xd                // =13
               	str	x1, [x0]
               	mov	x0, #0x9d               // =157
               	bl	<addr>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0x17               // =23
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x9c
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0xd                // =13
               	str	x1, [x0]
               	mov	x0, #0x9d               // =157
               	bl	<addr>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0x18               // =24
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x9d
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x0, #0xd                // =13
               	str	x0, [x1]
               	mov	x0, #0x9f               // =159
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x22, [x0]
               	cmp	x22, #0x2
               	b.le	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0xd                // =13
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x1                // =1
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x8                // =8
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x0, #0x1b               // =27
               	str	x0, [x1]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x0, #0x19               // =25
               	str	x0, [x1]
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x9e
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x0, #0xd                // =13
               	str	x0, [x1]
               	mov	x0, #0x9f               // =159
               	bl	<addr>
               	cmp	x22, #0x2
               	cset	x1, gt
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x22, x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x1a               // =26
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0xd                // =13
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x1                // =1
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x3, #0x8                // =8
               	str	x3, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x0, #0x1c               // =28
               	str	x0, [x1]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x2, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x22, [x0]
               	cmp	x22, #0x2
               	b.le	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0xd                // =13
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x1                // =1
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x8                // =8
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x1b               // =27
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x0, #0x1a               // =26
               	str	x0, [x1]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x0, #0x1a               // =26
               	str	x0, [x1]
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x9f
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0xd                // =13
               	str	x1, [x0]
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0x1b               // =27
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0xa0
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0xd                // =13
               	str	x1, [x0]
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0x1c               // =28
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0xa1
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0xd                // =13
               	str	x1, [x0]
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0x1d               // =29
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0xa2
               	cset	x1, eq
               	cbnz	x1, <addr>
               	ldr	x0, [x21]
               	cmp	x0, #0xa3
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldr	x0, [x0]
               	cmp	x0, #0xa
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	mov	x2, #0xd                // =13
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x0, #0xa                // =10
               	str	x0, [x1]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0xd                // =13
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x1                // =1
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x2
               	b.le	<addr>
               	mov	x2, #0x8                // =8
               	str	x2, [x1]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	ldr	x0, [x21]
               	cmp	x0, #0xa2
               	b.ne	<addr>
               	mov	x2, #0x19               // =25
               	str	x2, [x1]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x2, #0xc                // =12
               	str	x2, [x1]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0xd                // =13
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x1                // =1
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x2
               	b.le	<addr>
               	mov	x2, #0x8                // =8
               	str	x2, [x1]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	ldr	x0, [x21]
               	cmp	x0, #0xa2
               	b.ne	<addr>
               	mov	x2, #0x1a               // =26
               	str	x2, [x1]
               	bl	<addr>
               	b	<addr>
               	mov	x2, #0x19               // =25
               	b	<addr>
               	mov	x2, #0x1                // =1
               	b	<addr>
               	mov	x2, #0xb                // =11
               	b	<addr>
               	mov	x2, #0x1a               // =26
               	b	<addr>
               	mov	x2, #0x1                // =1
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldr	x0, [x0]
               	cmp	x0, #0x9
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	mov	x2, #0xd                // =13
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x0, #0x9                // =9
               	str	x0, [x1]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0xa4
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x0, #0xd                // =13
               	str	x0, [x1]
               	mov	x0, #0x8e               // =142
               	bl	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x5d
               	b.ne	<addr>
               	bl	<addr>
               	cmp	x22, #0x2
               	b.le	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0xd                // =13
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x1                // =1
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x8                // =8
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x0, #0x1b               // =27
               	str	x0, [x1]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x19               // =25
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x2, x22, #0x2
               	str	x2, [x0]
               	cmp	x2, #0x0
               	b.ne	<addr>
               	mov	x2, #0xa                // =10
               	str	x2, [x1]
               	b	<addr>
               	mov	x2, #0x9                // =9
               	b	<addr>
               	cmp	x22, #0x2
               	b.ge	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	ldr	x2, [x21]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	ldr	x0, [x21]
               	cmp	x0, x20
               	b.ge	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	ldr	x0, [x21]
               	cmp	x0, #0x80
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x22, #0x1               // =1
               	str	x22, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	str	x0, [x1]
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x22, [x0]
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x22
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x1                // =1
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	str	x0, [x1]
               	bl	<addr>
               	b	<addr>
               	bl	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x22
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x2                // =2
               	str	x1, [x0]
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x8c
               	b.ne	<addr>
               	bl	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x28
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	ldr	x0, [x21]
               	cmp	x0, #0x8a
               	b.ne	<addr>
               	bl	<addr>
               	b	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x2
               	str	x1, [x0]
               	ldr	x0, [x21]
               	cmp	x0, #0x9f
               	b.eq	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x29
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x1                // =1
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x2, #0x1                // =1
               	str	x2, [x1]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	b	<addr>
               	mov	x2, #0x8                // =8
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x86
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x85
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x22, [x0]
               	bl	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x28
               	b.ne	<addr>
               	bl	<addr>
               	mov	x23, #0x0               // =0
               	b	<addr>
               	mov	x0, #0x8e               // =142
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x0, #0xd                // =13
               	str	x0, [x1]
               	add	x23, x23, #0x1
               	ldr	x0, [x21]
               	cmp	x0, #0x2c
               	b.ne	<addr>
               	bl	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x29
               	b.ne	<addr>
               	bl	<addr>
               	ldr	x0, [x22, #0x18]
               	cmp	x0, #0x82
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	ldr	x0, [x22, #0x28]
               	str	x0, [x1]
               	cbz	x23, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x7                // =7
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	str	x23, [x1]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x22, #0x20]
               	str	x1, [x0]
               	b	<addr>
               	ldr	x0, [x22, #0x18]
               	cmp	x0, #0x81
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x3                // =3
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	ldr	x0, [x22, #0x28]
               	str	x0, [x1]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	ldr	x0, [x22, #0x18]
               	cmp	x0, #0x80
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x1                // =1
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	ldr	x0, [x22, #0x28]
               	str	x0, [x1]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x2, [x0]
               	b	<addr>
               	ldr	x0, [x22, #0x18]
               	cmp	x0, #0x84
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x0                // =0
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldr	x2, [x22, #0x28]
               	sub	x0, x0, x2
               	str	x0, [x1]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x22, #0x20]
               	str	x2, [x0]
               	cmp	x2, #0x0
               	b.ne	<addr>
               	mov	x2, #0xa                // =10
               	str	x2, [x1]
               	b	<addr>
               	mov	x2, #0x9                // =9
               	b	<addr>
               	ldr	x0, [x22, #0x18]
               	cmp	x0, #0x83
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x1                // =1
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	ldr	x0, [x22, #0x28]
               	str	x0, [x1]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x28
               	b.ne	<addr>
               	bl	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x8a
               	cset	x1, eq
               	cbnz	x1, <addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x86
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x8a
               	b.ne	<addr>
               	mov	x22, #0x1               // =1
               	bl	<addr>
               	b	<addr>
               	bl	<addr>
               	add	x22, x22, #0x2
               	ldr	x0, [x21]
               	cmp	x0, #0x9f
               	b.eq	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x29
               	b.ne	<addr>
               	bl	<addr>
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x22, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	mov	x22, #0x0               // =0
               	b	<addr>
               	mov	x0, #0x8e               // =142
               	bl	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x29
               	b.ne	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x9f
               	b.ne	<addr>
               	bl	<addr>
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x1
               	b.le	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	sub	x1, x1, #0x2
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x2, #0xa                // =10
               	str	x2, [x1]
               	b	<addr>
               	mov	x2, #0x9                // =9
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x94
               	b.ne	<addr>
               	bl	<addr>
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldr	x0, [x0]
               	cmp	x0, #0xa
               	cset	x1, eq
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldr	x0, [x0]
               	cmp	x0, #0x9
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	sub	x1, x1, #0x8
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x2
               	str	x1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x21
               	b.ne	<addr>
               	bl	<addr>
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0xd                // =13
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x1                // =1
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x3, #0x0                // =0
               	str	x3, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x0, #0x11               // =17
               	str	x0, [x1]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x2, [x0]
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x7e
               	b.ne	<addr>
               	bl	<addr>
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0xd                // =13
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x1                // =1
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	str	x3, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x0, #0xf                // =15
               	str	x0, [x1]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x2, [x0]
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x9d
               	b.ne	<addr>
               	bl	<addr>
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x9e
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x0, #0x1                // =1
               	str	x0, [x1]
               	ldr	x0, [x21]
               	cmp	x0, #0x80
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x0, x0, x17
               	str	x0, [x1]
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	b	<addr>
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	str	x1, [x0]
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0xd                // =13
               	str	x1, [x0]
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0x1b               // =27
               	str	x1, [x0]
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0xa2
               	cset	x1, eq
               	cbnz	x1, <addr>
               	ldr	x0, [x21]
               	cmp	x0, #0xa3
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldr	x22, [x21]
               	bl	<addr>
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldr	x0, [x0]
               	cmp	x0, #0xa
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	mov	x2, #0xd                // =13
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x0, #0xa                // =10
               	str	x0, [x1]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0xd                // =13
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x1                // =1
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x2
               	b.le	<addr>
               	mov	x2, #0x8                // =8
               	str	x2, [x1]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	cmp	x22, #0xa2
               	b.ne	<addr>
               	mov	x2, #0x19               // =25
               	str	x2, [x1]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x2, #0xc                // =12
               	str	x2, [x1]
               	b	<addr>
               	mov	x2, #0xb                // =11
               	b	<addr>
               	mov	x2, #0x1a               // =26
               	b	<addr>
               	mov	x2, #0x1                // =1
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldr	x0, [x0]
               	cmp	x0, #0x9
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	mov	x2, #0xd                // =13
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x0, #0x9                // =9
               	str	x0, [x1]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>

<stmt>:
               	stp	x20, x21, [sp, #-0x40]!
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldr	x0, [x20]
               	cmp	x0, #0x89
               	b.ne	<addr>
               	bl	<addr>
               	ldr	x0, [x20]
               	cmp	x0, #0x28
               	b.ne	<addr>
               	bl	<addr>
               	mov	x0, #0x8e               // =142
               	bl	<addr>
               	ldr	x0, [x20]
               	cmp	x0, #0x29
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x4                // =4
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x21, x1, #0x8
               	str	x21, [x0]
               	bl	<addr>
               	ldr	x0, [x20]
               	cmp	x0, #0x87
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x18
               	str	x1, [x21]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x2                // =2
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x21, x1, #0x8
               	str	x21, [x0]
               	bl	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	add	x0, x0, #0x8
               	str	x0, [x21]
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	ldr	x0, [x20]
               	cmp	x0, #0x8d
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	add	x21, x0, #0x8
               	ldr	x0, [x20]
               	cmp	x0, #0x28
               	b.ne	<addr>
               	bl	<addr>
               	mov	x0, #0x8e               // =142
               	bl	<addr>
               	ldr	x0, [x20]
               	cmp	x0, #0x29
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldr	x0, [x20]
               	add	x0, x0, #0x8
               	str	x0, [x20]
               	mov	x1, #0x4                // =4
               	str	x1, [x0]
               	ldr	x0, [x20]
               	add	x22, x0, #0x8
               	str	x22, [x20]
               	bl	<addr>
               	ldr	x0, [x20]
               	add	x0, x0, #0x8
               	str	x0, [x20]
               	mov	x1, #0x2                // =2
               	str	x1, [x0]
               	ldr	x0, [x20]
               	add	x0, x0, #0x8
               	str	x0, [x20]
               	str	x21, [x0]
               	ldr	x0, [x20]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	ldr	x0, [x20]
               	cmp	x0, #0x8b
               	b.ne	<addr>
               	bl	<addr>
               	ldr	x0, [x20]
               	cmp	x0, #0x3b
               	b.eq	<addr>
               	mov	x0, #0x8e               // =142
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x0, #0x8                // =8
               	str	x0, [x1]
               	ldr	x0, [x20]
               	cmp	x0, #0x3b
               	b.ne	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	ldr	x0, [x20]
               	cmp	x0, #0x7b
               	b.ne	<addr>
               	bl	<addr>
               	b	<addr>
               	bl	<addr>
               	ldr	x0, [x20]
               	cmp	x0, #0x7d
               	b.ne	<addr>
               	bl	<addr>
               	b	<addr>
               	ldr	x0, [x20]
               	cmp	x0, #0x3b
               	b.ne	<addr>
               	bl	<addr>
               	b	<addr>
               	mov	x0, #0x8e               // =142
               	bl	<addr>
               	ldr	x0, [x20]
               	cmp	x0, #0x3b
               	b.ne	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>

<main>:
               	stp	x20, x21, [sp, #-0x140]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	str	x19, [sp, #0x40]
               	stp	x29, x30, [sp, #0x130]
               	add	x29, sp, #0x130
               	sub	x20, x0, #0x1
               	add	x21, x1, #0x8
               	cmp	x20, #0x0
               	cset	x0, gt
               	mov	x2, #0x0                // =0
               	cbz	x0, <addr>
               	ldr	x0, [x21]
               	ldrb	w0, [x0]
               	mov	x17, #0x2d              // =45
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	ldr	x0, [x21]
               	ldrb	w0, [x0, #0x1]
               	mov	x17, #0x73              // =115
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x2, eq
               	cbz	x2, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	sub	x20, x20, #0x1
               	add	x21, x21, #0x8
               	cmp	x20, #0x0
               	cset	x0, gt
               	mov	x2, #0x0                // =0
               	cbz	x0, <addr>
               	ldr	x0, [x21]
               	ldrb	w0, [x0]
               	mov	x17, #0x2d              // =45
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	ldr	x0, [x21]
               	ldrb	w0, [x0, #0x1]
               	mov	x17, #0x64              // =100
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x2, eq
               	cbz	x2, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	sub	x20, x20, #0x1
               	add	x21, x21, #0x8
               	cmp	x20, #0x1
               	b.ge	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldp	x29, x30, [sp, #0x130]
               	ldr	x19, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	ldr	x0, [x21]
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x22, x0
               	cmp	x22, #0x0
               	b.ge	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x21]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldp	x29, x30, [sp, #0x130]
               	ldr	x19, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	mov	x23, #0x40000           // =262144
               	adrp	x24, <page>
               	add	x24, x24, <lo12>
               	mov	x0, #0x40000            // =262144
               	bl	<addr>
               	str	x0, [x24]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldp	x29, x30, [sp, #0x130]
               	ldr	x19, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	adrp	x24, <page>
               	add	x24, x24, <lo12>
               	adrp	x25, <page>
               	add	x25, x25, <lo12>
               	mov	x0, #0x40000            // =262144
               	bl	<addr>
               	str	x0, [x25]
               	str	x0, [x24]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldp	x29, x30, [sp, #0x130]
               	ldr	x19, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	adrp	x24, <page>
               	add	x24, x24, <lo12>
               	mov	x0, #0x40000            // =262144
               	bl	<addr>
               	str	x0, [x24]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldp	x29, x30, [sp, #0x130]
               	ldr	x19, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	mov	x0, #0x40000            // =262144
               	bl	<addr>
               	mov	x24, x0
               	cmp	x24, #0x0
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldp	x29, x30, [sp, #0x130]
               	ldr	x19, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x25, #0x0               // =0
               	mov	x2, #0x40000            // =262144
               	mov	x1, x25
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x2, #0x40000            // =262144
               	mov	x1, x25
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x2, #0x40000            // =262144
               	mov	x1, x25
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x1, [x0]
               	mov	x25, #0x86              // =134
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x26, #0x87              // =135
               	str	x25, [x0]
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x25, #0x88              // =136
               	str	x26, [x0]
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x26, #0x89              // =137
               	str	x25, [x0]
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x25, #0x8a              // =138
               	str	x26, [x0]
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x26, #0x8b              // =139
               	str	x25, [x0]
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x25, #0x8c              // =140
               	str	x26, [x0]
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x26, #0x8d              // =141
               	str	x25, [x0]
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	str	x26, [x0]
               	mov	x25, #0x1e              // =30
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	mov	x2, #0x82               // =130
               	str	x2, [x1, #0x18]
               	ldr	x1, [x0]
               	mov	x2, #0x1                // =1
               	str	x2, [x1, #0x20]
               	ldr	x0, [x0]
               	mov	x26, #0x1f              // =31
               	str	x25, [x0, #0x28]
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	mov	x2, #0x82               // =130
               	str	x2, [x1, #0x18]
               	ldr	x1, [x0]
               	mov	x2, #0x1                // =1
               	str	x2, [x1, #0x20]
               	ldr	x0, [x0]
               	mov	x25, #0x20              // =32
               	str	x26, [x0, #0x28]
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	mov	x2, #0x82               // =130
               	str	x2, [x1, #0x18]
               	ldr	x1, [x0]
               	mov	x2, #0x1                // =1
               	str	x2, [x1, #0x20]
               	ldr	x0, [x0]
               	mov	x26, #0x21              // =33
               	str	x25, [x0, #0x28]
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	mov	x2, #0x82               // =130
               	str	x2, [x1, #0x18]
               	ldr	x1, [x0]
               	mov	x2, #0x1                // =1
               	str	x2, [x1, #0x20]
               	ldr	x0, [x0]
               	mov	x25, #0x22              // =34
               	str	x26, [x0, #0x28]
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	mov	x2, #0x82               // =130
               	str	x2, [x1, #0x18]
               	ldr	x1, [x0]
               	mov	x2, #0x1                // =1
               	str	x2, [x1, #0x20]
               	ldr	x0, [x0]
               	mov	x26, #0x23              // =35
               	str	x25, [x0, #0x28]
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	mov	x2, #0x82               // =130
               	str	x2, [x1, #0x18]
               	ldr	x1, [x0]
               	mov	x2, #0x1                // =1
               	str	x2, [x1, #0x20]
               	ldr	x0, [x0]
               	mov	x25, #0x24              // =36
               	str	x26, [x0, #0x28]
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	mov	x2, #0x82               // =130
               	str	x2, [x1, #0x18]
               	ldr	x1, [x0]
               	mov	x2, #0x1                // =1
               	str	x2, [x1, #0x20]
               	ldr	x0, [x0]
               	mov	x26, #0x25              // =37
               	str	x25, [x0, #0x28]
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	mov	x2, #0x82               // =130
               	str	x2, [x1, #0x18]
               	ldr	x1, [x0]
               	mov	x2, #0x1                // =1
               	str	x2, [x1, #0x20]
               	ldr	x0, [x0]
               	mov	x25, #0x26              // =38
               	str	x26, [x0, #0x28]
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	mov	x2, #0x82               // =130
               	str	x2, [x1, #0x18]
               	ldr	x1, [x0]
               	mov	x2, #0x1                // =1
               	str	x2, [x1, #0x20]
               	ldr	x0, [x0]
               	str	x25, [x0, #0x28]
               	bl	<addr>
               	adrp	x25, <page>
               	add	x25, x25, <lo12>
               	ldr	x0, [x25]
               	mov	x1, #0x86               // =134
               	str	x1, [x0]
               	bl	<addr>
               	ldr	x25, [x25]
               	adrp	x26, <page>
               	add	x26, x26, <lo12>
               	adrp	x27, <page>
               	add	x27, x27, <lo12>
               	mov	x0, #0x40000            // =262144
               	bl	<addr>
               	str	x0, [x27]
               	str	x0, [x26]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldp	x29, x30, [sp, #0x130]
               	ldr	x19, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	sxtw	x0, w22
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x2, #0xffff             // =65535
               	movk	x2, #0x3, lsl #16
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.gt	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldp	x29, x30, [sp, #0x130]
               	ldr	x19, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	add	x0, x1, x0
               	mov	x1, #0x0                // =0
               	strb	w1, [x0]
               	sxtw	x0, w22
               	bl	<addr>
               	sxtw	x0, w0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	bl	<addr>
               	b	<addr>
               	mov	x22, #0x1               // =1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x8a
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x3b
               	cset	x1, ne
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x7d
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x26, x22
               	b	<addr>
               	bl	<addr>
               	add	x26, x26, #0x2
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x9f
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x85
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldr	x0, [x0, #0x18]
               	cbnz	x0, <addr>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	str	x26, [x0, #0x20]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x28
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	mov	x2, #0x81               // =129
               	str	x2, [x1, #0x18]
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	add	x1, x1, #0x8
               	str	x1, [x0, #0x28]
               	bl	<addr>
               	mov	x26, #0x0               // =0
               	b	<addr>
               	mov	x27, #0x1               // =1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x8a
               	b.ne	<addr>
               	bl	<addr>
               	b	<addr>
               	bl	<addr>
               	add	x27, x27, #0x2
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x9f
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x85
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldr	x0, [x0, #0x18]
               	cmp	x0, #0x84
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldr	x2, [x1, #0x18]
               	str	x2, [x1, #0x30]
               	ldr	x1, [x0]
               	mov	x2, #0x84               // =132
               	str	x2, [x1, #0x18]
               	ldr	x1, [x0]
               	ldr	x2, [x1, #0x20]
               	str	x2, [x1, #0x38]
               	ldr	x1, [x0]
               	str	x27, [x1, #0x20]
               	ldr	x1, [x0]
               	ldr	x2, [x1, #0x28]
               	str	x2, [x1, #0x40]
               	ldr	x0, [x0]
               	add	x27, x26, #0x1
               	str	x26, [x0, #0x28]
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x2c
               	b.ne	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x86
               	b.ne	<addr>
               	bl	<addr>
               	mov	x27, #0x0               // =0
               	b	<addr>
               	b	<addr>
               	mov	x26, x27
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x29
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x7b
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x26, x26, #0x1
               	str	x26, [x0]
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x8a
               	cset	x1, eq
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x86
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x8a
               	b.ne	<addr>
               	mov	x22, #0x1               // =1
               	bl	<addr>
               	b	<addr>
               	mov	x27, x22
               	b	<addr>
               	bl	<addr>
               	add	x27, x27, #0x2
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x9f
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x85
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldr	x0, [x0, #0x18]
               	cmp	x0, #0x84
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldr	x2, [x1, #0x18]
               	str	x2, [x1, #0x30]
               	ldr	x1, [x0]
               	mov	x2, #0x84               // =132
               	str	x2, [x1, #0x18]
               	ldr	x1, [x0]
               	ldr	x2, [x1, #0x20]
               	str	x2, [x1, #0x38]
               	ldr	x1, [x0]
               	str	x27, [x1, #0x20]
               	ldr	x1, [x0]
               	ldr	x2, [x1, #0x28]
               	str	x2, [x1, #0x40]
               	ldr	x0, [x0]
               	add	x26, x26, #0x1
               	str	x26, [x0, #0x28]
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x2c
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x3b
               	b.ne	<addr>
               	bl	<addr>
               	b	<addr>
               	mov	x22, #0x0               // =0
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x6                // =6
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	sub	x0, x26, x0
               	str	x0, [x1]
               	b	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x7d
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x0, #0x8                // =8
               	str	x0, [x1]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	str	x1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldr	x0, [x0, #0x18]
               	cmp	x0, #0x84
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldr	x2, [x1, #0x30]
               	str	x2, [x1, #0x18]
               	ldr	x1, [x0]
               	ldr	x2, [x1, #0x38]
               	str	x2, [x1, #0x20]
               	ldr	x1, [x0]
               	ldr	x0, [x1, #0x40]
               	str	x0, [x1, #0x28]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x1, x1, #0x48
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldr	x0, [x0]
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x2c
               	b.ne	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	mov	x2, #0x83               // =131
               	str	x2, [x1, #0x18]
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1]
               	str	x2, [x0, #0x28]
               	ldr	x0, [x1]
               	add	x0, x0, #0x8
               	str	x0, [x1]
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x86
               	b.ne	<addr>
               	bl	<addr>
               	mov	x22, #0x0               // =0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x88
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x7b
               	b.eq	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x7b
               	b.ne	<addr>
               	bl	<addr>
               	mov	x26, #0x0               // =0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x85
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x8e
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x80
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x27, [x0]
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	mov	x2, #0x80               // =128
               	str	x2, [x1, #0x18]
               	ldr	x1, [x0]
               	mov	x2, #0x1                // =1
               	str	x2, [x1, #0x20]
               	ldr	x0, [x0]
               	add	x26, x27, #0x1
               	str	x27, [x0, #0x28]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x2c
               	b.ne	<addr>
               	bl	<addr>
               	b	<addr>
               	mov	x27, x26
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x7d
               	b.ne	<addr>
               	bl	<addr>
               	b	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cbnz	x0, <addr>
               	ldr	x3, [x25, #0x28]
               	cmp	x3, #0x0
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldp	x29, x30, [sp, #0x130]
               	ldr	x19, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x130]
               	ldr	x19, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	add	x22, x24, x23
               	sub	x0, x22, #0x8
               	mov	x1, #0x26               // =38
               	str	x1, [x0]
               	sub	x0, x0, #0x8
               	mov	x1, #0xd                // =13
               	str	x1, [x0]
               	sub	x1, x0, #0x8
               	str	x20, [x1]
               	sub	x1, x1, #0x8
               	str	x21, [x1]
               	sub	x21, x1, #0x8
               	str	x0, [x21]
               	mov	x20, #0x0               // =0
               	add	x23, x3, #0x8
               	ldr	x24, [x3]
               	add	x20, x20, #0x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x17, #0x5               // =5
               	mul	x2, x24, x17
               	add	x2, x1, x2
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x24, #0x7
               	b.gt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x23]
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x24, #0x0
               	b.ne	<addr>
               	add	x3, x23, #0x8
               	ldr	x0, [x23]
               	lsl	x0, x0, #3
               	add	x0, x22, x0
               	stur	x0, [x29, #-0x48]
               	b	<addr>
               	cmp	x24, #0x1
               	b.ne	<addr>
               	add	x3, x23, #0x8
               	ldr	x0, [x23]
               	stur	x0, [x29, #-0x48]
               	b	<addr>
               	cmp	x24, #0x2
               	b.ne	<addr>
               	ldr	x3, [x23]
               	b	<addr>
               	cmp	x24, #0x3
               	b.ne	<addr>
               	sub	x21, x21, #0x8
               	add	x0, x23, #0x8
               	str	x0, [x21]
               	ldr	x3, [x23]
               	b	<addr>
               	cmp	x24, #0x4
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x48]
               	cbz	x0, <addr>
               	add	x3, x23, #0x8
               	b	<addr>
               	ldr	x3, [x23]
               	b	<addr>
               	cmp	x24, #0x5
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x48]
               	cbz	x0, <addr>
               	ldr	x3, [x23]
               	b	<addr>
               	add	x3, x23, #0x8
               	b	<addr>
               	cmp	x24, #0x6
               	b.ne	<addr>
               	sub	x0, x21, #0x8
               	str	x22, [x0]
               	add	x3, x23, #0x8
               	ldr	x1, [x23]
               	lsl	x1, x1, #3
               	sub	x21, x0, x1
               	mov	x22, x0
               	b	<addr>
               	cmp	x24, #0x7
               	b.ne	<addr>
               	add	x3, x23, #0x8
               	ldr	x0, [x23]
               	lsl	x0, x0, #3
               	add	x21, x21, x0
               	b	<addr>
               	cmp	x24, #0x8
               	b.ne	<addr>
               	add	x0, x22, #0x8
               	ldr	x22, [x22]
               	add	x21, x0, #0x8
               	ldr	x3, [x0]
               	b	<addr>
               	cmp	x24, #0x9
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x48]
               	ldr	x0, [x0]
               	stur	x0, [x29, #-0x48]
               	mov	x3, x23
               	b	<addr>
               	cmp	x24, #0xa
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x48]
               	ldrb	w0, [x0]
               	stur	x0, [x29, #-0x48]
               	b	<addr>
               	cmp	x24, #0xb
               	b.ne	<addr>
               	add	x0, x21, #0x8
               	ldr	x1, [x21]
               	ldur	x2, [x29, #-0x48]
               	str	x2, [x1]
               	mov	x21, x0
               	b	<addr>
               	cmp	x24, #0xc
               	b.ne	<addr>
               	add	x0, x21, #0x8
               	ldr	x1, [x21]
               	ldur	x2, [x29, #-0x48]
               	strb	w2, [x1]
               	mov	x17, #0xff              // =255
               	and	x1, x2, x17
               	stur	x1, [x29, #-0x48]
               	mov	x21, x0
               	b	<addr>
               	cmp	x24, #0xd
               	b.ne	<addr>
               	sub	x21, x21, #0x8
               	ldur	x0, [x29, #-0x48]
               	str	x0, [x21]
               	b	<addr>
               	cmp	x24, #0xe
               	b.ne	<addr>
               	add	x0, x21, #0x8
               	ldr	x1, [x21]
               	ldur	x2, [x29, #-0x48]
               	orr	x1, x1, x2
               	stur	x1, [x29, #-0x48]
               	mov	x21, x0
               	b	<addr>
               	cmp	x24, #0xf
               	b.ne	<addr>
               	add	x0, x21, #0x8
               	ldr	x1, [x21]
               	ldur	x2, [x29, #-0x48]
               	eor	x1, x1, x2
               	stur	x1, [x29, #-0x48]
               	mov	x21, x0
               	b	<addr>
               	cmp	x24, #0x10
               	b.ne	<addr>
               	add	x0, x21, #0x8
               	ldr	x1, [x21]
               	ldur	x2, [x29, #-0x48]
               	and	x1, x1, x2
               	stur	x1, [x29, #-0x48]
               	mov	x21, x0
               	b	<addr>
               	cmp	x24, #0x11
               	b.ne	<addr>
               	add	x0, x21, #0x8
               	ldr	x1, [x21]
               	ldur	x2, [x29, #-0x48]
               	cmp	x1, x2
               	cset	x1, eq
               	stur	x1, [x29, #-0x48]
               	mov	x21, x0
               	b	<addr>
               	cmp	x24, #0x12
               	b.ne	<addr>
               	add	x0, x21, #0x8
               	ldr	x1, [x21]
               	ldur	x2, [x29, #-0x48]
               	cmp	x1, x2
               	cset	x1, ne
               	stur	x1, [x29, #-0x48]
               	mov	x21, x0
               	b	<addr>
               	cmp	x24, #0x13
               	b.ne	<addr>
               	add	x0, x21, #0x8
               	ldr	x1, [x21]
               	ldur	x2, [x29, #-0x48]
               	cmp	x1, x2
               	cset	x1, lt
               	stur	x1, [x29, #-0x48]
               	mov	x21, x0
               	b	<addr>
               	cmp	x24, #0x14
               	b.ne	<addr>
               	add	x0, x21, #0x8
               	ldr	x1, [x21]
               	ldur	x2, [x29, #-0x48]
               	cmp	x1, x2
               	cset	x1, gt
               	stur	x1, [x29, #-0x48]
               	mov	x21, x0
               	b	<addr>
               	cmp	x24, #0x15
               	b.ne	<addr>
               	add	x0, x21, #0x8
               	ldr	x1, [x21]
               	ldur	x2, [x29, #-0x48]
               	cmp	x1, x2
               	cset	x1, le
               	stur	x1, [x29, #-0x48]
               	mov	x21, x0
               	b	<addr>
               	cmp	x24, #0x16
               	b.ne	<addr>
               	add	x0, x21, #0x8
               	ldr	x1, [x21]
               	ldur	x2, [x29, #-0x48]
               	cmp	x1, x2
               	cset	x1, ge
               	stur	x1, [x29, #-0x48]
               	mov	x21, x0
               	b	<addr>
               	cmp	x24, #0x17
               	b.ne	<addr>
               	add	x0, x21, #0x8
               	ldr	x1, [x21]
               	ldur	x2, [x29, #-0x48]
               	lsl	x1, x1, x2
               	stur	x1, [x29, #-0x48]
               	mov	x21, x0
               	b	<addr>
               	cmp	x24, #0x18
               	b.ne	<addr>
               	add	x0, x21, #0x8
               	ldr	x1, [x21]
               	ldur	x2, [x29, #-0x48]
               	asr	x1, x1, x2
               	stur	x1, [x29, #-0x48]
               	mov	x21, x0
               	b	<addr>
               	cmp	x24, #0x19
               	b.ne	<addr>
               	add	x0, x21, #0x8
               	ldr	x1, [x21]
               	ldur	x2, [x29, #-0x48]
               	add	x1, x1, x2
               	stur	x1, [x29, #-0x48]
               	mov	x21, x0
               	b	<addr>
               	cmp	x24, #0x1a
               	b.ne	<addr>
               	add	x0, x21, #0x8
               	ldr	x1, [x21]
               	ldur	x2, [x29, #-0x48]
               	sub	x1, x1, x2
               	stur	x1, [x29, #-0x48]
               	mov	x21, x0
               	b	<addr>
               	cmp	x24, #0x1b
               	b.ne	<addr>
               	add	x0, x21, #0x8
               	ldr	x1, [x21]
               	ldur	x2, [x29, #-0x48]
               	mul	x1, x1, x2
               	stur	x1, [x29, #-0x48]
               	mov	x21, x0
               	b	<addr>
               	cmp	x24, #0x1c
               	b.ne	<addr>
               	add	x0, x21, #0x8
               	ldr	x1, [x21]
               	ldur	x2, [x29, #-0x48]
               	sdiv	x1, x1, x2
               	stur	x1, [x29, #-0x48]
               	mov	x21, x0
               	b	<addr>
               	cmp	x24, #0x1d
               	b.ne	<addr>
               	add	x0, x21, #0x8
               	ldr	x1, [x21]
               	ldur	x2, [x29, #-0x48]
               	sdiv	x17, x1, x2
               	msub	x1, x17, x2, x1
               	stur	x1, [x29, #-0x48]
               	mov	x21, x0
               	b	<addr>
               	cmp	x24, #0x1e
               	b.ne	<addr>
               	ldr	x0, [x21, #0x8]
               	ldr	x1, [x21]
               	sxtw	x1, w1
               	bl	<addr>
               	sxtw	x0, w0
               	stur	x0, [x29, #-0x48]
               	b	<addr>
               	cmp	x24, #0x1f
               	b.ne	<addr>
               	ldr	x0, [x21, #0x10]
               	sxtw	x0, w0
               	ldr	x1, [x21, #0x8]
               	ldr	x2, [x21]
               	sxtw	x2, w2
               	bl	<addr>
               	sxtw	x0, w0
               	stur	x0, [x29, #-0x48]
               	b	<addr>
               	cmp	x24, #0x20
               	b.ne	<addr>
               	ldr	x0, [x21]
               	sxtw	x0, w0
               	bl	<addr>
               	sxtw	x0, w0
               	stur	x0, [x29, #-0x48]
               	b	<addr>
               	cmp	x24, #0x21
               	b.ne	<addr>
               	ldr	x0, [x23, #0x8]
               	lsl	x0, x0, #3
               	add	x0, x21, x0
               	sub	x1, x0, #0x8
               	ldr	x1, [x1]
               	sub	x2, x0, #0x10
               	ldr	x2, [x2]
               	sub	x3, x0, #0x18
               	ldr	x3, [x3]
               	sub	x4, x0, #0x20
               	ldr	x4, [x4]
               	sub	x5, x0, #0x28
               	ldr	x5, [x5]
               	sub	x0, x0, #0x30
               	ldr	x0, [x0]
               	mov	x16, x1
               	mov	x1, x2
               	mov	x2, x3
               	mov	x3, x4
               	mov	x4, x5
               	mov	x5, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	stur	x0, [x29, #-0x48]
               	b	<addr>
               	cmp	x24, #0x22
               	b.ne	<addr>
               	ldr	x0, [x21]
               	sxtw	x0, w0
               	bl	<addr>
               	stur	x0, [x29, #-0x48]
               	b	<addr>
               	cmp	x24, #0x23
               	b.ne	<addr>
               	ldr	x0, [x21]
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	cmp	x24, #0x24
               	b.ne	<addr>
               	ldr	x0, [x21, #0x10]
               	ldr	x1, [x21, #0x8]
               	sxtw	x1, w1
               	ldr	x2, [x21]
               	sxtw	x2, w2
               	bl	<addr>
               	stur	x0, [x29, #-0x48]
               	b	<addr>
               	cmp	x24, #0x25
               	b.ne	<addr>
               	ldr	x0, [x21, #0x10]
               	ldr	x1, [x21, #0x8]
               	ldr	x2, [x21]
               	sxtw	x2, w2
               	bl	<addr>
               	sxtw	x0, w0
               	stur	x0, [x29, #-0x48]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	cmp	x24, #0x26
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x21]
               	mov	x2, x20
               	bl	<addr>
               	sxtw	x0, w0
               	ldr	x0, [x21]
               	ldp	x29, x30, [sp, #0x130]
               	ldr	x19, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x24
               	mov	x2, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldp	x29, x30, [sp, #0x130]
               	ldr	x19, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldp	x29, x30, [sp, #0x130]
               	ldr	x19, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldp	x29, x30, [sp, #0x130]
               	ldr	x19, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldp	x29, x30, [sp, #0x130]
               	ldr	x19, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldp	x29, x30, [sp, #0x130]
               	ldr	x19, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldp	x29, x30, [sp, #0x130]
               	ldr	x19, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldp	x29, x30, [sp, #0x130]
               	ldr	x19, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldp	x29, x30, [sp, #0x130]
               	ldr	x19, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldp	x29, x30, [sp, #0x130]
               	ldr	x19, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldp	x29, x30, [sp, #0x130]
               	ldr	x19, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x130]
               	ldr	x19, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
