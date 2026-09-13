
union_bitfield_layout.aarch64:	file format elf64-littleaarch64

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
               	ldr	w1, [x0]
               	and	x1, x1, #0xfffffffffffffff0
               	mov	x17, #0x5               // =5
               	orr	x1, x1, x17
               	str	w1, [x0]
               	ldr	w2, [x0, #0x4]
               	and	x2, x2, #0xfffffffffffffff0
               	orr	x2, x2, #0x3
               	str	w2, [x0, #0x4]
               	mov	w0, w1
               	and	x0, x0, #0xf
               	lsl	x0, x0, #60
               	asr	x0, x0, #60
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1f               // =31
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	w0, w2
               	and	x0, x0, #0xf
               	lsl	x0, x0, #60
               	asr	x0, x0, #60
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x20               // =32
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
