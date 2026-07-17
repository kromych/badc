
bitfield_runtime_init.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x4, x0
               	sxtw	x4, w4
               	sxtw	x1, w1
               	sxtw	x2, w2
               	sxtw	x3, w3
               	sub	x0, x29, #0x8
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x5]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x8
               	mov	x17, #0xf               // =15
               	and	x5, x4, x17
               	ldr	w6, [x0]
               	mov	x17, #0xfff0            // =65520
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x6, x6, x17
               	orr	x5, x6, x5
               	str	w5, [x0]
               	sub	x0, x29, #0x8
               	mov	x17, #0xf               // =15
               	and	x5, x1, x17
               	ldr	w6, [x0]
               	mov	x17, #0xff0f            // =65295
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x6, x6, x17
               	lsl	x5, x5, #4
               	orr	x5, x6, x5
               	str	w5, [x0]
               	sub	x0, x29, #0x8
               	mov	x17, #0x1f              // =31
               	and	x5, x2, x17
               	ldr	w6, [x0]
               	mov	x17, #0xe0ff            // =57599
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x6, x6, x17
               	lsl	x5, x5, #8
               	orr	x5, x6, x5
               	str	w5, [x0]
               	sub	x0, x29, #0x8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xf, lsl #16
               	and	x5, x3, x17
               	ldr	w6, [x0, #0x4]
               	mov	x17, #0xfff00000        // =4293918720
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x6, x6, x17
               	orr	x5, x6, x5
               	str	w5, [x0, #0x4]
               	sub	x0, x29, #0x8
               	ldr	w0, [x0]
               	mov	x17, #0xf               // =15
               	and	x0, x0, x17
               	mov	x17, #0xf               // =15
               	and	x4, x4, x17
               	eor	x0, x0, x4
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x4, eq
               	mov	x0, #0x0                // =0
               	cbz	x4, <addr>
               	sub	x0, x29, #0x8
               	ldr	w0, [x0]
               	asr	x0, x0, #4
               	mov	x17, #0xf               // =15
               	and	x0, x0, x17
               	mov	x17, #0xf               // =15
               	and	x1, x1, x17
               	eor	x0, x0, x1
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	sub	x0, x29, #0x8
               	ldr	w0, [x0]
               	asr	x0, x0, #8
               	mov	x17, #0x1f              // =31
               	and	x0, x0, x17
               	lsl	x0, x0, #59
               	asr	x0, x0, #59
               	cmp	x0, x2
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	sub	x0, x29, #0x8
               	ldr	w0, [x0, #0x4]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xf, lsl #16
               	and	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xf, lsl #16
               	and	x1, x3, x17
               	eor	x0, x0, x1
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>

<build_mixed>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x5, x0
               	sxtw	x5, w5
               	sxtw	x1, w1
               	sxtw	x2, w2
               	sxtw	x3, w3
               	sxtw	x4, w4
               	sub	x0, x29, #0x10
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x6]
               	str	x10, [x0]
               	ldrb	w10, [x6, #0x8]
               	strb	w10, [x0, #0x8]
               	ldrb	w10, [x6, #0x9]
               	strb	w10, [x0, #0x9]
               	ldrb	w10, [x6, #0xa]
               	strb	w10, [x0, #0xa]
               	ldrb	w10, [x6, #0xb]
               	strb	w10, [x0, #0xb]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x10
               	strh	w5, [x0]
               	sub	x0, x29, #0x10
               	mov	x17, #0x7               // =7
               	and	x6, x1, x17
               	ldr	w7, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff8, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x7, x7, x17
               	lsl	x6, x6, #16
               	orr	x6, x7, x6
               	str	w6, [x0]
               	sub	x0, x29, #0x10
               	mov	x17, #0x3ff             // =1023
               	and	x6, x2, x17
               	ldr	w7, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xe007, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x7, x7, x17
               	lsl	x6, x6, #19
               	orr	x6, x7, x6
               	str	w6, [x0]
               	sub	x0, x29, #0x10
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7, lsl #16
               	and	x6, x3, x17
               	ldr	w7, [x0, #0x4]
               	mov	x17, #0xfff80000        // =4294443008
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x7, x7, x17
               	orr	x6, x7, x6
               	str	w6, [x0, #0x4]
               	sub	x0, x29, #0x10
               	str	w4, [x0, #0x8]
               	sub	x0, x29, #0x10
               	ldrh	w0, [x0]
               	mov	x17, #0xffff            // =65535
               	and	x5, x5, x17
               	cmp	x0, x5
               	cset	x5, eq
               	mov	x0, #0x0                // =0
               	cbz	x5, <addr>
               	sub	x0, x29, #0x10
               	ldr	w0, [x0]
               	asr	x0, x0, #16
               	mov	x17, #0x7               // =7
               	and	x0, x0, x17
               	mov	x17, #0x7               // =7
               	and	x1, x1, x17
               	eor	x0, x0, x1
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	sub	x0, x29, #0x10
               	ldr	w0, [x0]
               	asr	x0, x0, #19
               	mov	x17, #0x3ff             // =1023
               	and	x0, x0, x17
               	mov	x17, #0x3ff             // =1023
               	and	x1, x2, x17
               	eor	x0, x0, x1
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x2, #0x0                // =0
               	cbz	x1, <addr>
               	sub	x0, x29, #0x10
               	ldr	w0, [x0, #0x4]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7, lsl #16
               	and	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7, lsl #16
               	and	x1, x3, x17
               	eor	x0, x0, x1
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x2, ne
               	mov	x0, #0x0                // =0
               	cbz	x2, <addr>
               	sub	x0, x29, #0x10
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, x4
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x5                // =5
               	mov	x1, #0xa                // =10
               	mov	x2, #0xfffd             // =65533
               	movk	x2, #0xffff, lsl #16
               	movk	x2, #0xffff, lsl #32
               	movk	x2, #0xffff, lsl #48
               	mov	x3, #0x2345             // =9029
               	movk	x3, #0x1, lsl #16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xff               // =255
               	mov	x1, #0x1f               // =31
               	mov	x2, #0xf                // =15
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xfff, lsl #16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x2, #0xfff0             // =65520
               	movk	x2, #0xffff, lsl #16
               	movk	x2, #0xffff, lsl #32
               	movk	x2, #0xffff, lsl #48
               	mov	x1, x0
               	mov	x3, x0
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1234             // =4660
               	mov	x1, #0x6                // =6
               	mov	x2, #0x1f4              // =500
               	mov	x3, #0x86a0             // =34464
               	movk	x3, #0x1, lsl #16
               	mov	x4, #0xffb3             // =65459
               	movk	x4, #0xffff, lsl #16
               	movk	x4, #0xffff, lsl #32
               	movk	x4, #0xffff, lsl #48
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xffff             // =65535
               	mov	x1, #0x7                // =7
               	mov	x2, #0x3ff              // =1023
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0x7, lsl #16
               	mov	x4, #0xffff             // =65535
               	movk	x4, #0x7fff, lsl #16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
