
values_saved_around_loops.aarch64:	file format elf64-littleaarch64

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

<direct>:
               	stp	x20, x21, [sp, #-0x40]!
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x23, x0
               	mov	x24, x2
               	mov	x0, x1
               	mov	x21, #0x0               // =0
               	ldr	x5, [x4]
               	ldr	x13, [x4, #0x8]
               	ldr	x12, [x4, #0x10]
               	ldr	x11, [x4, #0x18]
               	ldr	x10, [x4, #0x20]
               	ldr	x9, [x4, #0x28]
               	ldr	x8, [x4, #0x30]
               	ldr	x7, [x4, #0x38]
               	ldr	x6, [x4, #0x40]
               	ldr	x14, [x4, #0x48]
               	mov	x22, x21
               	cmp	x21, x24
               	b.ge	<addr>
               	mov	x4, #0x0                // =0
               	cmp	x4, x3
               	b.ge	<addr>
               	add	x5, x5, x4
               	eor	x13, x13, x5
               	add	x12, x12, x13
               	eor	x11, x11, x12
               	add	x10, x10, x11
               	eor	x9, x9, x10
               	add	x8, x8, x9
               	eor	x7, x7, x8
               	add	x6, x6, x7
               	eor	x14, x14, x6
               	add	x4, x4, #0x1
               	cmp	x4, x3
               	b.lt	<addr>
               	add	x15, x23, x21
               	mov	x4, #0x0                // =0
               	mov	x1, x0
               	cmp	x4, x3
               	b.ge	<addr>
               	add	x2, x15, #0x1
               	ldrb	w15, [x15]
               	add	x20, x1, #0x1
               	ldrb	w1, [x1]
               	cmp	w15, w1
               	b.ne	<addr>
               	add	x4, x4, #0x1
               	mov	x1, x20
               	mov	x15, x2
               	cmp	x4, x3
               	b.lt	<addr>
               	add	x21, x21, #0x1
               	madd	x22, x4, x21, x22
               	eor	x5, x5, x4
               	cmp	x21, x24
               	b.lt	<addr>
               	add	x0, x22, x5
               	add	x1, x13, x13, lsl #1
               	add	x0, x0, x1
               	add	x1, x12, x12, lsl #2
               	add	x0, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x11, x17
               	add	x0, x0, x1
               	add	x1, x10, x10, lsl #3
               	add	x0, x0, x1
               	mov	x17, #0xb               // =11
               	mul	x1, x9, x17
               	add	x0, x0, x1
               	mov	x17, #0xd               // =13
               	mul	x1, x8, x17
               	add	x0, x0, x1
               	mov	x17, #0xf               // =15
               	mul	x1, x7, x17
               	add	x0, x0, x1
               	add	x1, x6, x6, lsl #4
               	add	x0, x0, x1
               	mov	x17, #0x13              // =19
               	mul	x1, x14, x17
               	add	x0, x0, x1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret

<reference>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	mov	x10, x0
               	mov	x0, #0x0                // =0
               	sub	x6, x29, #0x50
               	lsl	x5, x0, #3
               	add	x6, x6, x5
               	add	x5, x4, x5
               	ldr	x5, [x5]
               	str	x5, [x6]
               	add	x0, x0, #0x1
               	cmp	w0, #0xa
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x11, x0
               	cmp	x0, x2
               	b.ge	<addr>
               	mov	x9, #0x0                // =0
               	cmp	x9, x3
               	b.ge	<addr>
               	sub	x5, x29, #0x50
               	ldur	x4, [x29, #-0x50]
               	add	x4, x4, x9
               	stur	x4, [x29, #-0x50]
               	mov	x4, #0x1                // =1
               	add	x6, x5, x4, lsl #3
               	tbz	w4, #0x0, <addr>
               	ldr	x7, [x6]
               	sub	x8, x4, #0x1
               	add	x8, x5, x8, lsl #3
               	ldr	x8, [x8]
               	eor	x7, x7, x8
               	b	<addr>
               	ldr	x7, [x6]
               	sub	x8, x4, #0x1
               	add	x8, x5, x8, lsl #3
               	ldr	x8, [x8]
               	add	x7, x7, x8
               	str	x7, [x6]
               	add	x4, x4, #0x1
               	cmp	w4, #0xa
               	b.lt	<addr>
               	add	x9, x9, #0x1
               	cmp	x9, x3
               	b.lt	<addr>
               	mov	x4, #0x0                // =0
               	cmp	x4, x3
               	b.ge	<addr>
               	add	x5, x0, x4
               	ldrb	w5, [x10, x5]
               	ldrb	w6, [x1, x4]
               	cmp	w5, w6
               	b.ne	<addr>
               	add	x4, x4, #0x1
               	cmp	x4, x3
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	madd	x11, x4, x0, x11
               	ldur	x5, [x29, #-0x50]
               	eor	x4, x5, x4
               	stur	x4, [x29, #-0x50]
               	cmp	x0, x2
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	sub	x0, x29, #0x50
               	add	x0, x0, x1, lsl #3
               	ldr	x0, [x0]
               	lsl	x2, x1, #1
               	add	x2, x2, #0x1
               	madd	x11, x0, x2, x11
               	add	x1, x1, #0x1
               	cmp	w1, #0xa
               	b.lt	<addr>
               	mov	x0, x11
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret

<two_exits>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x21, x0
               	mov	x22, x1
               	mov	x1, #0x0                // =0
               	ldr	x14, [x3]
               	ldr	x13, [x3, #0x8]
               	ldr	x12, [x3, #0x10]
               	ldr	x5, [x3, #0x18]
               	ldr	x11, [x3, #0x20]
               	ldr	x10, [x3, #0x28]
               	ldr	x9, [x3, #0x30]
               	ldr	x4, [x3, #0x38]
               	ldr	x8, [x3, #0x40]
               	ldr	x7, [x3, #0x48]
               	ldr	x6, [x3, #0x50]
               	mov	x20, x1
               	cmp	x1, x22
               	b.ge	<addr>
               	mov	x3, #0x0                // =0
               	cmp	x3, x2
               	b.ge	<addr>
               	eor	x15, x3, x6
               	add	x14, x14, x15
               	add	x13, x13, x14
               	eor	x12, x12, x13
               	add	x5, x5, x12
               	eor	x11, x11, x5
               	add	x10, x10, x11
               	eor	x9, x9, x10
               	add	x4, x4, x9
               	eor	x8, x8, x4
               	add	x7, x7, x8
               	eor	x6, x6, x7
               	add	x3, x3, #0x1
               	cmp	x3, x2
               	b.lt	<addr>
               	add	x15, x21, x1
               	mov	x3, #0x0                // =0
               	cmp	x3, x2
               	b.ge	<addr>
               	ldrb	w0, [x15, x3]
               	cbz	w0, <addr>
               	add	x3, x3, #0x1
               	cmp	x3, x2
               	b.lt	<addr>
               	add	x15, x20, x5
               	b	<addr>
               	eor	x15, x20, x4
               	add	x20, x15, x3
               	add	x1, x1, #0x1
               	cmp	x1, x22
               	b.lt	<addr>
               	add	x0, x20, x14
               	add	x0, x0, x13
               	add	x0, x0, x12
               	add	x0, x0, x11
               	add	x0, x0, x10
               	add	x0, x0, x9
               	add	x0, x0, x8
               	add	x0, x0, x7
               	add	x0, x0, x6
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret

<two_exits_reference>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	mov	x9, x0
               	mov	x0, #0x0                // =0
               	sub	x5, x29, #0x58
               	lsl	x4, x0, #3
               	add	x5, x5, x4
               	add	x4, x3, x4
               	ldr	x4, [x4]
               	str	x4, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0xb
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x10, x0
               	cmp	x0, x1
               	b.ge	<addr>
               	mov	x8, #0x0                // =0
               	cmp	x8, x2
               	b.ge	<addr>
               	sub	x4, x29, #0x58
               	ldur	x3, [x29, #-0x58]
               	ldur	x5, [x29, #-0x8]
               	eor	x5, x8, x5
               	add	x3, x3, x5
               	stur	x3, [x29, #-0x58]
               	mov	x3, #0x1                // =1
               	add	x5, x4, x3, lsl #3
               	tbz	w3, #0x0, <addr>
               	ldr	x6, [x5]
               	sub	x7, x3, #0x1
               	add	x7, x4, x7, lsl #3
               	ldr	x7, [x7]
               	add	x6, x6, x7
               	b	<addr>
               	ldr	x6, [x5]
               	sub	x7, x3, #0x1
               	add	x7, x4, x7, lsl #3
               	ldr	x7, [x7]
               	eor	x6, x6, x7
               	str	x6, [x5]
               	add	x3, x3, #0x1
               	cmp	w3, #0xb
               	b.lt	<addr>
               	add	x8, x8, #0x1
               	cmp	x8, x2
               	b.lt	<addr>
               	mov	x3, #0x0                // =0
               	cmp	x3, x2
               	b.ge	<addr>
               	add	x4, x0, x3
               	ldrb	w4, [x9, x4]
               	cbz	w4, <addr>
               	add	x3, x3, #0x1
               	cmp	x3, x2
               	b.lt	<addr>
               	ldur	x4, [x29, #-0x40]
               	add	x4, x10, x4
               	b	<addr>
               	ldur	x4, [x29, #-0x20]
               	eor	x4, x10, x4
               	add	x10, x4, x3
               	add	x0, x0, #0x1
               	cmp	x0, x1
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	cmp	w0, #0x3
               	b.eq	<addr>
               	cmp	w0, #0x7
               	b.eq	<addr>
               	sub	x1, x29, #0x58
               	add	x1, x1, x0, lsl #3
               	ldr	x1, [x1]
               	add	x10, x10, x1
               	add	x0, x0, #0x1
               	cmp	w0, #0xb
               	b.lt	<addr>
               	mov	x0, x10
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x100
               	str	x20, [sp]
               	mov	x1, #0x0                // =0
               	mov	x4, #0x7                // =7
               	mov	x5, #0x5556             // =21846
               	movk	x5, #0x5555, lsl #16
               	mov	x6, #0x6667             // =26215
               	movk	x6, #0x6666, lsl #16
               	mov	x0, x1
               	sub	x7, x29, #0x60
               	mul	x2, x0, x4
               	sxtw	x2, w2
               	mul	x3, x2, x6
               	asr	x3, x3, #33
               	add	x3, x3, x3, lsr #63
               	add	x3, x3, x3, lsl #2
               	sub	x2, x2, x3
               	cbnz	w2, <addr>
               	mov	x2, x1
               	b	<addr>
               	mul	x2, x0, x5
               	lsr	x2, x2, #32
               	add	x2, x2, x2, lsl #1
               	sub	x2, x0, x2
               	add	x2, x2, #0x1
               	strb	w2, [x7, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x60
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x1, #0x5556             // =21846
               	movk	x1, #0x5555, lsl #16
               	sub	x2, x29, #0xe8
               	mul	x3, x0, x1
               	lsr	x3, x3, #32
               	add	x3, x3, x3, lsl #1
               	sub	x3, x0, x3
               	add	x3, x3, #0x1
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x30
               	b.lt	<addr>
               	sub	x4, x29, #0xb8
               	mov	x0, #0x4567             // =17767
               	movk	x0, #0x123, lsl #16
               	stur	x0, [x29, #-0xb8]
               	mov	x0, #0x8ace             // =35534
               	movk	x0, #0x256, lsl #16
               	stur	x0, [x29, #-0xb0]
               	mov	x0, #0xd035             // =53301
               	movk	x0, #0x349, lsl #16
               	stur	x0, [x29, #-0xa8]
               	mov	x0, #0x159c             // =5532
               	movk	x0, #0x4bd, lsl #16
               	stur	x0, [x29, #-0xa0]
               	mov	x0, #0x5b03             // =23299
               	movk	x0, #0x5f0, lsl #16
               	stur	x0, [x29, #-0x98]
               	mov	x0, #0xa06a             // =41066
               	movk	x0, #0x683, lsl #16
               	stur	x0, [x29, #-0x90]
               	mov	x0, #0xe5d1             // =58833
               	movk	x0, #0x796, lsl #16
               	stur	x0, [x29, #-0x88]
               	mov	x0, #0x2b38             // =11064
               	movk	x0, #0x96a, lsl #16
               	stur	x0, [x29, #-0x80]
               	mov	x0, #0x709f             // =28831
               	movk	x0, #0xabd, lsl #16
               	stur	x0, [x29, #-0x78]
               	mov	x0, #0xb606             // =46598
               	movk	x0, #0xbf0, lsl #16
               	stur	x0, [x29, #-0x70]
               	mov	x0, #0xfb6d             // =64365
               	movk	x0, #0xc23, lsl #16
               	stur	x0, [x29, #-0x68]
               	sub	x0, x29, #0x60
               	sub	x1, x29, #0xe8
               	mov	x2, #0x28               // =40
               	mov	x3, x2
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x60
               	sub	x1, x29, #0xe8
               	mov	x2, #0x28               // =40
               	sub	x4, x29, #0xb8
               	mov	x3, x2
               	bl	<addr>
               	cmp	x20, x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x60
               	sub	x1, x29, #0xe8
               	mov	x2, #0x7                // =7
               	mov	x3, #0x0                // =0
               	sub	x4, x29, #0xb8
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x60
               	sub	x1, x29, #0xe8
               	mov	x2, #0x7                // =7
               	mov	x3, #0x0                // =0
               	sub	x4, x29, #0xb8
               	bl	<addr>
               	cmp	x20, x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x60
               	mov	x1, #0x28               // =40
               	sub	x3, x29, #0xb8
               	mov	x2, x1
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x60
               	mov	x1, #0x28               // =40
               	sub	x3, x29, #0xb8
               	mov	x2, x1
               	bl	<addr>
               	cmp	x20, x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x60
               	mov	x1, #0x9                // =9
               	mov	x2, #0x3                // =3
               	sub	x3, x29, #0xb8
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x60
               	mov	x1, #0x9                // =9
               	mov	x2, #0x3                // =3
               	sub	x3, x29, #0xb8
               	bl	<addr>
               	cmp	x20, x0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
