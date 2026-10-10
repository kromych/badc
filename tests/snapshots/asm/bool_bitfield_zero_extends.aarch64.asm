
bool_bitfield_zero_extends.aarch64:	file format elf64-littleaarch64

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
               	and	x0, x0, #0xffffffffffffff00
               	orr	x0, x0, #0x10
               	stur	w0, [x29, #-0x8]
               	ldurb	w0, [x29, #-0x7]
               	and	x0, x0, #0xfffffffffffffffe
               	orr	x0, x0, #0x1
               	sturb	w0, [x29, #-0x7]
               	and	x0, x0, #0xff
               	and	x0, x0, #0xfffffffffffffffd
               	sturb	w0, [x29, #-0x7]
               	ldur	w0, [x29, #-0x8]
               	and	x0, x0, #0xfffffffffffffbff
               	orr	x0, x0, #0x400
               	stur	w0, [x29, #-0x8]
               	and	x0, x0, #0xfffffffffffff7ff
               	orr	x0, x0, #0x800
               	stur	w0, [x29, #-0x8]
               	ldurb	w1, [x29, #-0x7]
               	and	x1, x1, #0x1
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w1, [x29, #-0x7]
               	asr	x1, x1, #1
               	tbz	w1, #0x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x40               // =64
               	ldurb	w2, [x29, #-0x7]
               	and	x2, x2, #0x1
               	lsl	x2, x2, #3
               	sub	x1, x1, x2
               	cmp	w1, #0x38
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w1, [x29, #-0x7]
               	tbz	w1, #0x0, <addr>
               	ldurb	w1, [x29, #-0x7]
               	asr	x1, x1, #1
               	tbnz	w1, #0x0, <addr>
               	mov	w0, w0
               	asr	x1, x0, #11
               	and	x1, x1, #0x1
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	asr	x0, x0, #10
               	and	x0, x0, #0x1
               	lsl	x0, x0, #63
               	asr	x0, x0, #63
               	mov	x17, #-0x1              // =-1
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
