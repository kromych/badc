
stmt_expr_scope_exit_value.aarch64:	file format elf64-littleaarch64

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
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret

<vla_and_guard>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x5                // =5
               	mov	x2, sp
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
               	str	w0, [x1]
               	adrp	x1, <page>
               	ldrsw	x3, [x1, #0x20]
               	add	x3, x3, #0x1
               	str	w3, [x1, #0x20]
               	adrp	x1, <page>
               	str	w0, [x1, #0x24]
               	mov	sp, x2
               	mov	x0, #0x7                // =7
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	mov	x1, #0x1                // =1
               	str	w1, [x0, #0x20]
               	adrp	x1, <page>
               	mov	x2, #-0x1               // =-1
               	str	w2, [x1, #0x24]
               	ldrsw	x2, [x0, #0x20]
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x2, x2, #0x1
               	str	w2, [x0, #0x20]
               	str	wzr, [x1, #0x24]
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	mov	x2, #0x1                // =1
               	mov	x3, #0x2                // =2
               	mov	x1, #0x1                // =1
               	str	w1, [x0, #0x20]
               	adrp	x1, <page>
               	str	w3, [x1, #0x24]
               	ldrsw	x3, [x0, #0x20]
               	add	x3, x3, #0x1
               	str	w3, [x0, #0x20]
               	str	w2, [x1, #0x24]
               	ldrsw	x2, [x0, #0x20]
               	cmp	w2, #0x2
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0xb                // =11
               	mov	x3, #0x1                // =1
               	str	w3, [x0, #0x20]
               	str	w2, [x1, #0x24]
               	ldrsw	x2, [x0, #0x20]
               	cmp	w2, #0x1
               	b.ne	<addr>
               	mov	x2, #0x1                // =1
               	str	w2, [x0, #0x20]
               	str	wzr, [x1, #0x24]
               	ldrsw	x2, [x0, #0x20]
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x4                // =4
               	mov	x3, #0x1                // =1
               	str	w3, [x0, #0x20]
               	str	w2, [x1, #0x24]
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	adrp	x1, <page>
               	str	wzr, [x1, #0x24]
               	ldrsw	x0, [x0, #0x20]
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp], #0x10
               	ret
