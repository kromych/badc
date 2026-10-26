
vla_typedef_block_scope.aarch64:	file format elf64-littleaarch64

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

<bound_at_declaration>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sxtw	x0, w0
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x2, sp
               	sub	x2, x2, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x2
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
               	cmp	w0, w0
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	cmp	w1, w0
               	b.ge	<addr>
               	add	x3, x1, #0x61
               	and	x3, x3, #0xff
               	strb	w3, [x2, x1]
               	add	x1, x1, #0x1
               	cmp	w1, w0
               	b.lt	<addr>
               	sub	x1, x0, #0x1
               	ldrb	w1, [x2, w1, sxtw]
               	add	x3, x0, #0x61
               	sub	x3, x3, #0x1
               	and	x3, x3, #0xff
               	cmp	w1, w3
               	b.ne	<addr>
               	ldrb	w1, [x2]
               	mov	x17, #0x61              // =97
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	sub	x1, x0, #0x1
               	ldrb	w1, [x2, w1, sxtw]
               	cmp	w1, w1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x1, x2, x0
               	sub	x1, x1, x2
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	lsl	x0, x0, #2
               	cmp	x0, x0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret

<per_iteration>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x0                // =0
               	mov	x2, #0x1                // =1
               	mov	x6, sp
               	ubfx	x1, x2, #0, #62
               	lsl	x5, x1, #2
               	add	x17, x5, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x3, sp
               	sub	x3, x3, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x3
               	mov	x1, #0x0                // =0
               	cmp	w1, w2
               	b.ge	<addr>
               	str	w1, [x3, x1, lsl #2]
               	add	x1, x1, #0x1
               	cmp	w1, w2
               	b.lt	<addr>
               	sub	x1, x2, #0x1
               	ldrsw	x1, [x3, x1, lsl #2]
               	add	x1, x1, x5, lsr #2
               	add	x0, x0, x1
               	mov	sp, x6
               	add	x2, x2, #0x1
               	cmp	w2, #0x4
               	b.le	<addr>
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	mov	x20, x0
               	cbnz	w20, <addr>
               	mov	x0, #0x28               // =40
               	bl	<addr>
               	mov	x17, #0xa               // =10
               	mul	x20, x0, x17
               	cbnz	w20, <addr>
               	bl	<addr>
               	cmp	w0, #0x10
               	b.eq	<addr>
               	mov	x20, #0x64              // =100
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
