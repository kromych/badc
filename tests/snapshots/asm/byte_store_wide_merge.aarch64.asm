
byte_store_wide_merge.aarch64:	file format elf64-littleaarch64

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

<store_be32>:
               	rev	w2, w1
               	str	w2, [x0]
               	ret

<store_le32>:
               	str	w1, [x0]
               	ret

<store_be64>:
               	rev	x2, x1
               	str	x2, [x0]
               	ret

<store_le16>:
               	strh	w1, [x0]
               	ret

<store_be24>:
               	mov	w2, w1
               	lsr	x3, x2, #16
               	and	x3, x3, #0xff
               	strb	w3, [x0]
               	lsr	x2, x2, #8
               	and	x2, x2, #0xff
               	strb	w2, [x0, #0x1]
               	and	x1, x1, #0xff
               	strb	w1, [x0, #0x2]
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	str	x0, [x1]
               	str	x0, [x1, #0x8]
               	mov	x2, #0x2211             // =8721
               	movk	x2, #0x4433, lsl #16
               	str	w2, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	cmp	w0, #0x4
               	b.hs	<addr>
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lo	<addr>
               	sub	x0, x29, #0x10
               	mov	x1, #0x3344             // =13124
               	movk	x1, #0x1122, lsl #16
               	str	w1, [x0, #0x4]
               	add	x1, x0, #0x4
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	cmp	w0, #0x4
               	b.hs	<addr>
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lo	<addr>
               	sub	x0, x29, #0x10
               	add	x1, x0, #0x9
               	mov	x2, #0xbbaa             // =48042
               	movk	x2, #0xddcc, lsl #16
               	str	w2, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	cmp	w0, #0x4
               	b.hs	<addr>
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lo	<addr>
               	sub	x0, x29, #0x10
               	add	x1, x0, #0x1
               	mov	x2, #0x201              // =513
               	movk	x2, #0x403, lsl #16
               	movk	x2, #0x605, lsl #32
               	movk	x2, #0x807, lsl #48
               	str	x2, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	cmp	w0, #0x8
               	b.hs	<addr>
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x0, x29, #0x10
               	add	x1, x0, #0xb
               	mov	x2, #0xfeed             // =65261
               	strh	w2, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	cmp	w0, #0x2
               	b.hs	<addr>
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lo	<addr>
               	sub	x0, x29, #0x10
               	add	x1, x0, #0xd
               	mov	x2, #0x77               // =119
               	strb	w2, [x1]
               	mov	x2, #0x88               // =136
               	strb	w2, [x1, #0x1]
               	mov	x2, #0x99               // =153
               	strb	w2, [x1, #0x2]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	cmp	w0, #0x3
               	b.hs	<addr>
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lo	<addr>
               	sub	x0, x29, #0x10
               	ldrb	w0, [x0]
               	mov	x17, #0x11              // =17
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	sub	x0, x29, #0x10
               	ldrb	w0, [x0, #0x9]
               	mov	x17, #0xaa              // =170
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
