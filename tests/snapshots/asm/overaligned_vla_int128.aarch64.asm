
overaligned_vla_int128.aarch64:	file format elf64-littleaarch64

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

<fixed_beside_vla>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0x3                // =3
               	mov	x1, #0xc                // =12
               	add	x17, x1, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x1, sp
               	sub	x1, x1, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x1
               	stur	x0, [x29, #-0x10]
               	ldur	x2, [x29, #-0x10]
               	asr	x3, x2, #63
               	sub	x4, x29, #0x20
               	stur	x2, [x29, #-0x20]
               	stur	x3, [x29, #-0x18]
               	and	x2, x4, #0xf
               	cbz	x2, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x3, [x2]
               	orr	x3, x3, #0x1
               	str	w3, [x2]
               	str	w0, [x1]
               	mov	x0, #0x6                // =6
               	str	w0, [x1, #0x8]
               	ldur	x1, [x29, #-0x20]
               	ldur	x2, [x29, #-0x18]
               	add	x0, x1, #0x9
               	cmp	x0, x1
               	cset	x1, lo
               	add	x1, x2, x1
               	stur	x0, [x29, #-0x20]
               	stur	x1, [x29, #-0x18]
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret

<int128_vla>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x2, #0x2                // =2
               	mov	x0, #0x20               // =32
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x0, sp
               	sub	x0, x0, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x0
               	and	x1, x0, #0xf
               	cbz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x3, [x1]
               	orr	x3, x3, #0x2
               	str	w3, [x1]
               	str	x2, [x0]
               	str	xzr, [x0, #0x8]
               	add	x0, x0, #0x10
               	mov	x2, #0x6                // =6
               	str	x2, [x0]
               	str	xzr, [x0, #0x8]
               	mov	x0, #0x8                // =8
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	cmp	x0, #0xc
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x20               // =32
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	ldp	x29, x30, [sp], #0x10
               	ret
