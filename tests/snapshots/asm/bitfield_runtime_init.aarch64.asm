
bitfield_runtime_init.aarch64:	file format elf64-littleaarch64

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

<build_packed>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x4, x0
               	mov	x7, x3
               	mov	x6, x2
               	mov	x5, x1
               	sxtw	x4, w4
               	sxtw	x5, w5
               	sxtw	x6, w6
               	sub	x1, x29, #0x8
               	mov	x0, #0x0                // =0
               	str	x0, [x1]
               	mov	x17, #0xf               // =15
               	and	x3, x4, x17
               	mov	x17, #0x0               // =0
               	orr	x2, x3, x17
               	str	w2, [x1]
               	mov	x17, #0xf               // =15
               	and	x8, x5, x17
               	mov	w2, w2
               	mov	x17, #0xff0f            // =65295
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x2, x2, x17
               	lsl	x9, x8, #4
               	orr	x2, x2, x9
               	str	w2, [x1]
               	mov	x17, #0x1f              // =31
               	and	x9, x6, x17
               	mov	w2, w2
               	mov	x17, #0xe0ff            // =57599
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x2, x2, x17
               	lsl	x10, x9, #8
               	orr	x2, x2, x10
               	str	w2, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xf, lsl #16
               	and	x9, x7, x17
               	mov	x17, #0x0               // =0
               	orr	x10, x9, x17
               	str	w10, [x1, #0x4]
               	mov	w1, w2
               	mov	x17, #0xf               // =15
               	and	x11, x1, x17
               	eor	x3, x11, x3
               	mov	w3, w3
               	cbnz	x3, <addr>
               	asr	x3, x1, #4
               	mov	x17, #0xf               // =15
               	and	x3, x3, x17
               	eor	x3, x3, x8
               	mov	w3, w3
               	cmp	w3, #0x0
               	cset	x3, eq
               	cbz	x3, <addr>
               	asr	x1, x1, #8
               	mov	x17, #0x1f              // =31
               	and	x1, x1, x17
               	lsl	x1, x1, #59
               	asr	x1, x1, #59
               	cmp	x1, x6
               	cset	x1, eq
               	cbz	x1, <addr>
               	mov	w0, w10
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xf, lsl #16
               	and	x0, x0, x17
               	eor	x0, x0, x9
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, eq
               	sxtw	x0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x3, x0
               	b	<addr>

<build_mixed>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x5, x0
               	mov	x7, x2
               	mov	x6, x1
               	sxtw	x6, w6
               	sxtw	x7, w7
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	w1, [x0, #0x8]
               	strh	w5, [x0]
               	mov	x17, #0x7               // =7
               	and	x8, x6, x17
               	ldr	w2, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xfff8, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x2, x2, x17
               	lsl	x9, x8, #16
               	orr	x2, x2, x9
               	str	w2, [x0]
               	mov	x17, #0x3ff             // =1023
               	and	x9, x7, x17
               	mov	w2, w2
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xe007, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x2, x2, x17
               	lsl	x10, x9, #19
               	orr	x2, x2, x10
               	str	w2, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7, lsl #16
               	and	x10, x3, x17
               	mov	x17, #0x0               // =0
               	orr	x11, x10, x17
               	str	w11, [x0, #0x4]
               	str	w4, [x0, #0x8]
               	ldrh	w0, [x0]
               	mov	x17, #0xffff            // =65535
               	and	x5, x5, x17
               	cmp	w0, w5
               	b.ne	<addr>
               	mov	w0, w2
               	asr	x0, x0, #16
               	mov	x17, #0x7               // =7
               	and	x0, x0, x17
               	eor	x0, x0, x8
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	w0, w2
               	asr	x0, x0, #19
               	mov	x17, #0x3ff             // =1023
               	and	x0, x0, x17
               	eor	x0, x0, x9
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	w0, w11
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7, lsl #16
               	and	x0, x0, x17
               	eor	x0, x0, x10
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	cmp	w4, w4
               	cset	x1, eq
               	sxtw	x0, w1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, x1
               	b	<addr>
               	mov	x0, x1
               	b	<addr>
               	mov	x0, x1
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
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xff               // =255
               	mov	x1, #0x1f               // =31
               	mov	x2, #0xf                // =15
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xfff, lsl #16
               	bl	<addr>
               	cbnz	x0, <addr>
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
               	cbnz	x0, <addr>
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
               	cbnz	x0, <addr>
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
               	cbnz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
