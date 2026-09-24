
divide_operands.aarch64:	file format elf64-littleaarch64

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

<quot>:
               	sdiv	x0, x0, x1
               	ret

<rem>:
               	sdiv	x17, x0, x1
               	msub	x0, x17, x1, x0
               	ret

<uquot>:
               	udiv	x0, x0, x1
               	ret

<urem>:
               	udiv	x17, x0, x1
               	msub	x0, x17, x1, x0
               	ret

<quot32>:
               	sxtw	x0, w0
               	sxtw	x1, w1
               	sdiv	x0, x0, x1
               	ret

<rem32>:
               	sxtw	x0, w0
               	sxtw	x1, w1
               	sdiv	x17, x0, x1
               	msub	x0, x17, x1, x0
               	ret

<uquot32>:
               	mov	x0, #0xffffffff         // =4294967295
               	mov	w1, w1
               	udiv	x0, x0, x1
               	ret

<urem32>:
               	mov	x0, #0x5                // =5
               	ret

<reread>:
               	sdiv	x2, x0, x1
               	mov	x17, #0x3e8             // =1000
               	mul	x3, x2, x17
               	msub	x2, x2, x1, x0
               	mov	x17, #0xa               // =10
               	mul	x2, x2, x17
               	add	x2, x3, x2
               	add	x0, x2, x0
               	sub	x0, x0, x1
               	ret

<six>:
               	sdiv	x2, x0, x1
               	lsl	x0, x0, #1
               	add	x0, x2, x0
               	mov	x17, #0x3               // =3
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	add	x0, x0, #0x5
               	add	x0, x0, #0xe
               	add	x0, x0, #0x21
               	add	x0, x0, #0x34
               	ret

<digits>:
               	mov	x5, #0xa                // =10
               	mov	x2, #0x1                // =1
               	mov	x1, #0x0                // =0
               	mov	x6, #0x6667             // =26215
               	movk	x6, #0x6666, lsl #16
               	movk	x6, #0x6666, lsl #32
               	movk	x6, #0x6666, lsl #48
               	mov	x3, x1
               	cbz	x0, <addr>
               	lsr	x4, x0, #1
               	umulh	x4, x4, x6
               	lsr	x4, x4, #1
               	msub	x0, x4, x5, x0
               	madd	x3, x0, x2, x3
               	add	x1, x1, #0x1
               	add	x2, x2, #0x1
               	mov	x0, x4
               	cbnz	x0, <addr>
               	mov	x17, #0x64              // =100
               	mul	x0, x3, x17
               	add	x0, x0, x1
               	ret

<chain>:
               	sdiv	x1, x0, x1
               	add	x0, x0, x1
               	sdiv	x17, x0, x2
               	msub	x0, x17, x2, x0
               	mov	x17, #0x3e8             // =1000
               	mul	x1, x1, x17
               	add	x0, x1, x0
               	ret

<by_const>:
               	mov	x1, #0x4925             // =18725
               	movk	x1, #0x2492, lsl #16
               	movk	x1, #0x9249, lsl #32
               	movk	x1, #0x4924, lsl #48
               	smulh	x1, x0, x1
               	asr	x1, x1, #1
               	lsr	x2, x1, #63
               	add	x2, x1, x2
               	mov	x1, #0x6667             // =26215
               	movk	x1, #0x6666, lsl #16
               	movk	x1, #0x6666, lsl #32
               	movk	x1, #0x6666, lsl #48
               	smulh	x1, x0, x1
               	asr	x1, x1, #2
               	lsr	x3, x1, #63
               	add	x1, x1, x3
               	mov	x17, #0xa               // =10
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	add	x0, x2, x0
               	ret

<wide_quot>:
               	mov	x6, x0
               	mov	x4, x1
               	orr	x0, x4, x3
               	cbz	x0, <addr>
               	mov	x1, #0x0                // =0
               	mov	x5, #0x80               // =128
               	mov	x0, x6
               	mov	x6, x1
               	lsr	x7, x4, #63
               	lsl	x8, x6, #1
               	lsl	x1, x1, #1
               	lsr	x6, x6, #63
               	orr	x1, x1, x6
               	orr	x6, x8, x7
               	lsl	x9, x0, #1
               	lsl	x4, x4, #1
               	lsr	x0, x0, #63
               	orr	x4, x4, x0
               	cmp	x1, x3
               	cset	x0, lo
               	cmp	x1, x3
               	cset	x7, eq
               	cmp	x6, x2
               	cset	x8, lo
               	and	x7, x7, x8
               	orr	x0, x0, x7
               	eor	x0, x0, #0x1
               	neg	x7, x0
               	and	x8, x2, x7
               	and	x7, x3, x7
               	cmp	x6, x8
               	cset	x10, lo
               	sub	x6, x6, x8
               	sub	x1, x1, x7
               	sub	x1, x1, x10
               	orr	x0, x9, x0
               	sub	x5, x5, #0x1
               	cbnz	x5, <addr>
               	mov	x1, x4
               	ret
               	udiv	x0, x6, x2
               	msub	x6, x0, x2, x6
               	mov	x1, #0x0                // =0
               	mov	x4, x1
               	b	<addr>

<main>:
               	stp	x20, x21, [sp, #-0x60]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x22, [x0]
               	ldr	x20, [x0, #0x8]
               	ldr	x21, [x0, #0x10]
               	ldr	x23, [x0, #0x18]
               	mov	x0, x22
               	mov	x1, x20
               	bl	<addr>
               	cmp	x0, #0x3
               	b.ne	<addr>
               	mov	x0, x22
               	mov	x1, x20
               	bl	<addr>
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, x21
               	mov	x1, x20
               	bl	<addr>
               	mov	x17, #-0x3              // =-3
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, x21
               	mov	x1, x20
               	bl	<addr>
               	mov	x17, #-0x2              // =-2
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	mov	x17, #-0x3              // =-3
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, x21
               	mov	x1, x23
               	bl	<addr>
               	cmp	x0, #0x3
               	b.ne	<addr>
               	mov	x0, x21
               	mov	x1, x23
               	bl	<addr>
               	mov	x17, #-0x2              // =-2
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x0, [x1, #0x20]
               	ldr	x1, [x1, #0x28]
               	bl	<addr>
               	cbnz	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x0, [x1, #0x28]
               	ldr	x1, [x1, #0x28]
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	mov	x17, #-0x3              // =-3
               	cmp	w0, w17
               	b.ne	<addr>
               	mov	x0, x21
               	mov	x1, x20
               	bl	<addr>
               	mov	x17, #-0x2              // =-2
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x0, [x1]
               	ldr	x1, [x1, #0x8]
               	bl	<addr>
               	mov	x17, #0x5555555555555555 // =6148914691236517205
               	cmp	x0, x17
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x0, [x1]
               	ldr	x1, [x1, #0x18]
               	bl	<addr>
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x0, [x1, #0x10]
               	ldr	x1, [x1, #0x18]
               	bl	<addr>
               	mov	x17, #0xcccc            // =52428
               	movk	x17, #0xcccc, lsl #16
               	movk	x17, #0xcccc, lsl #32
               	movk	x17, #0xccc, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x0, [x1, #0x10]
               	ldr	x1, [x1, #0x8]
               	bl	<addr>
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0xffffffff         // =4294967295
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, #0x8]
               	mov	w1, w1
               	bl	<addr>
               	mov	x17, #0x5555            // =21845
               	movk	x17, #0x5555, lsl #16
               	cmp	w0, w17
               	b.ne	<addr>
               	mov	x0, #0xffffffff         // =4294967295
               	mov	x1, #0xa                // =10
               	bl	<addr>
               	mov	x17, #0x5               // =5
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, x22
               	mov	x1, x20
               	bl	<addr>
               	cmp	x0, #0xbd8
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, x21
               	mov	x1, x20
               	bl	<addr>
               	mov	x17, #-0xbe2            // =-3042
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x0, [x1, #0x30]
               	ldr	x1, [x1, #0x38]
               	mov	x2, #0x1                // =1
               	mov	x3, #0x2                // =2
               	mov	x4, #0x3                // =3
               	mov	x5, #0x4                // =4
               	bl	<addr>
               	mov	x17, #0xae56            // =44630
               	movk	x17, #0x1e, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x1, #0xa                // =10
               	mov	x2, #0x1                // =1
               	bl	<addr>
               	mov	x17, #0x6e7c            // =28284
               	movk	x17, #0x1, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x2, #0x4                // =4
               	mov	x0, x22
               	mov	x1, x20
               	bl	<addr>
               	cmp	x0, #0xbb8
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x2, #0x7                // =7
               	mov	x0, x21
               	mov	x1, x20
               	bl	<addr>
               	mov	x17, #-0xbbe            // =-3006
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x30]
               	bl	<addr>
               	mov	x17, #0x2e0c            // =11788
               	movk	x17, #0x2, lsl #16
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, x21
               	bl	<addr>
               	mov	x17, #-0x9              // =-9
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x3, #0x0                // =0
               	ldr	x2, [x1]
               	ldr	x0, [x1]
               	orr	x4, x3, x0
               	sub	x0, x29, #0x30
               	str	x4, [x0]
               	str	x2, [x0, #0x8]
               	ldr	x1, [x1, #0x8]
               	sub	x2, x29, #0x20
               	str	x1, [x2]
               	str	x3, [x2, #0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x1, x1, #0x5555555555555555
               	eor	x0, x0, #0x5555555555555555
               	orr	x0, x1, x0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x30
               	mov	x2, x0
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x1, x1, #0x1
               	orr	x0, x1, x0
               	cbz	x0, <addr>
               	mov	x0, #0x11               // =17
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
