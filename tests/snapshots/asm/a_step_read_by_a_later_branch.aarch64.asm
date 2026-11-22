
a_step_read_by_a_later_branch.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<separators>:
               	mov	x1, x0
               	add	x0, x1, #0x2
               	mov	x2, #0xaaab             // =43691
               	movk	x2, #0xaaaa, lsl #16
               	movk	x2, #0xaaaa, lsl #32
               	movk	x2, #0xaaaa, lsl #48
               	umulh	x2, x0, x2
               	lsr	x2, x2, #1
               	add	x2, x2, x2, lsl #1
               	sub	x2, x0, x2
               	mov	x0, #0x0                // =0
               	subs	x1, x1, #0x1
               	b.lo	<addr>
               	sub	x3, x2, #0x1
               	cbnz	x2, <addr>
               	b.eq	<addr>
               	add	x0, x0, #0x1
               	mov	x2, #0x2                // =2
               	b	<addr>
               	mov	x2, x3
               	b	<addr>
               	mov	x2, x3
               	subs	x1, x1, #0x1
               	b.hs	<addr>
               	ret

<group>:
               	mov	x2, #0x0                // =0
               	ldrb	w3, [x0, x2]
               	cmp	w3, #0x30
               	b.lt	<addr>
               	cmp	w3, #0x39
               	b.gt	<addr>
               	add	x2, x2, #0x1
               	ldrb	w3, [x0, x2]
               	cmp	w3, #0x30
               	b.ge	<addr>
               	add	x3, x2, #0x2
               	mov	x4, #0xaaab             // =43691
               	movk	x4, #0xaaaa, lsl #16
               	movk	x4, #0xaaaa, lsl #32
               	movk	x4, #0xaaaa, lsl #48
               	umulh	x4, x3, x4
               	lsr	x4, x4, #1
               	add	x4, x4, x4, lsl #1
               	sub	x3, x3, x4
               	subs	x2, x2, #0x1
               	b.lo	<addr>
               	add	x1, x1, #0x1
               	ldrb	w4, [x0], #0x1
               	sturb	w4, [x1, #-0x1]
               	sub	x4, x3, #0x1
               	cbnz	x3, <addr>
               	b.eq	<addr>
               	add	x1, x1, #0x1
               	mov	x3, #0x2c               // =44
               	sturb	w3, [x1, #-0x1]
               	mov	x3, #0x2                // =2
               	b	<addr>
               	mov	x3, x4
               	b	<addr>
               	mov	x3, x4
               	subs	x2, x2, #0x1
               	b.hs	<addr>
               	add	x1, x1, #0x1
               	ldrb	w2, [x0], #0x1
               	sturb	w2, [x1, #-0x1]
               	cbnz	x2, <addr>
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x0                // =0
               	add	x0, x0, #0x1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	b	<addr>
               	mov	x0, #0x6                // =6
               	bl	<addr>
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	b	<addr>
               	mov	x0, #0x7                // =7
               	bl	<addr>
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	b	<addr>
               	mov	x0, #0x8                // =8
               	bl	<addr>
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	b	<addr>
               	mov	x0, #0x9                // =9
               	bl	<addr>
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	b	<addr>
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x20
               	bl	<addr>
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w3, [x1]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w2, [x0]
               	cbnz	x2, <addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x20
               	bl	<addr>
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w3, [x1]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w2, [x0]
               	cbnz	x2, <addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x20
               	bl	<addr>
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w3, [x1]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w2, [x0]
               	cbnz	x2, <addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
