
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
               	cmp	x2, x3
               	cset	x3, eq
               	mov	x2, #0x0                // =0
               	cbz	x3, <addr>
               	ldrsw	x2, [x0, #0x4]
               	ldrsw	x3, [x1, #0x4]
               	cmp	x2, x3
               	cset	x2, eq
               	cmp	x2, #0x0
               	cset	x2, ne
               	mov	x3, #0x0                // =0
               	cbz	x2, <addr>
               	ldrsw	x2, [x0, #0x8]
               	ldrsw	x3, [x1, #0x8]
               	cmp	x2, x3
               	cset	x2, eq
               	cmp	x2, #0x0
               	cset	x3, ne
               	mov	x2, #0x0                // =0
               	cbz	x3, <addr>
               	ldrsw	x2, [x0, #0xc]
               	ldrsw	x3, [x1, #0xc]
               	cmp	x2, x3
               	cset	x2, eq
               	cmp	x2, #0x0
               	cset	x2, ne
               	mov	x3, #0x0                // =0
               	cbz	x2, <addr>
               	ldrsw	x2, [x0, #0x10]
               	ldrsw	x3, [x1, #0x10]
               	cmp	x2, x3
               	cset	x2, eq
               	cmp	x2, #0x0
               	cset	x3, ne
               	mov	x2, #0x0                // =0
               	cbz	x3, <addr>
               	ldrsw	x0, [x0, #0x14]
               	ldrsw	x1, [x1, #0x14]
               	cmp	x0, x1
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x2, ne
               	sxtw	x0, w2
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldrb	w1, [x0]
               	ldrb	w2, [x20]
               	cmp	x1, x2
               	cset	x2, eq
               	mov	x1, #0x0                // =0
               	cbz	x2, <addr>
               	ldrb	w1, [x0, #0x4]
               	ldrb	w2, [x20, #0x4]
               	cmp	x1, x2
               	cset	x1, eq
               	cmp	x1, #0x0
               	cset	x1, ne
               	mov	x2, #0x0                // =0
               	cbz	x1, <addr>
               	ldrb	w1, [x0, #0x8]
               	ldrb	w2, [x20, #0x8]
               	cmp	x1, x2
               	cset	x1, eq
               	cmp	x1, #0x0
               	cset	x2, ne
               	mov	x3, #0x0                // =0
               	cbz	x2, <addr>
               	ldrsw	x1, [x0, #0xc]
               	ldrsw	x2, [x20, #0xc]
               	cmp	x1, x2
               	cset	x1, eq
               	cmp	x1, #0x0
               	cset	x3, ne
               	mov	x1, #0x0                // =0
               	cbz	x3, <addr>
               	ldrb	w0, [x0, #0x10]
               	ldrb	w1, [x20, #0x10]
               	cmp	x0, x1
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	sxtw	x0, w1
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w1, [x0]
               	ldrb	w2, [x20]
               	cmp	x1, x2
               	cset	x2, eq
               	mov	x1, #0x0                // =0
               	cbz	x2, <addr>
               	ldrb	w1, [x0, #0x4]
               	ldrb	w2, [x20, #0x4]
               	cmp	x1, x2
               	cset	x1, eq
               	cmp	x1, #0x0
               	cset	x1, ne
               	mov	x2, #0x0                // =0
               	cbz	x1, <addr>
               	ldrb	w1, [x0, #0x8]
               	ldrb	w2, [x20, #0x8]
               	cmp	x1, x2
               	cset	x1, eq
               	cmp	x1, #0x0
               	cset	x2, ne
               	mov	x3, #0x0                // =0
               	cbz	x2, <addr>
               	ldrsw	x1, [x0, #0xc]
               	ldrsw	x2, [x20, #0xc]
               	cmp	x1, x2
               	cset	x1, eq
               	cmp	x1, #0x0
               	cset	x3, ne
               	mov	x1, #0x0                // =0
               	cbz	x3, <addr>
               	ldrb	w0, [x0, #0x10]
               	ldrb	w1, [x20, #0x10]
               	cmp	x0, x1
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	sxtw	x0, w1
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x1
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x2
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0xc]
               	cmp	x0, #0x3
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0, #0x8]
               	mov	x17, #0x7               // =7
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0, #0x9]
               	mov	x17, #0x8               // =8
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0, #0xa]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	ldrb	w0, [x20]
               	cmp	x0, #0x1
               	cset	x1, eq
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	ldrb	w0, [x20, #0x4]
               	cmp	x0, #0x2
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	ldrb	w0, [x20, #0x8]
               	cmp	x0, #0x3
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x2, #0x0                // =0
               	cbz	x1, <addr>
               	ldrsw	x0, [x20, #0xc]
               	cmp	x0, #0x4
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x2, ne
               	mov	x0, #0x0                // =0
               	cbz	x2, <addr>
               	ldrb	w0, [x20, #0x10]
               	cmp	x0, #0x5
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	ldrb	w1, [x20]
               	cmp	x1, #0x1
               	cset	x2, eq
               	mov	x1, #0x0                // =0
               	cbz	x2, <addr>
               	ldrb	w1, [x20, #0x4]
               	cmp	x1, #0x2
               	cset	x1, eq
               	cmp	x1, #0x0
               	cset	x1, ne
               	mov	x2, #0x0                // =0
               	cbz	x1, <addr>
               	ldrb	w1, [x20, #0x8]
               	cmp	x1, #0x3
               	cset	x1, eq
               	cmp	x1, #0x0
               	cset	x2, ne
               	mov	x3, #0x0                // =0
               	cbz	x2, <addr>
               	ldrsw	x1, [x20, #0xc]
               	cmp	x1, #0x4
               	cset	x1, eq
               	cmp	x1, #0x0
               	cset	x3, ne
               	mov	x1, #0x0                // =0
               	cbz	x3, <addr>
               	ldrb	w0, [x20, #0x10]
               	cmp	x0, #0x5
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	sxtw	x0, w1
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w1, [x0]
               	ldrb	w2, [x20]
               	cmp	x1, x2
               	cset	x2, eq
               	mov	x1, #0x0                // =0
               	cbz	x2, <addr>
               	ldrb	w1, [x0, #0x4]
               	ldrb	w2, [x20, #0x4]
               	cmp	x1, x2
               	cset	x1, eq
               	cmp	x1, #0x0
               	cset	x1, ne
               	mov	x2, #0x0                // =0
               	cbz	x1, <addr>
               	ldrb	w1, [x0, #0x8]
               	ldrb	w2, [x20, #0x8]
               	cmp	x1, x2
               	cset	x1, eq
               	cmp	x1, #0x0
               	cset	x2, ne
               	mov	x3, #0x0                // =0
               	cbz	x2, <addr>
               	ldrsw	x1, [x0, #0xc]
               	ldrsw	x2, [x20, #0xc]
               	cmp	x1, x2
               	cset	x1, eq
               	cmp	x1, #0x0
               	cset	x3, ne
               	mov	x1, #0x0                // =0
               	cbz	x3, <addr>
               	ldrb	w0, [x0, #0x10]
               	ldrb	w1, [x20, #0x10]
               	cmp	x0, x1
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	sxtw	x0, w1
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
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
