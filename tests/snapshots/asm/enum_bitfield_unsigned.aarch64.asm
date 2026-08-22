
enum_bitfield_unsigned.aarch64:	file format elf64-littleaarch64

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
               	ldur	w0, [x29, #-0x8]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0x6               // =6
               	orr	x0, x0, x17
               	stur	w0, [x29, #-0x8]
               	mov	w1, w0
               	mov	x17, #0x7               // =7
               	and	x2, x1, x17
               	cmp	w2, #0x6
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x1, x17
               	mov	x17, #0x4               // =4
               	orr	x0, x0, x17
               	stur	w0, [x29, #-0x8]
               	mov	w1, w0
               	mov	x17, #0x7               // =7
               	and	x2, x1, x17
               	cmp	w2, #0x4
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x1, x17
               	mov	x17, #0x2               // =2
               	orr	x0, x0, x17
               	stur	w0, [x29, #-0x8]
               	mov	w0, w0
               	mov	x17, #0x7               // =7
               	and	x0, x0, x17
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0x8]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0x5               // =5
               	orr	x0, x0, x17
               	stur	w0, [x29, #-0x8]
               	mov	w0, w0
               	mov	x17, #0x7               // =7
               	and	x0, x0, x17
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3c               // =60
               	mov	x0, #0x32               // =50
               	mov	x0, #0x28               // =40
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
