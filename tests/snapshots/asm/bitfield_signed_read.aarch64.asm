
bitfield_signed_read.aarch64:	file format elf64-littleaarch64

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
               	and	x0, x0, #0xfffffffffffff000
               	orr	x0, x0, #0x7
               	stur	w0, [x29, #-0x8]
               	ldurh	w0, [x29, #-0x8]
               	and	x0, x0, #0xffffffffffffcfff
               	orr	x0, x0, #0x3000
               	sturh	w0, [x29, #-0x8]
               	and	x0, x0, #0xffff
               	and	x0, x0, #0xffffffffffff3fff
               	orr	x0, x0, #0x4000
               	sturh	w0, [x29, #-0x8]
               	ldur	w1, [x29, #-0x8]
               	and	x1, x1, #0xfff
               	cmp	w1, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1f               // =31
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x0, x0, #0xffff
               	asr	x1, x0, #12
               	and	x1, x1, #0x3
               	lsl	x1, x1, #62
               	asr	x1, x1, #62
               	mov	x17, #-0x1              // =-1
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x20               // =32
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	asr	x0, x0, #14
               	lsl	x0, x0, #62
               	asr	x0, x0, #62
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x21               // =33
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
