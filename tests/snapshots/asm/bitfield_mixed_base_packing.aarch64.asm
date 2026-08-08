
bitfield_mixed_base_packing.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x10
               	ldr	w1, [x0]
               	mov	x17, #0x80000000        // =2147483648
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7fff, lsl #16
               	orr	x1, x1, x17
               	str	w1, [x0]
               	sub	x0, x29, #0x10
               	ldrb	w1, [x0, #0x3]
               	mov	x17, #0xff7f            // =65407
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0x80              // =128
               	orr	x2, x1, x17
               	strb	w2, [x0, #0x3]
               	sub	x0, x29, #0x10
               	ldr	w1, [x0, #0x4]
               	mov	x17, #0xc0000000        // =3221225472
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x3fff, lsl #16
               	orr	x1, x1, x17
               	str	w1, [x0, #0x4]
               	sub	x0, x29, #0x10
               	ldrb	w1, [x0, #0x7]
               	mov	x17, #0xff3f            // =65343
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0xc0              // =192
               	orr	x1, x1, x17
               	strb	w1, [x0, #0x7]
               	sub	x0, x29, #0x10
               	mov	x3, #0xbeef             // =48879
               	movk	x3, #0xdead, lsl #16
               	str	w3, [x0, #0x8]
               	sub	x0, x29, #0x10
               	mov	x3, #0xab               // =171
               	strb	w3, [x0, #0xc]
               	sub	x0, x29, #0x10
               	ldr	w0, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7fff, lsl #16
               	and	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7fff, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xff              // =255
               	and	x0, x2, x17
               	asr	x0, x0, #7
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	w0, [x0, #0x4]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x3fff, lsl #16
               	and	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x3fff, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xff              // =255
               	and	x0, x1, x17
               	asr	x0, x0, #6
               	mov	x17, #0x3               // =3
               	and	x0, x0, x17
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	mov	x2, #0x0                // =0
               	ldr	w3, [x0]
               	mov	x17, #0x80000000        // =2147483648
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x3, x3, x17
               	orr	x3, x3, x2
               	str	w3, [x0]
               	sub	x0, x29, #0x10
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	mov	x17, #0xff3f            // =65343
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	orr	x1, x1, x2
               	strb	w1, [x0, #0x7]
               	sub	x0, x29, #0x18
               	ldrh	w1, [x0]
               	mov	x17, #0xfe00            // =65024
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0x1ff             // =511
               	orr	x1, x1, x17
               	strh	w1, [x0]
               	sub	x0, x29, #0x18
               	ldrh	w2, [x0, #0x2]
               	mov	x17, #0xfe00            // =65024
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x2, x2, x17
               	mov	x17, #0x123             // =291
               	orr	x2, x2, x17
               	strh	w2, [x0, #0x2]
               	mov	x17, #0xffff            // =65535
               	and	x0, x1, x17
               	mov	x17, #0x1ff             // =511
               	and	x0, x0, x17
               	cmp	x0, #0x1ff
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x17, #0xffff            // =65535
               	and	x0, x2, x17
               	mov	x17, #0x1ff             // =511
               	and	x0, x0, x17
               	cmp	x0, #0x123
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
