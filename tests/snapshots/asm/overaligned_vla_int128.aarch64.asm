
overaligned_vla_int128.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<fixed_beside_vla>:
               	str	x19, [sp, #-0x70]!
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	mov	x2, #0x3                // =3
               	mov	x0, #0xc                // =12
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
               	stur	x2, [x29, #-0x18]
               	ldur	x3, [x29, #-0x18]
               	sub	x1, x29, #0x40
               	str	x3, [x1]
               	asr	x3, x3, #63
               	str	x3, [x1, #0x8]
               	sub	x3, x29, #0x50
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x3]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x3
               	sub	x1, x29, #0x50
               	mov	x17, #0xf               // =15
               	and	x1, x1, x17
               	cbz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x3, [x1]
               	mov	x17, #0x1               // =1
               	orr	x3, x3, x17
               	str	w3, [x1]
               	str	w2, [x0]
               	mov	x2, #0x6                // =6
               	str	w2, [x0, #0x8]
               	sub	x1, x29, #0x50
               	ldr	x3, [x1]
               	ldr	x4, [x1, #0x8]
               	ldrsw	x5, [x0]
               	sxtw	x0, w2
               	add	x0, x5, x0
               	sxtw	x0, w0
               	asr	x2, x0, #63
               	add	x0, x3, x0
               	cmp	x0, x3
               	cset	x3, lo
               	add	x2, x4, x2
               	add	x2, x2, x3
               	str	x0, [x1]
               	str	x2, [x1, #0x8]
               	sub	x0, x29, #0x50
               	ldr	x0, [x0]
               	sub	sp, x29, #0x60
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp], #0x70
               	ret

<int128_vla>:
               	str	x19, [sp, #-0x70]!
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
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
               	mov	x17, #0xf               // =15
               	and	x1, x0, x17
               	cbz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	mov	x17, #0x2               // =2
               	orr	x2, x2, x17
               	str	w2, [x1]
               	sub	x1, x29, #0x28
               	str	x3, [x1]
               	mov	x2, #0x0                // =0
               	str	x2, [x1, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	add	x2, x0, #0x10
               	mov	x3, #0x6                // =6
               	sub	x1, x29, #0x38
               	str	x3, [x1]
               	mov	x3, #0x0                // =0
               	str	x3, [x1, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	ldr	x1, [x0]
               	add	x0, x0, #0x10
               	ldr	x3, [x0]
               	add	x0, x1, x3
               	sub	sp, x29, #0x60
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp], #0x70
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
