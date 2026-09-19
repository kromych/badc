
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
               	sub	sp, sp, #0x30
               	mov	x2, #0x3                // =3
               	mov	x0, #0xc                // =12
               	add	x17, x0, #0xf
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
               	stur	x2, [x29, #-0x20]
               	ldur	x3, [x29, #-0x20]
               	asr	x4, x3, #63
               	sub	x0, x29, #0x30
               	str	x3, [x0]
               	str	x4, [x0, #0x8]
               	and	x3, x0, #0xf
               	cbz	x3, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x4, [x3]
               	orr	x4, x4, #0x1
               	str	w4, [x3]
               	str	w2, [x1]
               	mov	x2, #0x6                // =6
               	str	w2, [x1, #0x8]
               	ldr	x2, [x0]
               	ldr	x3, [x0, #0x8]
               	add	x1, x2, #0x9
               	cmp	x1, x2
               	cset	x2, lo
               	add	x2, x3, x2
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x0, x1
               	sub	sp, x29, #0x30
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<int128_vla>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x3, #0x2                // =2
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
               	ldrsw	x2, [x1]
               	orr	x2, x2, #0x2
               	str	w2, [x1]
               	mov	x1, #0x0                // =0
               	str	x3, [x0]
               	str	x1, [x0, #0x8]
               	add	x2, x0, #0x10
               	mov	x3, #0x6                // =6
               	str	x3, [x2]
               	str	x1, [x2, #0x8]
               	mov	x0, #0x8                // =8
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
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
