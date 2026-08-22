
byteswap_glibc.aarch64:	file format elf64-littleaarch64

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
               	rev	w0, w0
               	lsr	w0, w0, #16
               	mov	x17, #0xcdab            // =52651
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0x10]
               	rev	w0, w0
               	mov	x17, #0x2211            // =8721
               	movk	x17, #0x4433, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x8]
               	rev	x0, x0
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
               	rev	w0, w0
               	lsr	w0, w0, #16
               	mov	x17, #0x807             // =2055
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x8]
               	rev	w0, w0
               	mov	x17, #0x605             // =1541
               	movk	x17, #0x807, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurh	w0, [x29, #-0x18]
               	rev	w0, w0
               	lsr	w0, w0, #16
               	rev	w0, w0
               	lsr	w0, w0, #16
               	ldurh	w1, [x29, #-0x18]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0x10]
               	rev	w0, w0
               	rev	w0, w0
               	ldur	w1, [x29, #-0x10]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x8]
               	rev	x0, x0
               	rev	x0, x0
               	ldur	x1, [x29, #-0x8]
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurh	w0, [x29, #-0x18]
               	rev	w0, w0
               	lsr	w0, w0, #16
               	ldurh	w1, [x29, #-0x18]
               	rev	w1, w1
               	lsr	w1, w1, #16
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0x10]
               	rev	w0, w0
               	ldur	w1, [x29, #-0x10]
               	rev	w1, w1
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x8]
               	rev	x0, x0
               	ldur	x1, [x29, #-0x8]
               	rev	x1, x1
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
