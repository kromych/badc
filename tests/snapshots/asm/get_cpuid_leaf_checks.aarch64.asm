
get_cpuid_leaf_checks.aarch64:	file format elf64-littleaarch64

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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x1c0
               	mov	x1, #0xa5a5             // =42405
               	movk	x1, #0xa5a5, lsl #16
               	stur	w1, [x29, #-0x8]
               	stur	w1, [x29, #-0x10]
               	stur	w1, [x29, #-0x18]
               	stur	w1, [x29, #-0x20]
               	mov	x3, #0x1                // =1
               	mov	x0, x3
               	ldur	w0, [x29, #-0x8]
               	mov	x17, #0xa5a5            // =42405
               	movk	x17, #0xa5a5, lsl #16
               	cmp	x0, x17
               	mov	x0, #0x0                // =0
               	b.ne	<addr>
               	ldur	w2, [x29, #-0x10]
               	mov	x17, #0xa5a5            // =42405
               	movk	x17, #0xa5a5, lsl #16
               	cmp	x2, x17
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldur	w2, [x29, #-0x18]
               	mov	x17, #0xa5a5            // =42405
               	movk	x17, #0xa5a5, lsl #16
               	cmp	x2, x17
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldur	w2, [x29, #-0x20]
               	mov	x17, #0xa5a5            // =42405
               	movk	x17, #0xa5a5, lsl #16
               	cmp	x2, x17
               	cset	x2, eq
               	sxtw	x2, w2
               	cbnz	x2, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	w1, [x29, #-0x68]
               	stur	w1, [x29, #-0x70]
               	stur	w1, [x29, #-0x78]
               	stur	w1, [x29, #-0x80]
               	ldur	w1, [x29, #-0x68]
               	mov	x17, #0xa5a5            // =42405
               	movk	x17, #0xa5a5, lsl #16
               	cmp	x1, x17
               	b.ne	<addr>
               	ldur	w1, [x29, #-0x70]
               	mov	x17, #0xa5a5            // =42405
               	movk	x17, #0xa5a5, lsl #16
               	cmp	x1, x17
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldur	w1, [x29, #-0x78]
               	mov	x17, #0xa5a5            // =42405
               	movk	x17, #0xa5a5, lsl #16
               	cmp	x1, x17
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldur	w0, [x29, #-0x80]
               	mov	x17, #0xa5a5            // =42405
               	movk	x17, #0xa5a5, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa5a5             // =42405
               	movk	x0, #0xa5a5, lsl #16
               	stur	w0, [x29, #-0xc8]
               	stur	w0, [x29, #-0xd0]
               	stur	w0, [x29, #-0xd8]
               	stur	w0, [x29, #-0xe0]
               	mov	x3, #0x1                // =1
               	mov	x1, x3
               	ldur	w1, [x29, #-0xc8]
               	mov	x17, #0xa5a5            // =42405
               	movk	x17, #0xa5a5, lsl #16
               	cmp	x1, x17
               	mov	x1, #0x0                // =0
               	b.ne	<addr>
               	ldur	w2, [x29, #-0xd0]
               	mov	x17, #0xa5a5            // =42405
               	movk	x17, #0xa5a5, lsl #16
               	cmp	x2, x17
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldur	w2, [x29, #-0xd8]
               	mov	x17, #0xa5a5            // =42405
               	movk	x17, #0xa5a5, lsl #16
               	cmp	x2, x17
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldur	w1, [x29, #-0xe0]
               	mov	x17, #0xa5a5            // =42405
               	movk	x17, #0xa5a5, lsl #16
               	cmp	x1, x17
               	cset	x1, eq
               	sxtw	x1, w1
               	cbnz	x1, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x17, x29, #0x128
               	str	w0, [x17]
               	sub	x17, x29, #0x130
               	str	w0, [x17]
               	sub	x17, x29, #0x138
               	str	w0, [x17]
               	sub	x17, x29, #0x140
               	str	w0, [x17]
               	sub	x17, x29, #0x148
               	str	w0, [x17]
               	sub	x17, x29, #0x150
               	str	w0, [x17]
               	sub	x17, x29, #0x158
               	str	w0, [x17]
               	sub	x17, x29, #0x160
               	str	w0, [x17]
               	sub	x16, x29, #0x128
               	ldr	w0, [x16]
               	mov	x17, #0xa5a5            // =42405
               	movk	x17, #0xa5a5, lsl #16
               	cmp	x0, x17
               	mov	x0, #0x1                // =1
               	b.ne	<addr>
               	sub	x16, x29, #0x130
               	ldr	w1, [x16]
               	mov	x17, #0xa5a5            // =42405
               	movk	x17, #0xa5a5, lsl #16
               	cmp	x1, x17
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x16, x29, #0x138
               	ldr	w1, [x16]
               	mov	x17, #0xa5a5            // =42405
               	movk	x17, #0xa5a5, lsl #16
               	cmp	x1, x17
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x16, x29, #0x140
               	ldr	w1, [x16]
               	mov	x17, #0xa5a5            // =42405
               	movk	x17, #0xa5a5, lsl #16
               	cmp	x1, x17
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x0                // =0
               	cbnz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, x0
               	mov	x1, x0
               	b	<addr>
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
