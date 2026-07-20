
int128_shift.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sub	sp, sp, #0x30
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	mov	x1, x2
               	mov	x2, x3
               	mov	x3, x4
               	sub	x0, x29, #0x10
               	ldr	x0, [x0]
               	cmp	x0, x1
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x10
               	ldr	x1, [x0, #0x8]
               	mov	x4, #0x0                // =0
               	sub	x0, x29, #0x28
               	str	x1, [x0]
               	str	x4, [x0, #0x8]
               	cmp	x1, x2
               	cset	x0, ne
               	cbz	x0, <addr>
               	sxtw	x0, w3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x40
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x40
               	ret
               	b	<addr>

<main>:
               	stp	x20, x21, [sp, #-0x1f0]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x1e0]
               	add	x29, sp, #0x1e0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	sub	x0, x29, #0x78
               	str	x1, [x0]
               	mov	x21, #0x0               // =0
               	str	x21, [x0, #0x8]
               	sub	x0, x29, #0x88
               	str	x21, [x0]
               	str	x1, [x0, #0x8]
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	ldr	x0, [x22]
               	orr	x2, x21, x0
               	orr	x1, x1, x21
               	sub	x0, x29, #0x98
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	sub	x0, x29, #0xa8
               	str	x1, [x0]
               	str	x21, [x0, #0x8]
               	sub	x0, x29, #0xb8
               	str	x21, [x0]
               	str	x1, [x0, #0x8]
               	mov	x17, #0x1               // =1
               	orr	x2, x21, x17
               	orr	x1, x1, x21
               	sub	x0, x29, #0xc8
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sxtw	x1, w21
               	lsl	x1, x1, #2
               	add	x0, x0, x1
               	ldrsw	x20, [x0]
               	sub	x0, x29, #0x10
               	ldr	x2, [x0]
               	ldr	x6, [x0, #0x8]
               	mov	x17, #0x7f              // =127
               	and	x1, x20, x17
               	mov	x17, #0x3f              // =63
               	and	x0, x20, x17
               	mov	x3, #0x3f               // =63
               	sub	x7, x3, x0
               	lsr	x1, x1, #6
               	mov	x3, #0x0                // =0
               	sub	x1, x3, x1
               	mvn	x4, x1
               	lsl	x5, x2, x0
               	lsr	x2, x2, x7
               	lsr	x2, x2, #1
               	lsl	x0, x6, x0
               	orr	x0, x0, x2
               	and	x2, x5, x4
               	and	x3, x3, x1
               	orr	x2, x2, x3
               	and	x0, x0, x4
               	and	x1, x5, x1
               	orr	x1, x0, x1
               	sub	x0, x29, #0xd8
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	sxtw	x1, w21
               	lsl	x2, x1, #3
               	add	x3, x3, x2
               	ldr	x4, [x3]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	add	x2, x3, x2
               	ldr	x2, [x2]
               	add	x3, x1, #0x14
               	mov	x16, x4
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x16
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x10
               	ldr	x6, [x0]
               	ldr	x2, [x0, #0x8]
               	mov	x17, #0x7f              // =127
               	and	x1, x20, x17
               	mov	x17, #0x3f              // =63
               	and	x0, x20, x17
               	mov	x3, #0x3f               // =63
               	sub	x7, x3, x0
               	lsr	x1, x1, #6
               	mov	x3, #0x0                // =0
               	sub	x1, x3, x1
               	mvn	x4, x1
               	lsr	x5, x2, x0
               	lsl	x2, x2, x7
               	lsl	x2, x2, #1
               	lsr	x0, x6, x0
               	orr	x0, x0, x2
               	and	x0, x0, x4
               	and	x2, x5, x1
               	orr	x2, x0, x2
               	and	x0, x5, x4
               	and	x1, x3, x1
               	orr	x1, x0, x1
               	sub	x0, x29, #0xe8
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	sxtw	x1, w21
               	lsl	x2, x1, #3
               	add	x3, x3, x2
               	ldr	x4, [x3]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	add	x2, x3, x2
               	ldr	x2, [x2]
               	add	x3, x1, #0x1e
               	mov	x16, x4
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x16
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x20
               	ldr	x5, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0x7f              // =127
               	and	x2, x20, x17
               	mov	x17, #0x3f              // =63
               	and	x1, x20, x17
               	mov	x3, #0x3f               // =63
               	sub	x6, x3, x1
               	lsr	x2, x2, #6
               	mov	x3, #0x0                // =0
               	sub	x2, x3, x2
               	mvn	x3, x2
               	asr	x4, x0, x1
               	lsl	x6, x0, x6
               	lsl	x6, x6, #1
               	lsr	x1, x5, x1
               	orr	x1, x1, x6
               	asr	x0, x0, #63
               	and	x1, x1, x3
               	and	x5, x4, x2
               	orr	x1, x1, x5
               	and	x3, x4, x3
               	and	x0, x0, x2
               	orr	x2, x3, x0
               	sub	x0, x29, #0xf8
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	sxtw	x1, w21
               	lsl	x2, x1, #3
               	add	x3, x3, x2
               	ldr	x4, [x3]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	add	x2, x3, x2
               	ldr	x2, [x2]
               	add	x3, x1, #0x28
               	mov	x16, x4
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x16
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbnz	x0, <addr>
               	sxtw	x0, w21
               	add	x21, x0, #0x1
               	sxtw	x0, w21
               	cmp	x0, #0x6
               	b.lt	<addr>
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	sub	x0, x29, #0x108
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	mov	x3, #0x1                // =1
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	lsl	x2, x1, #1
               	lsl	x0, x0, #1
               	lsr	x1, x1, #63
               	orr	x1, x0, x1
               	sub	x0, x29, #0x118
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1, #0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, #0x8]
               	mov	x3, #0x2                // =2
               	mov	x4, x3
               	mov	x3, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	lsl	x2, x1, #63
               	lsl	x0, x0, #63
               	lsr	x1, x1, #1
               	orr	x1, x0, x1
               	sub	x0, x29, #0x128
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1, #0x10]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, #0x10]
               	mov	x3, #0x3                // =3
               	mov	x4, x3
               	mov	x3, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	mov	x2, #0x0                // =0
               	sub	x0, x29, #0x138
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1, #0x18]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, #0x18]
               	mov	x3, #0x4                // =4
               	mov	x4, x3
               	mov	x3, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	mov	x2, #0x0                // =0
               	lsl	x1, x1, #1
               	sub	x0, x29, #0x148
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1, #0x20]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, #0x20]
               	mov	x3, #0x5                // =5
               	mov	x4, x3
               	mov	x3, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	mov	x2, #0x0                // =0
               	lsl	x1, x1, #63
               	sub	x0, x29, #0x158
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1, #0x28]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, #0x28]
               	mov	x3, #0x6                // =6
               	mov	x4, x3
               	mov	x3, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	lsr	x2, x0, #1
               	lsr	x1, x1, #1
               	lsl	x0, x0, #63
               	orr	x1, x1, x0
               	sub	x0, x29, #0x168
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1, #0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, #0x8]
               	mov	x3, #0x7                // =7
               	mov	x4, x3
               	mov	x3, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	sub	x0, x29, #0x10
               	ldr	x1, [x0, #0x8]
               	mov	x2, #0x0                // =0
               	sub	x0, x29, #0x178
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1, #0x18]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, #0x18]
               	mov	x3, #0x8                // =8
               	mov	x4, x3
               	mov	x3, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	sub	x0, x29, #0x10
               	ldr	x0, [x0, #0x8]
               	lsr	x1, x0, #63
               	mov	x2, #0x0                // =0
               	sub	x0, x29, #0x188
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1, #0x28]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, #0x28]
               	mov	x3, #0x9                // =9
               	mov	x4, x3
               	mov	x3, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	sub	x0, x29, #0x20
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	asr	x2, x0, #1
               	lsr	x1, x1, #1
               	lsl	x0, x0, #63
               	orr	x1, x1, x0
               	sub	x0, x29, #0x198
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1, #0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, #0x8]
               	mov	x3, #0xa                // =10
               	mov	x4, x3
               	mov	x3, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	sub	x0, x29, #0x20
               	ldr	x1, [x0, #0x8]
               	asr	x2, x1, #63
               	sub	x0, x29, #0x1a8
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1, #0x18]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, #0x18]
               	mov	x3, #0xb                // =11
               	mov	x4, x3
               	mov	x3, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	sub	x0, x29, #0x20
               	ldr	x0, [x0, #0x8]
               	asr	x1, x0, #63
               	sub	x0, x29, #0x1b8
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1, #0x28]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, #0x28]
               	mov	x3, #0xc                // =12
               	mov	x4, x3
               	mov	x3, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	sub	x0, x29, #0x10
               	sub	x1, x29, #0x48
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x48
               	ldr	x1, [x0]
               	mov	x2, #0x0                // =0
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x48
               	ldr	x7, [x0]
               	ldr	x4, [x0, #0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0xc
               	ldrsw	x1, [x1]
               	mov	x17, #0x7f              // =127
               	and	x3, x1, x17
               	mov	x17, #0x3f              // =63
               	and	x1, x1, x17
               	mov	x5, #0x3f               // =63
               	sub	x8, x5, x1
               	lsr	x3, x3, #6
               	sub	x3, x2, x3
               	mvn	x5, x3
               	lsr	x6, x4, x1
               	lsl	x4, x4, x8
               	lsl	x4, x4, #1
               	lsr	x1, x7, x1
               	orr	x1, x1, x4
               	and	x1, x1, x5
               	and	x4, x6, x3
               	orr	x1, x1, x4
               	and	x4, x6, x5
               	and	x3, x2, x3
               	orr	x3, x4, x3
               	str	x1, [x0]
               	str	x3, [x0, #0x8]
               	sub	x0, x29, #0x48
               	ldr	x1, [x22]
               	mov	x3, #0xd                // =13
               	mov	x4, x3
               	mov	x3, x2
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x1e0]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1f0
               	ret
               	b	<addr>
