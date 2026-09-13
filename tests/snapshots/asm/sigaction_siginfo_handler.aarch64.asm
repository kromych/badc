
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
               	mov	x3, x1
               	sxtw	x0, w0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x1, [x2]
               	add	x1, x1, #0x1
               	str	w1, [x2]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x3]
               	cmp	w2, w0
               	b.ne	<addr>
               	str	w0, [x1]
               	ret
               	mov	x0, #-0x1               // =-1
               	b	<addr>

<check>:
               	stp	x20, x21, [sp, #-0x160]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x150]
               	add	x29, sp, #0x150
               	sub	x0, x29, #0x130
               	mov	x20, #0x0               // =0
               	mov	x2, #0x98               // =152
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x130
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	str	x21, [x0]
               	mov	x1, #0x4                // =4
               	str	w1, [x0, #0x88]
               	add	x0, x0, #0x8
               	bl	<addr>
               	mov	x0, #0xa                // =10
               	sub	x1, x29, #0x130
               	mov	x2, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x150]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x160
               	ret
               	sub	x0, x29, #0x98
               	mov	x20, #0x0               // =0
               	mov	x2, #0x98               // =152
               	mov	x1, x20
               	bl	<addr>
               	mov	x0, #0xa                // =10
               	sub	x2, x29, #0x98
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x150]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x160
               	ret
               	sub	x0, x29, #0x98
               	ldr	x1, [x0]
               	cmp	x1, x21
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0x88]
               	and	x0, x0, #0x4
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x150]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x160
               	ret
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x150]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x160
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0xa
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x150]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x160
               	ret
               	mov	x0, #0x5                // =5
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
