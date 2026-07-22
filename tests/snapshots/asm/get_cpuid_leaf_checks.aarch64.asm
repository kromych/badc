
get_cpuid_leaf_checks.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x0, #0x1                // =1
               	mov	x0, #0x0                // =0
               	ret

<__get_cpuid_count>:
               	mov	x0, #0x1                // =1
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x210
               	mov	x0, #0xa5a5             // =42405
               	movk	x0, #0xa5a5, lsl #16
               	stur	w0, [x29, #-0x8]
               	stur	w0, [x29, #-0x10]
               	stur	w0, [x29, #-0x18]
               	stur	w0, [x29, #-0x20]
               	sub	x0, x29, #0x8
               	sub	x0, x29, #0x10
               	sub	x0, x29, #0x18
               	sub	x0, x29, #0x20
               	mov	x0, #0x1                // =1
               	mov	x0, #0x0                // =0
               	ldur	w0, [x29, #-0x8]
               	mov	x17, #0xa5a5            // =42405
               	movk	x17, #0xa5a5, lsl #16
               	cmp	x0, x17
               	cset	x1, eq
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	ldur	w0, [x29, #-0x10]
               	mov	x17, #0xa5a5            // =42405
               	movk	x17, #0xa5a5, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	ldur	w0, [x29, #-0x18]
               	mov	x17, #0xa5a5            // =42405
               	movk	x17, #0xa5a5, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	ldur	w0, [x29, #-0x20]
               	mov	x17, #0xa5a5            // =42405
               	movk	x17, #0xa5a5, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa5a5             // =42405
               	movk	x0, #0xa5a5, lsl #16
               	stur	w0, [x29, #-0x68]
               	stur	w0, [x29, #-0x70]
               	stur	w0, [x29, #-0x78]
               	stur	w0, [x29, #-0x80]
               	sub	x0, x29, #0x68
               	sub	x0, x29, #0x70
               	sub	x0, x29, #0x78
               	sub	x0, x29, #0x80
               	mov	x0, #0x1                // =1
               	mov	x0, #0x0                // =0
               	ldur	w0, [x29, #-0x68]
               	mov	x17, #0xa5a5            // =42405
               	movk	x17, #0xa5a5, lsl #16
               	cmp	x0, x17
               	cset	x1, eq
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	ldur	w0, [x29, #-0x70]
               	mov	x17, #0xa5a5            // =42405
               	movk	x17, #0xa5a5, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	ldur	w0, [x29, #-0x78]
               	mov	x17, #0xa5a5            // =42405
               	movk	x17, #0xa5a5, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	ldur	w0, [x29, #-0x80]
               	mov	x17, #0xa5a5            // =42405
               	movk	x17, #0xa5a5, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa5a5             // =42405
               	movk	x0, #0xa5a5, lsl #16
               	stur	w0, [x29, #-0xc8]
               	stur	w0, [x29, #-0xd0]
               	stur	w0, [x29, #-0xd8]
               	stur	w0, [x29, #-0xe0]
               	sub	x0, x29, #0xc8
               	sub	x0, x29, #0xd0
               	sub	x0, x29, #0xd8
               	sub	x0, x29, #0xe0
               	mov	x0, #0x1                // =1
               	mov	x0, #0x0                // =0
               	ldur	w0, [x29, #-0xc8]
               	mov	x17, #0xa5a5            // =42405
               	movk	x17, #0xa5a5, lsl #16
               	cmp	x0, x17
               	cset	x1, eq
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	ldur	w0, [x29, #-0xd0]
               	mov	x17, #0xa5a5            // =42405
               	movk	x17, #0xa5a5, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	ldur	w0, [x29, #-0xd8]
               	mov	x17, #0xa5a5            // =42405
               	movk	x17, #0xa5a5, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	ldur	w0, [x29, #-0xe0]
               	mov	x17, #0xa5a5            // =42405
               	movk	x17, #0xa5a5, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa5a5             // =42405
               	movk	x0, #0xa5a5, lsl #16
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
               	sub	x0, x29, #0x128
               	sub	x0, x29, #0x130
               	sub	x0, x29, #0x138
               	sub	x0, x29, #0x140
               	mov	x0, #0x1                // =1
               	mov	x0, #0x0                // =0
               	sub	x16, x29, #0x128
               	ldr	w0, [x16]
               	mov	x17, #0xa5a5            // =42405
               	movk	x17, #0xa5a5, lsl #16
               	cmp	x0, x17
               	cset	x0, ne
               	mov	x1, #0x1                // =1
               	cbnz	x0, <addr>
               	sub	x16, x29, #0x130
               	ldr	w0, [x16]
               	mov	x17, #0xa5a5            // =42405
               	movk	x17, #0xa5a5, lsl #16
               	cmp	x0, x17
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x16, x29, #0x138
               	ldr	w0, [x16]
               	mov	x17, #0xa5a5            // =42405
               	movk	x17, #0xa5a5, lsl #16
               	cmp	x0, x17
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x16, x29, #0x140
               	ldr	w0, [x16]
               	mov	x17, #0xa5a5            // =42405
               	movk	x17, #0xa5a5, lsl #16
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x148
               	sub	x0, x29, #0x150
               	sub	x0, x29, #0x158
               	sub	x0, x29, #0x160
               	mov	x0, #0x1                // =1
               	mov	x0, #0x0                // =0
               	sub	x0, x29, #0x148
               	sub	x0, x29, #0x150
               	sub	x0, x29, #0x158
               	sub	x0, x29, #0x160
               	mov	x0, #0x1                // =1
               	mov	x0, #0x0                // =0
               	mov	x0, #0x1                // =1
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
