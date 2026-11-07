
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
               	ldr	x3, [x2, #0x1b0]
               	adrp	x2, <page>
               	ldrsw	x4, [x2, #0x30]
               	add	x4, x4, #0x1
               	str	w4, [x2, #0x30]
               	adrp	x2, <page>
               	ldrsw	x1, [x1]
               	cmp	w1, w0
               	b.ne	<addr>
               	str	w0, [x2, #0x38]
               	adrp	x0, <page>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	sub	x1, x1, x3
               	mov	x17, #0x100000          // =1048576
               	cmp	x1, x17
               	cset	x1, lo
               	str	w1, [x0, #0x40]
               	ret
               	mov	x0, #-0x1               // =-1
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x140
               	adrp	x0, <page>
               	sub	x1, x29, #0x138
               	str	x1, [x0, #0x48]
               	sub	x0, x29, #0x130
               	mov	x1, #0x0                // =0
               	mov	x2, #0x98               // =152
               	bl	<addr>
               	sub	x0, x29, #0x130
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x1, [sp, #0x10]
               	mov	x1, #0x4                // =4
               	stur	w1, [x29, #-0xa8]
               	add	x0, x0, #0x8
               	bl	<addr>
               	mov	x0, #0xa                // =10
               	sub	x1, x29, #0x130
               	mov	x2, #0x0                // =0
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x98
               	mov	x1, #0x0                // =0
               	mov	x2, #0x98               // =152
               	bl	<addr>
               	mov	x0, #0xa                // =10
               	mov	x1, #0x0                // =0
               	sub	x2, x29, #0x98
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	ldur	x0, [x29, #-0x98]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cmp	x0, x1
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x10]
               	tbnz	w0, #0x2, <addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x30]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x38]
               	cmp	w0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	b	<addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x40]
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x6                // =6
               	b	<addr>
