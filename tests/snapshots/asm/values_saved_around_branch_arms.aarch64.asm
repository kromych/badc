
values_saved_around_branch_arms.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<mix>:
               	eor	x0, x0, x1, lsr #3
               	mov	x17, #0x7c15            // =31765
               	movk	x17, #0x7f4a, lsl #16
               	movk	x17, #0x79b9, lsl #32
               	movk	x17, #0x9e37, lsl #48
               	mul	x0, x0, x17
               	ret

<direct>:
               	stp	x20, x21, [sp, #-0xa0]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	str	x28, [sp, #0x40]
               	stp	x29, x30, [sp, #0x90]
               	add	x29, sp, #0x90
               	mov	x7, x0
               	mov	x27, #0x0               // =0
               	ldr	x22, [x2]
               	ldr	x26, [x2, #0x8]
               	ldr	x23, [x2, #0x10]
               	ldr	x25, [x2, #0x18]
               	ldr	x21, [x2, #0x20]
               	ldr	x20, [x2, #0x28]
               	ldr	x28, [x2, #0x30]
               	ldr	x0, [x2, #0x38]
               	ldr	x24, [x2, #0x40]
               	ldr	x4, [x2, #0x48]
               	ldr	x2, [x2, #0x50]
               	str	x7, [sp, #0x80]
               	str	x1, [sp, #0x78]
               	str	x3, [sp, #0x70]
               	mov	x5, x27
               	b	<addr>
               	add	x27, x27, #0x1
               	cmp	x27, x1
               	b.ge	<addr>
               	ldrb	w6, [x7, x27]
               	and	x6, x6, #0x7
               	cmp	w6, #0x3
               	b.lt	<addr>
               	cmp	w6, #0x5
               	b.lt	<addr>
               	cmp	w6, #0x6
               	b.lt	<addr>
               	cmp	w6, #0x6
               	b.eq	<addr>
               	eor	x6, x25, x28
               	add	x26, x26, x6
               	add	x6, x22, x24
               	add	x5, x5, x6
               	b	<addr>
               	add	x6, x2, x2, lsl #1
               	add	x6, x6, x27
               	add	x4, x4, x6
               	eor	x2, x2, x4, lsl #2
               	b	<addr>
               	tbz	w27, #0x0, <addr>
               	ldr	x8, [x3]
               	ldr	x9, [x3, #0x10]
               	ldr	x6, [x3, #0x20]
               	ldr	x10, [x3, #0x30]
               	mul	x10, x9, x10
               	madd	x6, x8, x6, x10
               	add	x8, x6, x8
               	str	x8, [x3, #0x8]
               	eor	x8, x6, x9
               	str	x8, [x3, #0x18]
               	add	x5, x5, x6
               	b	<addr>
               	ldr	x6, [x3, #0x8]
               	ldr	x10, [x3, #0x18]
               	ldr	x8, [x3, #0x28]
               	ldr	x9, [x3, #0x38]
               	mul	x6, x6, x9
               	msub	x6, x10, x8, x6
               	sub	x9, x6, x9
               	str	x9, [x3]
               	eor	x8, x6, x8
               	str	x8, [x3, #0x30]
               	sub	x5, x5, x6
               	b	<addr>
               	cmp	w6, #0x4
               	b.lt	<addr>
               	add	x6, x24, x27
               	str	x5, [sp, #0x68]
               	str	x2, [sp, #0x60]
               	str	x4, [sp, #0x58]
               	mov	x1, x6
               	bl	<addr>
               	ldr	x7, [sp, #0x80]
               	ldr	x1, [sp, #0x78]
               	ldr	x3, [sp, #0x70]
               	ldr	x5, [sp, #0x68]
               	ldr	x2, [sp, #0x60]
               	ldr	x4, [sp, #0x58]
               	add	x24, x24, x0
               	b	<addr>
               	ldr	x6, [x3, #0x8]
               	ldr	x8, [x3, #0x30]
               	add	x6, x6, x8
               	ldr	x8, [x3, #0x10]
               	ldr	x9, [x3, #0x28]
               	eor	x8, x8, x9
               	ldr	x9, [x3, #0x18]
               	ldr	x10, [x3, #0x20]
               	sub	x9, x9, x10
               	cmp	x6, #0x77
               	b.eq	<addr>
               	madd	x10, x6, x8, x9
               	str	x10, [x3]
               	madd	x10, x8, x9, x6
               	str	x10, [x3, #0x38]
               	add	x6, x6, x8
               	add	x6, x6, x9
               	eor	x5, x5, x6
               	b	<addr>
               	cmp	w6, #0x1
               	b.lt	<addr>
               	cmp	w6, #0x2
               	b.lt	<addr>
               	sub	x8, x21, x20
               	sub	x9, x20, x21
               	cmp	x21, x20
               	csel	x20, x20, x9, hi
               	csel	x21, x8, x21, hi
               	add	x6, x21, x20
               	eor	x28, x28, x6
               	b	<addr>
               	ldr	x6, [x3]
               	ldr	x10, [x3, #0x8]
               	ldr	x11, [x3, #0x10]
               	ldr	x12, [x3, #0x18]
               	ldr	x13, [x3, #0x20]
               	ldr	x8, [x3, #0x28]
               	ldr	x14, [x3, #0x30]
               	ldr	x15, [x3, #0x38]
               	mul	x9, x11, x12
               	madd	x9, x6, x10, x9
               	madd	x9, x13, x8, x9
               	madd	x9, x14, x15, x9
               	eor	x15, x6, x15
               	eor	x10, x10, x14
               	add	x10, x15, x10
               	eor	x11, x11, x8
               	add	x10, x10, x11
               	eor	x11, x12, x13
               	add	x10, x10, x11
               	and	x11, x27, #0x7
               	eor	x12, x9, x10
               	str	x12, [x3, x11, lsl #3]
               	add	x11, x27, #0x3
               	and	x11, x11, #0x7
               	madd	x6, x10, x6, x9
               	add	x6, x6, x8
               	str	x6, [x3, x11, lsl #3]
               	sub	x6, x9, x10
               	add	x5, x5, x6
               	b	<addr>
               	eor	x6, x26, x27
               	add	x22, x22, x6
               	eor	x23, x23, x22
               	add	x25, x25, x23, lsr #1
               	b	<addr>
               	add	x1, x5, x22
               	add	x3, x26, x26, lsl #1
               	add	x1, x1, x3
               	add	x3, x23, x23, lsl #2
               	add	x1, x1, x3
               	mov	x17, #0x7               // =7
               	mul	x3, x25, x17
               	add	x1, x1, x3
               	add	x3, x21, x21, lsl #3
               	add	x1, x1, x3
               	mov	x17, #0xb               // =11
               	mul	x3, x20, x17
               	add	x1, x1, x3
               	mov	x17, #0xd               // =13
               	mul	x3, x28, x17
               	add	x1, x1, x3
               	mov	x17, #0xf               // =15
               	mul	x0, x0, x17
               	add	x0, x1, x0
               	add	x1, x24, x24, lsl #4
               	add	x0, x0, x1
               	mov	x17, #0x13              // =19
               	mul	x1, x4, x17
               	add	x0, x0, x1
               	mov	x17, #0x15              // =21
               	mul	x1, x2, x17
               	add	x0, x0, x1
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	add	x5, x5, #0x1
               	b	<addr>

<reference>:
               	stp	x20, x21, [sp, #-0xa0]!
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	stp	x29, x30, [sp, #0x90]
               	add	x29, sp, #0x90
               	mov	x23, x0
               	mov	x22, x3
               	mov	x24, x1
               	mov	x3, #0x0                // =0
               	sub	x0, x29, #0x58
               	lsl	x4, x3, #3
               	add	x0, x0, x4
               	add	x1, x2, x4
               	ldr	x1, [x1]
               	str	x1, [x0]
               	add	x3, x3, #0x1
               	cmp	w3, #0xb
               	b.lt	<addr>
               	mov	x21, #0x0               // =0
               	mov	x20, x21
               	b	<addr>
               	add	x21, x21, #0x1
               	cmp	x21, x24
               	b.ge	<addr>
               	ldrb	w0, [x23, x21]
               	and	x2, x0, #0x7
               	cmp	w2, #0x3
               	b.lt	<addr>
               	cmp	w2, #0x5
               	b.lt	<addr>
               	cmp	w2, #0x6
               	b.lt	<addr>
               	cmp	w2, #0x6
               	b.eq	<addr>
               	ldur	x0, [x29, #-0x50]
               	ldur	x1, [x29, #-0x40]
               	ldur	x2, [x29, #-0x28]
               	eor	x1, x1, x2
               	add	x0, x0, x1
               	stur	x0, [x29, #-0x50]
               	ldur	x0, [x29, #-0x58]
               	ldur	x1, [x29, #-0x18]
               	add	x0, x0, x1
               	add	x20, x20, x0
               	b	<addr>
               	ldur	x0, [x29, #-0x10]
               	ldur	x1, [x29, #-0x8]
               	add	x1, x1, x1, lsl #1
               	add	x1, x1, x21
               	add	x0, x0, x1
               	stur	x0, [x29, #-0x10]
               	ldur	x0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x10]
               	eor	x0, x0, x1, lsl #2
               	stur	x0, [x29, #-0x8]
               	b	<addr>
               	tbz	w21, #0x0, <addr>
               	ldr	x1, [x22]
               	ldr	x2, [x22, #0x10]
               	ldr	x0, [x22, #0x20]
               	ldr	x3, [x22, #0x30]
               	mul	x3, x2, x3
               	madd	x0, x1, x0, x3
               	add	x1, x0, x1
               	str	x1, [x22, #0x8]
               	eor	x1, x0, x2
               	str	x1, [x22, #0x18]
               	add	x20, x20, x0
               	b	<addr>
               	ldr	x0, [x22, #0x8]
               	ldr	x3, [x22, #0x18]
               	ldr	x1, [x22, #0x28]
               	ldr	x2, [x22, #0x38]
               	mul	x0, x0, x2
               	msub	x0, x3, x1, x0
               	sub	x2, x0, x2
               	str	x2, [x22]
               	eor	x1, x0, x1
               	str	x1, [x22, #0x30]
               	sub	x20, x20, x0
               	b	<addr>
               	cmp	w2, #0x4
               	b.lt	<addr>
               	ldur	x0, [x29, #-0x20]
               	ldur	x1, [x29, #-0x18]
               	add	x1, x1, x21
               	bl	<addr>
               	stur	x0, [x29, #-0x20]
               	ldur	x0, [x29, #-0x18]
               	ldur	x1, [x29, #-0x20]
               	add	x0, x0, x1
               	stur	x0, [x29, #-0x18]
               	b	<addr>
               	ldr	x0, [x22, #0x8]
               	ldr	x1, [x22, #0x30]
               	add	x0, x0, x1
               	ldr	x1, [x22, #0x10]
               	ldr	x2, [x22, #0x28]
               	eor	x1, x1, x2
               	ldr	x2, [x22, #0x18]
               	ldr	x3, [x22, #0x20]
               	sub	x2, x2, x3
               	cmp	x0, #0x77
               	b.eq	<addr>
               	madd	x3, x0, x1, x2
               	str	x3, [x22]
               	madd	x3, x1, x2, x0
               	str	x3, [x22, #0x38]
               	add	x0, x0, x1
               	add	x0, x0, x2
               	eor	x20, x20, x0
               	b	<addr>
               	cmp	w2, #0x1
               	b.lt	<addr>
               	cmp	w2, #0x2
               	b.lt	<addr>
               	ldur	x0, [x29, #-0x38]
               	ldur	x1, [x29, #-0x30]
               	cmp	x0, x1
               	b.ls	<addr>
               	ldur	x0, [x29, #-0x38]
               	ldur	x1, [x29, #-0x30]
               	sub	x0, x0, x1
               	stur	x0, [x29, #-0x38]
               	ldur	x0, [x29, #-0x28]
               	ldur	x1, [x29, #-0x38]
               	ldur	x2, [x29, #-0x30]
               	add	x1, x1, x2
               	eor	x0, x0, x1
               	stur	x0, [x29, #-0x28]
               	b	<addr>
               	ldur	x0, [x29, #-0x30]
               	ldur	x1, [x29, #-0x38]
               	sub	x0, x0, x1
               	stur	x0, [x29, #-0x30]
               	b	<addr>
               	ldr	x0, [x22]
               	ldr	x1, [x22, #0x8]
               	ldr	x2, [x22, #0x10]
               	ldr	x3, [x22, #0x18]
               	mul	x2, x2, x3
               	madd	x0, x0, x1, x2
               	ldr	x1, [x22, #0x20]
               	ldr	x2, [x22, #0x28]
               	madd	x0, x1, x2, x0
               	ldr	x1, [x22, #0x30]
               	ldr	x2, [x22, #0x38]
               	madd	x0, x1, x2, x0
               	ldr	x1, [x22]
               	ldr	x2, [x22, #0x38]
               	eor	x1, x1, x2
               	ldr	x2, [x22, #0x8]
               	ldr	x3, [x22, #0x30]
               	eor	x2, x2, x3
               	add	x1, x1, x2
               	ldr	x2, [x22, #0x10]
               	ldr	x3, [x22, #0x28]
               	eor	x2, x2, x3
               	add	x1, x1, x2
               	ldr	x2, [x22, #0x18]
               	ldr	x3, [x22, #0x20]
               	eor	x2, x2, x3
               	add	x1, x1, x2
               	ldr	x2, [x22]
               	ldr	x3, [x22, #0x28]
               	and	x4, x21, #0x7
               	add	x4, x22, x4, lsl #3
               	eor	x5, x0, x1
               	str	x5, [x4]
               	add	x4, x21, #0x3
               	and	x4, x4, #0x7
               	add	x4, x22, x4, lsl #3
               	madd	x2, x1, x2, x0
               	add	x2, x2, x3
               	str	x2, [x4]
               	sub	x0, x0, x1
               	add	x20, x20, x0
               	b	<addr>
               	ldur	x0, [x29, #-0x58]
               	ldur	x1, [x29, #-0x50]
               	eor	x1, x1, x21
               	add	x0, x0, x1
               	stur	x0, [x29, #-0x58]
               	ldur	x0, [x29, #-0x48]
               	ldur	x1, [x29, #-0x58]
               	eor	x0, x0, x1
               	stur	x0, [x29, #-0x48]
               	ldur	x0, [x29, #-0x40]
               	ldur	x1, [x29, #-0x48]
               	add	x0, x0, x1, lsr #1
               	stur	x0, [x29, #-0x40]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x58
               	add	x1, x1, x0, lsl #3
               	ldr	x1, [x1]
               	lsl	x2, x0, #1
               	add	x2, x2, #0x1
               	madd	x20, x1, x2, x20
               	add	x0, x0, #0x1
               	cmp	w0, #0xb
               	b.lt	<addr>
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	add	x20, x20, #0x1
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x1c0
               	str	x20, [sp]
               	mov	x0, #0x0                // =0
               	mov	x1, #0xd                // =13
               	mov	x2, #0x4925             // =18725
               	movk	x2, #0x2492, lsl #16
               	sub	x3, x29, #0xc8
               	mul	x4, x0, x1
               	mul	x5, x0, x2
               	add	x4, x4, x5, lsr #32
               	and	x4, x4, #0x7
               	strb	w4, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0xc8
               	b.lt	<addr>
               	mov	x0, #0x4567             // =17767
               	movk	x0, #0x123, lsl #16
               	str	x0, [sp, #0xa0]
               	mov	x0, #0x8ace             // =35534
               	movk	x0, #0x256, lsl #16
               	str	x0, [sp, #0xa8]
               	mov	x0, #0xd035             // =53301
               	movk	x0, #0x349, lsl #16
               	str	x0, [sp, #0xb0]
               	mov	x0, #0x159c             // =5532
               	movk	x0, #0x4bd, lsl #16
               	str	x0, [sp, #0xb8]
               	mov	x0, #0x5b03             // =23299
               	movk	x0, #0x5f0, lsl #16
               	stur	x0, [x29, #-0x100]
               	mov	x0, #0xa06a             // =41066
               	movk	x0, #0x683, lsl #16
               	stur	x0, [x29, #-0xf8]
               	mov	x0, #0xe5d1             // =58833
               	movk	x0, #0x796, lsl #16
               	stur	x0, [x29, #-0xf0]
               	mov	x0, #0x2b38             // =11064
               	movk	x0, #0x96a, lsl #16
               	stur	x0, [x29, #-0xe8]
               	mov	x0, #0x709f             // =28831
               	movk	x0, #0xabd, lsl #16
               	stur	x0, [x29, #-0xe0]
               	mov	x0, #0xb606             // =46598
               	movk	x0, #0xbf0, lsl #16
               	stur	x0, [x29, #-0xd8]
               	mov	x0, #0xfb6d             // =64365
               	movk	x0, #0xc23, lsl #16
               	stur	x0, [x29, #-0xd0]
               	sub	x3, x29, #0x1a0
               	mov	x0, #0x3                // =3
               	movk	x0, #0x3, lsl #16
               	str	x0, [sp, #0x60]
               	str	x0, [sp, #0x20]
               	mov	x0, #0x4                // =4
               	movk	x0, #0x4, lsl #16
               	str	x0, [sp, #0x68]
               	str	x0, [sp, #0x28]
               	mov	x0, #0x5                // =5
               	movk	x0, #0x5, lsl #16
               	str	x0, [sp, #0x70]
               	str	x0, [sp, #0x30]
               	mov	x0, #0x6                // =6
               	movk	x0, #0x6, lsl #16
               	str	x0, [sp, #0x78]
               	str	x0, [sp, #0x38]
               	mov	x0, #0x7                // =7
               	movk	x0, #0x7, lsl #16
               	str	x0, [sp, #0x80]
               	str	x0, [sp, #0x40]
               	mov	x0, #0x8                // =8
               	movk	x0, #0x8, lsl #16
               	str	x0, [sp, #0x88]
               	str	x0, [sp, #0x48]
               	mov	x0, #0x9                // =9
               	movk	x0, #0x9, lsl #16
               	str	x0, [sp, #0x90]
               	str	x0, [sp, #0x50]
               	mov	x0, #0xa                // =10
               	movk	x0, #0xa, lsl #16
               	str	x0, [sp, #0x98]
               	str	x0, [sp, #0x58]
               	sub	x0, x29, #0xc8
               	mov	x1, #0xc8               // =200
               	sub	x2, x29, #0x120
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0xc8
               	mov	x1, #0xc8               // =200
               	sub	x2, x29, #0x120
               	sub	x3, x29, #0x160
               	bl	<addr>
               	cmp	x20, x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [sp, #0x20]
               	ldr	x1, [sp, #0x60]
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [sp, #0x28]
               	ldr	x1, [sp, #0x68]
               	cmp	x0, x1
               	b.ne	<addr>
               	ldr	x0, [sp, #0x30]
               	ldr	x1, [sp, #0x70]
               	cmp	x0, x1
               	b.ne	<addr>
               	ldr	x0, [sp, #0x38]
               	ldr	x1, [sp, #0x78]
               	cmp	x0, x1
               	b.ne	<addr>
               	ldr	x0, [sp, #0x40]
               	ldr	x1, [sp, #0x80]
               	cmp	x0, x1
               	b.ne	<addr>
               	ldr	x0, [sp, #0x48]
               	ldr	x1, [sp, #0x88]
               	cmp	x0, x1
               	b.ne	<addr>
               	ldr	x0, [sp, #0x50]
               	ldr	x1, [sp, #0x90]
               	cmp	x0, x1
               	b.ne	<addr>
               	ldr	x0, [sp, #0x58]
               	ldr	x1, [sp, #0x98]
               	cmp	x0, x1
               	b.ne	<addr>
               	str	xzr, [sp, #0x60]
               	str	xzr, [sp, #0x20]
               	str	xzr, [sp, #0x70]
               	str	xzr, [sp, #0x30]
               	sub	x3, x29, #0x1a0
               	str	xzr, [sp, #0x78]
               	str	xzr, [sp, #0x38]
               	str	xzr, [sp, #0x80]
               	str	xzr, [sp, #0x40]
               	str	xzr, [sp, #0x88]
               	str	xzr, [sp, #0x48]
               	str	xzr, [sp, #0x98]
               	str	xzr, [sp, #0x58]
               	mov	x0, #0x70               // =112
               	str	x0, [sp, #0x68]
               	str	x0, [sp, #0x28]
               	mov	x0, #0x7                // =7
               	str	x0, [sp, #0x90]
               	str	x0, [sp, #0x50]
               	sub	x0, x29, #0x1a8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	w16, [x1]
               	str	w16, [x0]
               	mov	x1, #0x4                // =4
               	sub	x2, x29, #0x120
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x1a8
               	mov	x1, #0x4                // =4
               	sub	x2, x29, #0x120
               	sub	x3, x29, #0x160
               	bl	<addr>
               	cmp	x20, x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xc8
               	mov	x1, #0x0                // =0
               	sub	x2, x29, #0x120
               	sub	x3, x29, #0x1a0
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0xc8
               	mov	x1, #0x0                // =0
               	sub	x2, x29, #0x120
               	sub	x3, x29, #0x160
               	bl	<addr>
               	cmp	x20, x0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
