
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
               	sub	x0, x29, #0x8
               	ldr	w1, [x0]
               	and	x1, x1, #0xffffffffffffff00
               	orr	x1, x1, #0x10
               	str	w1, [x0]
               	ldrb	w1, [x0, #0x1]
               	and	x1, x1, #0xfffffffffffffffe
               	orr	x1, x1, #0x1
               	strb	w1, [x0, #0x1]
               	and	x1, x1, #0xff
               	and	x1, x1, #0xfffffffffffffffd
               	strb	w1, [x0, #0x1]
               	ldr	w1, [x0]
               	and	x1, x1, #0xfffffffffffffbff
               	orr	x1, x1, #0x400
               	str	w1, [x0]
               	and	x1, x1, #0xfffffffffffff7ff
               	orr	x1, x1, #0x800
               	str	w1, [x0]
               	ldrb	w2, [x0, #0x1]
               	and	x2, x2, #0x1
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w2, [x0, #0x1]
               	asr	x2, x2, #1
               	tbz	w2, #0x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x40               // =64
               	ldrb	w2, [x0, #0x1]
               	and	x2, x2, #0x1
               	lsl	x2, x2, #3
               	sub	x2, x3, x2
               	cmp	w2, #0x38
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w2, [x0, #0x1]
               	tbz	w2, #0x0, <addr>
               	ldrb	w0, [x0, #0x1]
               	asr	x0, x0, #1
               	tbnz	w0, #0x0, <addr>
               	mov	w0, w1
               	asr	x2, x0, #11
               	and	x2, x2, #0x1
               	cmp	w2, #0x1
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
