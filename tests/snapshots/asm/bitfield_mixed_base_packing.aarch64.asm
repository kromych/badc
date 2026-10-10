
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
               	ldur	w0, [x29, #-0x10]
               	and	x0, x0, #0xffffffff80000000
               	orr	x0, x0, #0x7fffffff
               	stur	w0, [x29, #-0x10]
               	ldurb	w0, [x29, #-0xd]
               	and	x0, x0, #0xffffffffffffff7f
               	orr	x0, x0, #0x80
               	sturb	w0, [x29, #-0xd]
               	ldur	w1, [x29, #-0xc]
               	and	x1, x1, #0xffffffffc0000000
               	orr	x1, x1, #0x3fffffff
               	stur	w1, [x29, #-0xc]
               	ldurb	w1, [x29, #-0x9]
               	and	x1, x1, #0xffffffffffffff3f
               	orr	x1, x1, #0xc0
               	sturb	w1, [x29, #-0x9]
               	mov	x2, #0xbeef             // =48879
               	movk	x2, #0xdead, lsl #16
               	stur	w2, [x29, #-0x8]
               	mov	x2, #0xab               // =171
               	sturb	w2, [x29, #-0x4]
               	ldur	w2, [x29, #-0x10]
               	and	x2, x2, #0x7fffffff
               	mov	x17, #0x7fffffff        // =2147483647
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x0, x0, #0xff
               	asr	x0, x0, #7
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0xc]
               	and	x0, x0, #0x3fffffff
               	mov	x17, #0x3fffffff        // =1073741823
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x0, x1, #0xff
               	asr	x1, x0, #6
               	cmp	w1, #0x3
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w1, [x29, #-0x10]
               	and	x1, x1, #0xffffffff80000000
               	stur	w1, [x29, #-0x10]
               	and	x0, x0, #0xffffffffffffff3f
               	sturb	w0, [x29, #-0x9]
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
