
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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
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
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<vla_and_guard>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldursw	x2, [x29, #-0x10]
               	str	w2, [x0]
               	mov	sp, x1
               	mov	x0, #0x7                // =7
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	wzr, [x0]
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x3, #-0x1               // =-1
               	str	w3, [x1]
               	ldrsw	x3, [x0]
               	cmp	w3, #0x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x3, [x1]
               	mov	x17, #-0x1              // =-1
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x3, [x0]
               	add	x3, x3, #0x1
               	str	w3, [x0]
               	str	wzr, [x1]
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	wzr, [x0]
               	mov	x2, #0x1                // =1
               	stur	w2, [x29, #-0x10]
               	mov	x2, #0x2                // =2
               	stur	w2, [x29, #-0x8]
               	sub	x3, x29, #0x8
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x4, [x3]
               	str	w4, [x2]
               	ldrsw	x4, [x0]
               	add	x4, x4, #0x1
               	str	w4, [x0]
               	ldursw	x4, [x29, #-0x10]
               	str	w4, [x2]
               	ldrsw	x4, [x0]
               	cmp	w4, #0x2
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	wzr, [x0]
               	mov	x4, #0xb                // =11
               	stur	w4, [x29, #-0x8]
               	ldrsw	x4, [x0]
               	add	x4, x4, #0x1
               	str	w4, [x0]
               	ldrsw	x4, [x3]
               	str	w4, [x2]
               	ldrsw	x4, [x0]
               	cmp	w4, #0x1
               	b.ne	<addr>
               	ldrsw	x4, [x2]
               	cmp	w4, #0xb
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	wzr, [x0]
               	stur	wzr, [x29, #-0x8]
               	ldrsw	x4, [x0]
               	add	x4, x4, #0x1
               	str	w4, [x0]
               	ldrsw	x4, [x3]
               	str	w4, [x2]
               	ldrsw	x2, [x0]
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	wzr, [x0]
               	stur	wzr, [x29, #-0x10]
               	mov	x0, #0x4                // =4
               	stur	w0, [x29, #-0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x3]
               	str	w2, [x1]
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	ldursw	x2, [x29, #-0x10]
               	str	w2, [x1]
               	ldrsw	x0, [x0]
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
