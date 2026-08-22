
flexible_array_member_after_tentative_def.aarch64:	file format elf64-littleaarch64

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

<main>:
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x0, [x2]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	cmp	x0, x3
               	mov	x0, #0x1                // =1
               	b.ne	<addr>
               	ldr	x1, [x2, #0x8]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	cmp	x1, x4
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldr	x1, [x2, #0x10]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	cmp	x1, x2
               	cset	x1, ne
               	cbz	x1, <addr>
               	ret
               	ldr	x1, [x3, #0x10]
               	cmp	x1, #0xb
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, #0x10]
               	cmp	x1, #0x16
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, #0x10]
               	cmp	x1, #0x21
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldr	x1, [x3]
               	cmp	x1, x3
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1]
               	cmp	x2, x1
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1]
               	cmp	x2, x1
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldr	x1, [x3, #0x8]
               	cmp	x1, x3
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0, #0x8]
               	cmp	x1, x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0, #0x8]
               	cmp	x1, x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	add	x0, x3, #0x18
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w4, [x1]
               	cmp	w2, w4
               	cset	x2, eq
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	b	<addr>
               	b	<addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	cset	x0, eq
               	sxtw	x1, w0
               	mov	x0, #0x1                // =1
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x18
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w4, [x1]
               	cmp	w2, w4
               	cset	x2, eq
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	b	<addr>
               	b	<addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	cset	x0, eq
               	sxtw	x0, w0
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x18
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w4, [x1]
               	cmp	w2, w4
               	cset	x2, eq
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	b	<addr>
               	b	<addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	cset	x0, eq
               	sxtw	x0, w0
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	ldr	x0, [x3, #0x28]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w4, [x1]
               	cmp	w2, w4
               	cset	x2, eq
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	b	<addr>
               	b	<addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	cset	x0, eq
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x28]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w4, [x1]
               	cmp	w2, w4
               	cset	x2, eq
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	b	<addr>
               	b	<addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	cset	x0, eq
               	sxtw	x1, w0
               	mov	x0, #0x1                // =1
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x30]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w4, [x1]
               	cmp	w2, w4
               	cset	x2, eq
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	b	<addr>
               	b	<addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	cset	x0, eq
               	sxtw	x0, w0
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x38]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w4, [x1]
               	cmp	w2, w4
               	cset	x2, eq
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	b	<addr>
               	b	<addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	cset	x0, eq
               	sxtw	x0, w0
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x28]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w4, [x1]
               	cmp	w2, w4
               	cset	x2, eq
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	b	<addr>
               	b	<addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	cset	x0, eq
               	sxtw	x1, w0
               	cmp	w1, #0x0
               	cset	x0, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x30]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w4, [x1]
               	cmp	w2, w4
               	cset	x2, eq
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	b	<addr>
               	b	<addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	cset	x0, eq
               	sxtw	x0, w0
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ret
               	mov	x0, #0x1                // =1
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x1, x2, #0x40
               	cmp	x3, x1
               	mov	x1, #0x0                // =0
               	b.hs	<addr>
               	add	x4, x3, #0x30
               	cmp	x2, x4
               	cset	x2, lo
               	sxtw	x2, w2
               	cbnz	x2, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x2, x0, #0x38
               	cmp	x3, x2
               	b.hs	<addr>
               	add	x2, x3, #0x30
               	cmp	x0, x2
               	cset	x0, lo
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x3, x2, #0x38
               	cmp	x0, x3
               	b.hs	<addr>
               	add	x0, x0, #0x40
               	cmp	x2, x0
               	cset	x1, lo
               	sxtw	x0, w1
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	b	<addr>
               	mov	x0, x1
               	b	<addr>
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
