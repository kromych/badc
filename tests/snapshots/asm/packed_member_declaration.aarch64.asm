
packed_member_declaration.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x0                // =0
               	mov	x1, #0x3                // =3
               	stur	x1, [x29, #-0x8]
               	ldur	w1, [x29, #-0x8]
               	and	x1, x1, #0xfffffffff00000ff
               	mov	x17, #0x100             // =256
               	movk	x17, #0x800, lsl #16
               	orr	x1, x1, x17
               	stur	w1, [x29, #-0x8]
               	ldur	w1, [x29, #-0x5]
               	and	x1, x1, #0xffffffffff00000f
               	orr	x1, x1, #0x7ffff0
               	stur	w1, [x29, #-0x5]
               	mov	x1, #0x4                // =4
               	sturb	w1, [x29, #-0x2]
               	ldurb	w1, [x29, #-0x8]
               	cmp	w1, #0x3
               	b.ne	<addr>
               	ldur	w1, [x29, #-0x8]
               	sbfx	x1, x1, #8, #20
               	mov	x17, #-0x7ffff          // =-524287
               	cmp	w1, w17
               	b.ne	<addr>
               	ldur	w1, [x29, #-0x5]
               	sbfx	x2, x1, #4, #20
               	mov	x17, #0x7ffff           // =524287
               	cmp	w2, w17
               	b.ne	<addr>
               	and	x1, x1, #0xffffffffff00000f
               	orr	x1, x1, #0xfffff0
               	stur	w1, [x29, #-0x5]
               	ldur	w2, [x29, #-0x8]
               	sbfx	x2, x2, #8, #20
               	mov	x17, #-0x7ffff          // =-524287
               	cmp	w2, w17
               	b.ne	<addr>
               	sbfx	x1, x1, #4, #20
               	cmn	w1, #0x1
               	b.ne	<addr>
               	ldurb	w1, [x29, #-0x2]
               	cmp	w1, #0x4
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
