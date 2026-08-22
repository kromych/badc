
anon_member_inner_brace.aarch64:	file format elf64-littleaarch64

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

<dsame>:
               	ldrsw	x2, [x0]
               	ldrsw	x3, [x1]
               	cmp	w2, w3
               	mov	x2, #0x0                // =0
               	b.ne	<addr>
               	ldrsw	x3, [x0, #0x4]
               	ldrsw	x4, [x1, #0x4]
               	cmp	w3, w4
               	cset	x3, eq
               	cbz	x3, <addr>
               	ldrsw	x3, [x0, #0x8]
               	ldrsw	x4, [x1, #0x8]
               	cmp	w3, w4
               	cset	x3, eq
               	cbz	x3, <addr>
               	ldrsw	x3, [x0, #0xc]
               	ldrsw	x4, [x1, #0xc]
               	cmp	w3, w4
               	cset	x3, eq
               	cbz	x3, <addr>
               	ldrsw	x3, [x0, #0x10]
               	ldrsw	x4, [x1, #0x10]
               	cmp	w3, w4
               	cset	x3, eq
               	cbz	x3, <addr>
               	ldrsw	x0, [x0, #0x14]
               	ldrsw	x1, [x1, #0x14]
               	cmp	w0, w1
               	cset	x2, eq
               	sxtw	x0, w2
               	ret
               	b	<addr>
               	mov	x3, x2
               	b	<addr>
               	mov	x3, x2
               	b	<addr>
               	mov	x3, x2
               	b	<addr>
               	mov	x3, x2
               	b	<addr>

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldrb	w0, [x1]
               	ldrb	w2, [x20]
               	cmp	w0, w2
               	mov	x0, #0x0                // =0
               	b.ne	<addr>
               	ldrb	w2, [x1, #0x4]
               	ldrb	w3, [x20, #0x4]
               	cmp	w2, w3
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldrb	w2, [x1, #0x8]
               	ldrb	w3, [x20, #0x8]
               	cmp	w2, w3
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldrsw	x2, [x1, #0xc]
               	ldrsw	x3, [x20, #0xc]
               	cmp	w2, w3
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldrb	w1, [x1, #0x10]
               	ldrb	w2, [x20, #0x10]
               	cmp	w1, w2
               	cset	x1, eq
               	sxtw	x1, w1
               	cbnz	x1, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x1]
               	ldrb	w3, [x20]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x1, #0x4]
               	ldrb	w3, [x20, #0x4]
               	cmp	w2, w3
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldrb	w2, [x1, #0x8]
               	ldrb	w3, [x20, #0x8]
               	cmp	w2, w3
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldrsw	x2, [x1, #0xc]
               	ldrsw	x3, [x20, #0xc]
               	cmp	w2, w3
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldrb	w0, [x1, #0x10]
               	ldrb	w1, [x20, #0x10]
               	cmp	w0, w1
               	cset	x0, eq
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x1
               	mov	x0, #0x1                // =1
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1, #0x4]
               	cmp	w1, #0x2
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1, #0xc]
               	cmp	w1, #0x3
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w1, [x1, #0x8]
               	mov	x17, #0x7               // =7
               	eor	x1, x1, x17
               	mov	w1, w1
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0, #0x9]
               	mov	x17, #0x8               // =8
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0, #0xa]
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	ldrb	w0, [x20]
               	cmp	w0, #0x1
               	mov	x0, #0x0                // =0
               	b.ne	<addr>
               	ldrb	w1, [x20, #0x4]
               	cmp	w1, #0x2
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldrb	w1, [x20, #0x8]
               	cmp	w1, #0x3
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldrsw	x1, [x20, #0xc]
               	cmp	w1, #0x4
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldrb	w1, [x20, #0x10]
               	cmp	w1, #0x5
               	cset	x1, eq
               	sxtw	x1, w1
               	cbnz	x1, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	ldrb	w2, [x20]
               	cmp	w2, #0x1
               	b.ne	<addr>
               	ldrb	w2, [x20, #0x4]
               	cmp	w2, #0x2
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldrb	w2, [x20, #0x8]
               	cmp	w2, #0x3
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldrsw	x2, [x20, #0xc]
               	cmp	w2, #0x4
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldrb	w0, [x20, #0x10]
               	cmp	w0, #0x5
               	cset	x0, eq
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w1, [x0]
               	ldrb	w2, [x20]
               	cmp	w1, w2
               	mov	x1, #0x0                // =0
               	b.ne	<addr>
               	ldrb	w2, [x0, #0x4]
               	ldrb	w3, [x20, #0x4]
               	cmp	w2, w3
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldrb	w2, [x0, #0x8]
               	ldrb	w3, [x20, #0x8]
               	cmp	w2, w3
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldrsw	x2, [x0, #0xc]
               	ldrsw	x3, [x20, #0xc]
               	cmp	w2, w3
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldrb	w0, [x0, #0x10]
               	ldrb	w1, [x20, #0x10]
               	cmp	w0, w1
               	cset	x1, eq
               	sxtw	x0, w1
               	cbnz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
