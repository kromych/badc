
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

<vendor_is_nonempty>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	mov	x0, #0xa5a5             // =42405
               	movk	x0, #0xa5a5, lsl #16
               	stur	w0, [x29, #-0x8]
               	stur	w0, [x29, #-0x10]
               	stur	w0, [x29, #-0x18]
               	stur	w0, [x29, #-0x20]
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x8
               	sub	x2, x29, #0x10
               	sub	x3, x29, #0x18
               	sub	x4, x29, #0x20
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
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
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	ldur	w0, [x29, #-0x10]
               	ldur	w1, [x29, #-0x18]
               	orr	x0, x0, x1
               	ldur	w1, [x29, #-0x20]
               	orr	x0, x0, x1
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret

<rejects_implausible_leaf>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	mov	x0, #0xa5a5             // =42405
               	movk	x0, #0xa5a5, lsl #16
               	stur	w0, [x29, #-0x8]
               	stur	w0, [x29, #-0x10]
               	stur	w0, [x29, #-0x18]
               	stur	w0, [x29, #-0x20]
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0x7fff, lsl #16
               	sub	x1, x29, #0x8
               	sub	x2, x29, #0x10
               	sub	x3, x29, #0x18
               	sub	x4, x29, #0x20
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
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
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>

<rejects_implausible_extended_leaf>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	mov	x0, #0xa5a5             // =42405
               	movk	x0, #0xa5a5, lsl #16
               	stur	w0, [x29, #-0x8]
               	stur	w0, [x29, #-0x10]
               	stur	w0, [x29, #-0x18]
               	stur	w0, [x29, #-0x20]
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	sub	x1, x29, #0x8
               	sub	x2, x29, #0x10
               	sub	x3, x29, #0x18
               	sub	x4, x29, #0x20
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
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
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>

<count_form_agrees>:
               	stp	x20, x21, [sp, #-0xb0]!
               	stp	x29, x30, [sp, #0xa0]
               	add	x29, sp, #0xa0
               	mov	x0, #0xa5a5             // =42405
               	movk	x0, #0xa5a5, lsl #16
               	stur	w0, [x29, #-0x8]
               	stur	w0, [x29, #-0x10]
               	stur	w0, [x29, #-0x18]
               	stur	w0, [x29, #-0x20]
               	stur	w0, [x29, #-0x28]
               	stur	w0, [x29, #-0x30]
               	stur	w0, [x29, #-0x38]
               	stur	w0, [x29, #-0x40]
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0x7fff, lsl #16
               	mov	x1, #0x0                // =0
               	sub	x2, x29, #0x8
               	sub	x3, x29, #0x10
               	sub	x4, x29, #0x18
               	sub	x5, x29, #0x20
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0xa0]
               	ldp	x20, x21, [sp], #0xb0
               	ret
               	ldur	w0, [x29, #-0x8]
               	mov	x17, #0xa5a5            // =42405
               	movk	x17, #0xa5a5, lsl #16
               	cmp	x0, x17
               	cset	x0, ne
               	mov	x1, #0x1                // =1
               	cbnz	x0, <addr>
               	ldur	w0, [x29, #-0x10]
               	mov	x17, #0xa5a5            // =42405
               	movk	x17, #0xa5a5, lsl #16
               	cmp	x0, x17
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	ldur	w0, [x29, #-0x18]
               	mov	x17, #0xa5a5            // =42405
               	movk	x17, #0xa5a5, lsl #16
               	cmp	x0, x17
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldur	w0, [x29, #-0x20]
               	mov	x17, #0xa5a5            // =42405
               	movk	x17, #0xa5a5, lsl #16
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0xa0]
               	ldp	x20, x21, [sp], #0xb0
               	ret
               	mov	x20, #0x7               // =7
               	mov	x1, #0x0                // =0
               	sub	x2, x29, #0x28
               	sub	x3, x29, #0x30
               	sub	x4, x29, #0x38
               	sub	x5, x29, #0x40
               	mov	x0, x20
               	bl	<addr>
               	mov	x21, x0
               	sub	x1, x29, #0x28
               	sub	x2, x29, #0x30
               	sub	x3, x29, #0x38
               	sub	x4, x29, #0x40
               	mov	x0, x20
               	bl	<addr>
               	cmp	x21, x0
               	cset	x0, eq
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0xa0]
               	ldp	x20, x21, [sp], #0xb0
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
