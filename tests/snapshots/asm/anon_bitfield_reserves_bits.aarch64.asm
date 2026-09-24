
anon_bitfield_reserves_bits.aarch64:	file format elf64-littleaarch64

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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x8
               	mov	x1, #0x0                // =0
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	sub	x0, x29, #0x8
               	ldrb	w1, [x0, #0x2]
               	and	x1, x1, #0xfffffffffffffffb
               	orr	x1, x1, #0x4
               	strb	w1, [x0, #0x2]
               	sub	x1, x29, #0x8
               	ldrb	w2, [x1]
               	cbnz	w2, <addr>
               	ldrb	w2, [x1, #0x1]
               	cbnz	w2, <addr>
               	ldrb	w2, [x1, #0x2]
               	eor	x2, x2, #0x4
               	cbnz	w2, <addr>
               	ldrb	w1, [x1, #0x3]
               	cbz	w1, <addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	sub	x0, x29, #0x8
               	ldrb	w1, [x0, #0x2]
               	and	x1, x1, #0xffffffffffffff07
               	orr	x1, x1, #0xf8
               	strb	w1, [x0, #0x2]
               	sub	x1, x29, #0x8
               	ldrb	w2, [x1]
               	cbnz	w2, <addr>
               	ldrb	w2, [x1, #0x1]
               	cbnz	w2, <addr>
               	ldrb	w2, [x1, #0x2]
               	eor	x2, x2, #0xf8
               	cbnz	w2, <addr>
               	ldrb	w1, [x1, #0x3]
               	cbz	w1, <addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	sub	x0, x29, #0x8
               	ldrb	w1, [x0, #0x3]
               	and	x1, x1, #0xffffffffffffff80
               	orr	x1, x1, #0x7f
               	strb	w1, [x0, #0x3]
               	sub	x1, x29, #0x8
               	ldrb	w2, [x1]
               	cbnz	w2, <addr>
               	ldrb	w2, [x1, #0x1]
               	cbnz	w2, <addr>
               	ldrb	w2, [x1, #0x2]
               	cbnz	w2, <addr>
               	ldrb	w1, [x1, #0x3]
               	eor	x1, x1, #0x7f
               	cbz	w1, <addr>
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	sub	x0, x29, #0x8
               	ldrb	w1, [x0, #0x2]
               	and	x1, x1, #0xfffffffffffffffb
               	orr	x1, x1, #0x4
               	strb	w1, [x0, #0x2]
               	ldrb	w1, [x0, #0x2]
               	and	x1, x1, #0xffffffffffffff07
               	mov	x17, #0x48              // =72
               	orr	x1, x1, x17
               	strb	w1, [x0, #0x2]
               	ldrb	w1, [x0, #0x3]
               	and	x1, x1, #0xffffffffffffff80
               	mov	x17, #0x64              // =100
               	orr	x1, x1, x17
               	strb	w1, [x0, #0x3]
               	ldrb	w1, [x0, #0x2]
               	asr	x1, x1, #2
               	and	x1, x1, #0x1
               	cmp	w1, #0x1
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x2]
               	asr	x1, x1, #3
               	cmp	w1, #0x9
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x3]
               	and	x1, x1, #0x7f
               	cmp	w1, #0x64
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	sub	x0, x29, #0x8
               	mov	x1, #0xff               // =255
               	strb	w1, [x0, #0x3]
               	sub	x0, x29, #0x8
               	ldrb	w1, [x0]
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0x1]
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0x2]
               	cbnz	w1, <addr>
               	ldrb	w0, [x0, #0x3]
               	eor	x0, x0, #0xff
               	cbz	w0, <addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	sub	x0, x29, #0x10
               	mov	x1, #0x1                // =1
               	str	w1, [x0]
               	mov	x1, #0x3344             // =13124
               	movk	x1, #0x1122, lsl #16
               	str	w1, [x0, #0x8]
               	mov	x1, #0x7788             // =30600
               	movk	x1, #0x5566, lsl #16
               	str	w1, [x0, #0xc]
               	ldr	w1, [x0]
               	eor	x1, x1, #0x1
               	cbz	w1, <addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	w1, [x0, #0x8]
               	mov	x17, #0x3344            // =13124
               	movk	x17, #0x1122, lsl #16
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldr	w1, [x0, #0xc]
               	mov	x17, #0x7788            // =30600
               	movk	x17, #0x5566, lsl #16
               	eor	x1, x1, x17
               	cbz	w1, <addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x1, x0, #0x8
               	sub	x0, x1, x0
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
