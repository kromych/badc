
stmt_expr_scope_exit_value.aarch64:	file format elf64-littleaarch64

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

<vla_value>:
               	str	x19, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x1, sp
               	mov	x0, #0x10               // =16
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
               	mov	x2, #0x29               // =41
               	str	w2, [x0]
               	mov	x2, #0x1                // =1
               	str	w2, [x0, #0xc]
               	mov	sp, x1
               	mov	x0, #0x2a               // =42
               	sub	sp, x29, #0x20
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp], #0x30
               	ret

<vla_and_guard>:
               	str	x19, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x1, sp
               	mov	x0, #0x5                // =5
               	stur	w0, [x29, #-0x10]
               	mov	x2, #0xc                // =12
               	add	x17, x2, #0xf
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
               	str	w0, [x2]
               	sub	x2, x29, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x3, [x0]
               	add	x3, x3, #0x1
               	str	w3, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x2]
               	str	w2, [x0]
               	mov	sp, x1
               	mov	x0, #0x7                // =7
               	sub	sp, x29, #0x30
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp], #0x40
               	ret

<main>:
               	str	x20, [sp, #-0x50]!
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x20]
               	mov	x1, #0x7                // =7
               	ldrsw	x1, [x20]
               	add	x1, x1, #0x1
               	str	w1, [x20]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0xffff             // =65535
               	movk	x2, #0xffff, lsl #16
               	movk	x2, #0xffff, lsl #32
               	movk	x2, #0xffff, lsl #48
               	str	w2, [x1]
               	ldrsw	x1, [x20]
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	ldrsw	x1, [x20]
               	add	x1, x1, #0x1
               	str	w1, [x20]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	w0, [x1]
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	mov	x0, #0x0                // =0
               	str	w0, [x20]
               	mov	x1, #0x1                // =1
               	stur	w1, [x29, #-0x28]
               	mov	x1, #0x2                // =2
               	stur	w1, [x29, #-0x18]
               	sub	x1, x29, #0x18
               	ldrsw	x2, [x20]
               	add	x2, x2, #0x1
               	str	w2, [x20]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x3, [x1]
               	str	w3, [x2]
               	sub	x3, x29, #0x28
               	ldrsw	x2, [x20]
               	add	x2, x2, #0x1
               	str	w2, [x20]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x4, [x3]
               	str	w4, [x2]
               	ldrsw	x2, [x20]
               	cmp	w2, #0x2
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	str	w0, [x20]
               	mov	x2, #0xb                // =11
               	stur	w2, [x29, #-0x18]
               	ldrsw	x2, [x20]
               	add	x2, x2, #0x1
               	str	w2, [x20]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x4, [x1]
               	str	w4, [x2]
               	ldrsw	x2, [x20]
               	cmp	w2, #0x1
               	cset	x2, ne
               	cbnz	x2, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x2, [x2]
               	cmp	w2, #0xb
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	str	w0, [x20]
               	stur	w0, [x29, #-0x18]
               	mov	x2, x0
               	ldrsw	x2, [x20]
               	add	x2, x2, #0x1
               	str	w2, [x20]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x4, [x1]
               	str	w4, [x2]
               	ldrsw	x2, [x20]
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	str	w0, [x20]
               	stur	w0, [x29, #-0x28]
               	mov	x2, #0x4                // =4
               	stur	w2, [x29, #-0x18]
               	ldrsw	x2, [x20]
               	add	x2, x2, #0x1
               	str	w2, [x20]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x1, [x1]
               	str	w1, [x2]
               	ldrsw	x1, [x20]
               	add	x1, x1, #0x1
               	str	w1, [x20]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x3]
               	str	w2, [x1]
               	ldrsw	x1, [x20]
               	cmp	w1, #0x2
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	b	<addr>
