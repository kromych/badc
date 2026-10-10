
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
               	ldurb	w1, [x29, #-0x6]
               	and	x1, x1, #0xfffffffffffffffb
               	orr	x1, x1, #0x4
               	sturb	w1, [x29, #-0x6]
               	ldurb	w1, [x29, #-0x8]
               	cbnz	w1, <addr>
               	ldurb	w1, [x29, #-0x7]
               	cbnz	w1, <addr>
               	ldurb	w1, [x29, #-0x6]
               	eor	x1, x1, #0x4
               	cbnz	w1, <addr>
               	ldurb	w1, [x29, #-0x5]
               	cbz	w1, <addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	sub	x0, x29, #0x8
               	ldurb	w1, [x29, #-0x6]
               	and	x1, x1, #0xffffffffffffff07
               	orr	x1, x1, #0xf8
               	sturb	w1, [x29, #-0x6]
               	ldurb	w1, [x29, #-0x8]
               	cbnz	w1, <addr>
               	ldurb	w1, [x29, #-0x7]
               	cbnz	w1, <addr>
               	ldurb	w1, [x29, #-0x6]
               	eor	x1, x1, #0xf8
               	cbnz	w1, <addr>
               	ldurb	w1, [x29, #-0x5]
               	cbz	w1, <addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	sub	x0, x29, #0x8
               	ldurb	w1, [x29, #-0x5]
               	and	x1, x1, #0xffffffffffffff80
               	orr	x1, x1, #0x7f
               	sturb	w1, [x29, #-0x5]
               	ldurb	w1, [x29, #-0x8]
               	cbnz	w1, <addr>
               	ldurb	w1, [x29, #-0x7]
               	cbnz	w1, <addr>
               	ldurb	w1, [x29, #-0x6]
               	cbnz	w1, <addr>
               	ldurb	w1, [x29, #-0x5]
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
               	ldurb	w1, [x29, #-0x6]
               	and	x1, x1, #0xfffffffffffffffb
               	orr	x1, x1, #0x4
               	sturb	w1, [x29, #-0x6]
               	ldurb	w1, [x29, #-0x6]
               	and	x1, x1, #0xffffffffffffff07
               	mov	x17, #0x48              // =72
               	orr	x1, x1, x17
               	sturb	w1, [x29, #-0x6]
               	ldurb	w1, [x29, #-0x5]
               	and	x1, x1, #0xffffffffffffff80
               	mov	x17, #0x64              // =100
               	orr	x1, x1, x17
               	sturb	w1, [x29, #-0x5]
               	ldurb	w1, [x29, #-0x6]
               	asr	x1, x1, #2
               	and	x1, x1, #0x1
               	cmp	w1, #0x1
               	b.ne	<addr>
               	ldurb	w1, [x29, #-0x6]
               	asr	x1, x1, #3
               	cmp	w1, #0x9
               	b.ne	<addr>
               	ldurb	w1, [x29, #-0x5]
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
               	mov	x0, #0xff               // =255
               	sturb	w0, [x29, #-0x5]
               	ldurb	w0, [x29, #-0x8]
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x7]
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x6]
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x5]
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
               	stur	w1, [x29, #-0x8]
               	mov	x1, #0x7788             // =30600
               	movk	x1, #0x5566, lsl #16
               	stur	w1, [x29, #-0x4]
               	ldr	w1, [x0]
               	eor	x1, x1, #0x1
               	cbz	w1, <addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w1, [x29, #-0x8]
               	mov	x17, #0x3344            // =13124
               	movk	x17, #0x1122, lsl #16
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldur	w1, [x29, #-0x4]
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
