
bitfield_mixed_base_packing.aarch64:	file format elf64-littleaarch64

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
               	sub	x0, x29, #0x10
               	ldr	w1, [x0]
               	and	x1, x1, #0xffffffff80000000
               	orr	x1, x1, #0x7fffffff
               	str	w1, [x0]
               	ldrb	w1, [x0, #0x3]
               	and	x1, x1, #0xffffffffffffff7f
               	orr	x1, x1, #0x80
               	strb	w1, [x0, #0x3]
               	ldr	w2, [x0, #0x4]
               	and	x2, x2, #0xffffffffc0000000
               	orr	x2, x2, #0x3fffffff
               	str	w2, [x0, #0x4]
               	ldrb	w2, [x0, #0x7]
               	and	x2, x2, #0xffffffffffffff3f
               	orr	x2, x2, #0xc0
               	strb	w2, [x0, #0x7]
               	mov	x3, #0xbeef             // =48879
               	movk	x3, #0xdead, lsl #16
               	str	w3, [x0, #0x8]
               	mov	x3, #0xab               // =171
               	strb	w3, [x0, #0xc]
               	ldr	w3, [x0]
               	and	x3, x3, #0x7fffffff
               	mov	x17, #0x7fffffff        // =2147483647
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x1, x1, #0xff
               	asr	x1, x1, #7
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	w1, [x0, #0x4]
               	and	x1, x1, #0x3fffffff
               	mov	x17, #0x3fffffff        // =1073741823
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x1, x2, #0xff
               	asr	x2, x1, #6
               	cmp	w2, #0x3
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	w2, [x0]
               	and	x2, x2, #0xffffffff80000000
               	str	w2, [x0]
               	and	x1, x1, #0xffffffffffffff3f
               	strb	w1, [x0, #0x7]
               	sub	x0, x29, #0x8
               	ldrh	w1, [x0]
               	and	x1, x1, #0xfffffffffffffe00
               	orr	x1, x1, #0x1ff
               	strh	w1, [x0]
               	ldrh	w2, [x0, #0x2]
               	and	x2, x2, #0xfffffffffffffe00
               	mov	x17, #0x123             // =291
               	orr	x2, x2, x17
               	strh	w2, [x0, #0x2]
               	and	x0, x1, #0xffff
               	and	x0, x0, #0x1ff
               	cmp	w0, #0x1ff
               	b.ne	<addr>
               	and	x0, x2, #0xffff
               	and	x0, x0, #0x1ff
               	cmp	w0, #0x123
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
