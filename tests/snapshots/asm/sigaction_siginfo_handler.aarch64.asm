
sigaction_siginfo_handler.aarch64:	file format elf64-littleaarch64

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

<on_usr1>:
               	sxtw	x0, w0
               	ldr	x3, [x2, #0x1b0]
               	adrp	x2, <page>
               	ldrsw	x4, [x2, #0x20]
               	add	x4, x4, #0x1
               	str	w4, [x2, #0x20]
               	adrp	x2, <page>
               	mov	x4, #-0x1               // =-1
               	ldrsw	x1, [x1]
               	cmp	w1, w0
               	csel	x0, x0, x4, eq
               	str	w0, [x2, #0x24]
               	adrp	x0, <page>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	sub	x1, x1, x3
               	mov	x17, #0x100000          // =1048576
               	cmp	x1, x17
               	cset	x1, lo
               	str	w1, [x0, #0x28]
               	ret

<check>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x130
               	sub	x1, x29, #0x130
               	str	xzr, [sp]
               	str	xzr, [sp, #0x8]
               	str	xzr, [sp, #0x10]
               	str	xzr, [sp, #0x18]
               	str	xzr, [sp, #0x20]
               	str	xzr, [sp, #0x28]
               	stur	xzr, [x29, #-0x100]
               	stur	xzr, [x29, #-0xf8]
               	stur	xzr, [x29, #-0xf0]
               	stur	xzr, [x29, #-0xe8]
               	stur	xzr, [x29, #-0xe0]
               	stur	xzr, [x29, #-0xd8]
               	stur	xzr, [x29, #-0xd0]
               	stur	xzr, [x29, #-0xc8]
               	stur	xzr, [x29, #-0xc0]
               	stur	xzr, [x29, #-0xb8]
               	stur	xzr, [x29, #-0xb0]
               	stur	xzr, [x29, #-0xa8]
               	stur	xzr, [x29, #-0xa0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x0, [sp]
               	mov	x0, #0x4                // =4
               	stur	w0, [x29, #-0xa8]
               	add	x0, x1, #0x8
               	bl	<addr>
               	mov	x0, #0xa                // =10
               	sub	x1, x29, #0x130
               	mov	x2, #0x0                // =0
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x98
               	mov	x1, #0x0                // =0
               	stur	x1, [x29, #-0x98]
               	stur	x1, [x29, #-0x90]
               	stur	x1, [x29, #-0x88]
               	stur	x1, [x29, #-0x80]
               	stur	x1, [x29, #-0x78]
               	stur	x1, [x29, #-0x70]
               	stur	x1, [x29, #-0x68]
               	stur	x1, [x29, #-0x60]
               	stur	x1, [x29, #-0x58]
               	stur	x1, [x29, #-0x50]
               	stur	x1, [x29, #-0x48]
               	stur	x1, [x29, #-0x40]
               	stur	x1, [x29, #-0x38]
               	stur	x1, [x29, #-0x30]
               	stur	x1, [x29, #-0x28]
               	stur	x1, [x29, #-0x20]
               	stur	x1, [x29, #-0x18]
               	stur	x1, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x98]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cmp	x0, x1
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x10]
               	tbnz	w0, #0x2, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x20]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x24]
               	cmp	w0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x28]
               	mov	x1, #0x0                // =0
               	mov	x2, #0x6                // =6
               	cmp	x0, #0x0
               	csel	x0, x1, x2, ne
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	adrp	x0, <page>
               	sub	x1, x29, #0x8
               	str	x1, [x0, #0x30]
               	bl	<addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
