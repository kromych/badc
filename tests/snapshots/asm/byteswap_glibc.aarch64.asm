
byteswap_glibc.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x708              // =1800
               	movk	x0, #0x506, lsl #16
               	movk	x0, #0x304, lsl #32
               	movk	x0, #0x102, lsl #48
               	stur	x0, [x29, #-0x8]
               	mov	x0, #0x3344             // =13124
               	movk	x0, #0x1122, lsl #16
               	stur	w0, [x29, #-0x10]
               	mov	x0, #0xabcd             // =43981
               	sturh	w0, [x29, #-0x18]
               	ldurh	w0, [x29, #-0x18]
               	mov	x17, #0xff              // =255
               	and	x1, x0, x17
               	lsl	x1, x1, #8
               	lsr	x0, x0, #8
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	orr	x0, x1, x0
               	mov	x17, #0xcdab            // =52651
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0x10]
               	mov	x17, #0xff              // =255
               	and	x1, x0, x17
               	lsl	x1, x1, #24
               	lsr	x2, x0, #8
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #16
               	orr	x1, x1, x2
               	lsr	x2, x0, #16
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #8
               	orr	x1, x1, x2
               	lsr	x0, x0, #24
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	orr	x0, x1, x0
               	mov	x17, #0x2211            // =8721
               	movk	x17, #0x4433, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x8]
               	mov	x17, #0xff              // =255
               	and	x1, x0, x17
               	lsl	x1, x1, #56
               	lsr	x2, x0, #8
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #48
               	orr	x1, x1, x2
               	lsr	x2, x0, #16
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #40
               	orr	x1, x1, x2
               	lsr	x2, x0, #24
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #32
               	orr	x1, x1, x2
               	lsr	x2, x0, #32
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #24
               	orr	x1, x1, x2
               	lsr	x2, x0, #40
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #16
               	orr	x1, x1, x2
               	lsr	x2, x0, #48
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #8
               	orr	x1, x1, x2
               	lsr	x0, x0, #56
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	orr	x0, x1, x0
               	mov	x17, #0x201             // =513
               	movk	x17, #0x403, lsl #16
               	movk	x17, #0x605, lsl #32
               	movk	x17, #0x807, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x8]
               	mov	x17, #0xffff            // =65535
               	and	x1, x0, x17
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	lsl	x0, x0, #8
               	lsr	x1, x1, #8
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	orr	x0, x0, x1
               	mov	x17, #0x807             // =2055
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x1, [x29, #-0x8]
               	mov	w0, w1
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	lsl	x1, x1, #24
               	lsr	x2, x0, #8
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #16
               	orr	x1, x1, x2
               	lsr	x2, x0, #16
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #8
               	orr	x1, x1, x2
               	lsr	x0, x0, #24
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	orr	x0, x1, x0
               	mov	x17, #0x605             // =1541
               	movk	x17, #0x807, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurh	w0, [x29, #-0x18]
               	mov	x17, #0xff              // =255
               	and	x1, x0, x17
               	lsl	x1, x1, #8
               	lsr	x0, x0, #8
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	orr	x0, x1, x0
               	mov	x17, #0xffff            // =65535
               	and	x1, x0, x17
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	lsl	x0, x0, #8
               	lsr	x1, x1, #8
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	orr	x0, x0, x1
               	ldurh	w1, [x29, #-0x18]
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0x10]
               	mov	x17, #0xff              // =255
               	and	x1, x0, x17
               	lsl	x1, x1, #24
               	lsr	x2, x0, #8
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #16
               	orr	x1, x1, x2
               	lsr	x2, x0, #16
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #8
               	orr	x1, x1, x2
               	lsr	x0, x0, #24
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	orr	x1, x1, x0
               	mov	w0, w1
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	lsl	x1, x1, #24
               	lsr	x2, x0, #8
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #16
               	orr	x1, x1, x2
               	lsr	x2, x0, #16
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #8
               	orr	x1, x1, x2
               	lsr	x0, x0, #24
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	orr	x0, x1, x0
               	ldur	w1, [x29, #-0x10]
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x8]
               	mov	x17, #0xff              // =255
               	and	x1, x0, x17
               	lsl	x1, x1, #56
               	lsr	x2, x0, #8
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #48
               	orr	x1, x1, x2
               	lsr	x2, x0, #16
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #40
               	orr	x1, x1, x2
               	lsr	x2, x0, #24
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #32
               	orr	x1, x1, x2
               	lsr	x2, x0, #32
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #24
               	orr	x1, x1, x2
               	lsr	x2, x0, #40
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #16
               	orr	x1, x1, x2
               	lsr	x2, x0, #48
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #8
               	orr	x1, x1, x2
               	lsr	x0, x0, #56
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	orr	x0, x1, x0
               	mov	x17, #0xff              // =255
               	and	x1, x0, x17
               	lsl	x1, x1, #56
               	lsr	x2, x0, #8
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #48
               	orr	x1, x1, x2
               	lsr	x2, x0, #16
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #40
               	orr	x1, x1, x2
               	lsr	x2, x0, #24
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #32
               	orr	x1, x1, x2
               	lsr	x2, x0, #32
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #24
               	orr	x1, x1, x2
               	lsr	x2, x0, #40
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #16
               	orr	x1, x1, x2
               	lsr	x2, x0, #48
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #8
               	orr	x1, x1, x2
               	lsr	x0, x0, #56
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	orr	x0, x1, x0
               	ldur	x1, [x29, #-0x8]
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurh	w0, [x29, #-0x18]
               	mov	x17, #0xff              // =255
               	and	x1, x0, x17
               	lsl	x1, x1, #8
               	lsr	x0, x0, #8
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	orr	x1, x1, x0
               	ldurh	w0, [x29, #-0x18]
               	mov	x17, #0xff              // =255
               	and	x2, x0, x17
               	lsl	x2, x2, #8
               	lsr	x0, x0, #8
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	orr	x0, x2, x0
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0x10]
               	mov	x17, #0xff              // =255
               	and	x1, x0, x17
               	lsl	x1, x1, #24
               	lsr	x2, x0, #8
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #16
               	orr	x1, x1, x2
               	lsr	x2, x0, #16
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #8
               	orr	x1, x1, x2
               	lsr	x0, x0, #24
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	orr	x1, x1, x0
               	ldur	w0, [x29, #-0x10]
               	mov	x17, #0xff              // =255
               	and	x2, x0, x17
               	lsl	x2, x2, #24
               	lsr	x3, x0, #8
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	lsl	x3, x3, #16
               	orr	x2, x2, x3
               	lsr	x3, x0, #16
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	lsl	x3, x3, #8
               	orr	x2, x2, x3
               	lsr	x0, x0, #24
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	orr	x0, x2, x0
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x8]
               	mov	x17, #0xff              // =255
               	and	x1, x0, x17
               	lsl	x1, x1, #56
               	lsr	x2, x0, #8
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #48
               	orr	x1, x1, x2
               	lsr	x2, x0, #16
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #40
               	orr	x1, x1, x2
               	lsr	x2, x0, #24
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #32
               	orr	x1, x1, x2
               	lsr	x2, x0, #32
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #24
               	orr	x1, x1, x2
               	lsr	x2, x0, #40
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #16
               	orr	x1, x1, x2
               	lsr	x2, x0, #48
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #8
               	orr	x1, x1, x2
               	lsr	x0, x0, #56
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	orr	x1, x1, x0
               	ldur	x0, [x29, #-0x8]
               	mov	x17, #0xff              // =255
               	and	x2, x0, x17
               	lsl	x2, x2, #56
               	lsr	x3, x0, #8
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	lsl	x3, x3, #48
               	orr	x2, x2, x3
               	lsr	x3, x0, #16
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	lsl	x3, x3, #40
               	orr	x2, x2, x3
               	lsr	x3, x0, #24
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	lsl	x3, x3, #32
               	orr	x2, x2, x3
               	lsr	x3, x0, #32
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	lsl	x3, x3, #24
               	orr	x2, x2, x3
               	lsr	x3, x0, #40
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	lsl	x3, x3, #16
               	orr	x2, x2, x3
               	lsr	x3, x0, #48
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	lsl	x3, x3, #8
               	orr	x2, x2, x3
               	lsr	x0, x0, #56
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	orr	x0, x2, x0
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
