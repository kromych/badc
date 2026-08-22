
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
               	mov	x2, #0x0                // =0
               	rev	w3, w1
               	str	w3, [x0]
               	mov	x0, x2
               	ret

<store_le32>:
               	mov	x2, #0x0                // =0
               	str	w1, [x0]
               	mov	x0, x2
               	ret

<store_be64>:
               	rev	x2, x1
               	str	x2, [x0]
               	mov	x0, #0x0                // =0
               	ret

<store_le16>:
               	mov	x2, #0x0                // =0
               	strh	w1, [x0]
               	mov	x0, x2
               	ret

<store_be24>:
               	mov	x2, #0x0                // =0
               	mov	w3, w1
               	lsr	x3, x3, #16
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	strb	w3, [x0]
               	mov	w3, w1
               	lsr	x3, x3, #8
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	strb	w3, [x0, #0x1]
               	mov	w1, w1
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	strb	w1, [x0, #0x2]
               	mov	x0, x2
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x10
               	add	x0, x0, #0x0
               	mov	x1, #0x0                // =0
               	strb	w1, [x0]
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	strb	w1, [x0, #0x1]
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	strb	w1, [x0, #0x2]
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	strb	w1, [x0, #0x3]
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	strb	w1, [x0, #0x4]
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	strb	w1, [x0, #0x5]
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	strb	w1, [x0, #0x6]
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	strb	w1, [x0, #0x7]
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	strb	w1, [x0, #0x8]
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	strb	w1, [x0, #0x9]
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	strb	w1, [x0, #0xa]
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	strb	w1, [x0, #0xb]
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	strb	w1, [x0, #0xc]
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	strb	w1, [x0, #0xd]
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	strb	w1, [x0, #0xe]
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	strb	w1, [x0, #0xf]
               	sub	x0, x29, #0x10
               	mov	x1, #0x2211             // =8721
               	movk	x1, #0x4433, lsl #16
               	str	w1, [x0]
               	sub	x2, x29, #0x10
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	w1, w0
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x1, x3, x1
               	ldrb	w1, [x1]
               	cmp	x4, x1
               	b.ne	<addr>
               	mov	w0, w0
               	add	x0, x0, #0x1
               	mov	w1, w0
               	cmp	x1, #0x4
               	b.lo	<addr>
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	add	x0, x0, #0x4
               	mov	x1, #0x3344             // =13124
               	movk	x1, #0x1122, lsl #16
               	str	w1, [x0]
               	sub	x0, x29, #0x10
               	add	x2, x0, #0x4
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	w1, w0
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x1, x3, x1
               	ldrb	w1, [x1]
               	cmp	x4, x1
               	b.ne	<addr>
               	mov	w0, w0
               	add	x0, x0, #0x1
               	mov	w1, w0
               	cmp	x1, #0x4
               	b.lo	<addr>
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	add	x0, x0, #0x9
               	mov	x1, #0xbbaa             // =48042
               	movk	x1, #0xddcc, lsl #16
               	str	w1, [x0]
               	sub	x0, x29, #0x10
               	add	x2, x0, #0x9
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	w1, w0
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x1, x3, x1
               	ldrb	w1, [x1]
               	cmp	x4, x1
               	b.ne	<addr>
               	mov	w0, w0
               	add	x0, x0, #0x1
               	mov	w1, w0
               	cmp	x1, #0x4
               	b.lo	<addr>
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	add	x0, x0, #0x1
               	mov	x1, #0x708              // =1800
               	movk	x1, #0x506, lsl #16
               	movk	x1, #0x304, lsl #32
               	movk	x1, #0x102, lsl #48
               	bl	<addr>
               	sub	x0, x29, #0x10
               	add	x2, x0, #0x1
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	w1, w0
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x1, x3, x1
               	ldrb	w1, [x1]
               	cmp	x4, x1
               	b.ne	<addr>
               	mov	w0, w0
               	add	x0, x0, #0x1
               	mov	w1, w0
               	cmp	x1, #0x8
               	b.lo	<addr>
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	add	x0, x0, #0xb
               	mov	x1, #0xfeed             // =65261
               	strh	w1, [x0]
               	sub	x0, x29, #0x10
               	add	x2, x0, #0xb
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	w1, w0
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x1, x3, x1
               	ldrb	w1, [x1]
               	cmp	x4, x1
               	b.ne	<addr>
               	mov	w0, w0
               	add	x0, x0, #0x1
               	mov	w1, w0
               	cmp	x1, #0x2
               	b.lo	<addr>
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	add	x0, x0, #0xd
               	mov	x1, #0x77               // =119
               	strb	w1, [x0]
               	mov	x1, #0x88               // =136
               	strb	w1, [x0, #0x1]
               	mov	x1, #0x99               // =153
               	strb	w1, [x0, #0x2]
               	sub	x0, x29, #0x10
               	add	x2, x0, #0xd
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	w1, w0
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x1, x3, x1
               	ldrb	w1, [x1]
               	cmp	x4, x1
               	b.ne	<addr>
               	mov	w0, w0
               	add	x0, x0, #0x1
               	mov	w1, w0
               	cmp	x1, #0x3
               	b.lo	<addr>
               	mov	x0, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldrb	w0, [x0]
               	mov	x17, #0x11              // =17
               	eor	x0, x0, x17
               	mov	w1, w0
               	cmp	x1, #0x0
               	cset	x0, ne
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x10
               	ldrb	w0, [x0, #0x9]
               	mov	x17, #0xaa              // =170
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
