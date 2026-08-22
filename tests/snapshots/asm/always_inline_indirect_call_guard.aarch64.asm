
always_inline_indirect_call_guard.aarch64:	file format elf64-littleaarch64

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

<read_at>:
               	mov	w0, w0
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	str	x0, [x1]
               	mov	x0, #0x0                // =0
               	ret

<write_at>:
               	ldr	x2, [x1]
               	mov	w0, w0
               	add	x0, x2, x0
               	str	x0, [x1]
               	mov	x0, #0x1                // =1
               	ret

<by_computed_goto>:
               	str	x2, [sp, #-0x10]!
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	w0, [x29, #0x10]
               	stur	x1, [x29, #0x20]
               	stur	x2, [x29, #0x30]
               	mov	x1, #0x0                // =0
               	stur	w1, [x29, #-0x10]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sxtw	x0, w0
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x2, x0, x17
               	asr	x2, x2, #32
               	lsr	x3, x2, #63
               	add	x2, x2, x3
               	mov	x17, #0x3               // =3
               	mul	x2, x2, x17
               	sub	x0, x0, x2
               	ldr	x0, [x1, x0, lsl #3]
               	br	x0
               	ldur	w0, [x29, #0x20]
               	ldur	x1, [x29, #0x30]
               	b	<addr>
               	stur	w0, [x29, #-0x10]
               	ldursw	x0, [x29, #-0x10]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x30
               	ret
               	ldur	w1, [x29, #0x20]
               	ldur	x0, [x29, #0x30]
               	b	<addr>
               	mov	x0, #0x4                // =4
               	stur	w0, [x29, #-0x10]
               	b	<addr>
               	ldur	w0, [x29, #0x20]
               	add	x0, x0, #0x1
               	mov	w0, w0
               	ldur	x1, [x29, #0x30]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x10]
               	b	<addr>
               	mov	x2, #0x0                // =0
               	mov	w0, w0
               	mov	w0, w0
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	str	x0, [x1]
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x2, #0x0                // =0
               	mov	w1, w1
               	ldr	x2, [x0]
               	mov	w1, w1
               	add	x1, x2, x1
               	str	x1, [x0]
               	mov	x0, #0x0                // =0
               	mov	x0, #0x2                // =2
               	b	<addr>
               	mov	x2, #0x0                // =0
               	mov	w0, w0
               	mov	w0, w0
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	str	x0, [x1]
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	b	<addr>

<main>:
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x8]
               	sub	x20, x29, #0x8
               	mov	x0, #0x0                // =0
               	mov	x0, #0x5                // =5
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x1, #0x1                // =1
               	cbz	x1, <addr>
               	mov	x1, #0x0                // =0
               	str	x1, [x20]
               	sxtw	x1, w0
               	cmp	x1, #0x0
               	cset	x0, ne
               	cbnz	x1, <addr>
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0xf
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x8]
               	sub	x20, x29, #0x8
               	mov	x0, #0x0                // =0
               	mov	x0, #0x5                // =5
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x1, #0x1                // =1
               	cbz	x1, <addr>
               	mov	x1, #0x0                // =0
               	str	x1, [x20]
               	sxtw	x1, w0
               	cmp	x1, #0x0
               	cset	x0, ne
               	cbnz	x1, <addr>
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0xf
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x4                // =4
               	stur	x0, [x29, #-0x8]
               	sub	x1, x29, #0x8
               	mov	x0, #0x0                // =0
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x1, #0x0                // =0
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	sxtw	x0, w0
               	cmp	x0, #0x2
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x9
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x8]
               	sub	x20, x29, #0x8
               	mov	x0, #0x0                // =0
               	mov	x0, #0x6                // =6
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x1, #0x1                // =1
               	cbz	x1, <addr>
               	mov	x1, #0x0                // =0
               	str	x1, [x20]
               	sxtw	x1, w0
               	cmp	x1, #0x0
               	cset	x0, ne
               	cbnz	x1, <addr>
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x12
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x8]
               	mov	x1, #0x2                // =2
               	sub	x2, x29, #0x8
               	bl	<addr>
               	mov	x1, x0
               	cmp	x1, #0x0
               	cset	x0, ne
               	cbnz	x1, <addr>
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x6
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0x8]
               	mov	x1, #0x2                // =2
               	sub	x2, x29, #0x8
               	bl	<addr>
               	cmp	x0, #0x4
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x3
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x8]
               	mov	x0, #0x2                // =2
               	sub	x2, x29, #0x8
               	mov	x1, x0
               	bl	<addr>
               	mov	x1, x0
               	cmp	x1, #0x0
               	cset	x0, ne
               	cbnz	x1, <addr>
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x9
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x8]
               	sub	x20, x29, #0x8
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x1, #0x1                // =1
               	cbz	x1, <addr>
               	mov	x1, #0x0                // =0
               	str	x1, [x20]
               	sxtw	x0, w0
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	add	x20, x0, #0x0
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x8]
               	mov	x1, #0x0                // =0
               	sub	x2, x29, #0x8
               	bl	<addr>
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	add	x20, x20, x0
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0x8]
               	sub	x1, x29, #0x8
               	mov	x0, #0x0                // =0
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x1, #0x0                // =0
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	sxtw	x0, w0
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	add	x20, x20, x0
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0x8]
               	mov	x1, #0x1                // =1
               	sub	x2, x29, #0x8
               	bl	<addr>
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	add	x0, x20, x0
               	mov	x1, #0x2                // =2
               	stur	x1, [x29, #-0x8]
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	ldur	x1, [x29, #-0x8]
               	sub	x1, x1, #0x1
               	add	x20, x0, x1
               	mov	x0, #0x2                // =2
               	stur	x0, [x29, #-0x8]
               	mov	x1, #0x2                // =2
               	sub	x2, x29, #0x8
               	bl	<addr>
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	add	x0, x20, x0
               	mov	x1, #0x3                // =3
               	stur	x1, [x29, #-0x8]
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	ldur	x1, [x29, #-0x8]
               	sub	x1, x1, #0x1
               	add	x20, x0, x1
               	mov	x0, #0x3                // =3
               	stur	x0, [x29, #-0x8]
               	mov	x1, #0x3                // =3
               	sub	x2, x29, #0x8
               	bl	<addr>
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	add	x21, x20, x0
               	mov	x0, #0x4                // =4
               	stur	x0, [x29, #-0x8]
               	sub	x20, x29, #0x8
               	mov	x0, #0x0                // =0
               	mov	x0, #0x5                // =5
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x1, #0x1                // =1
               	cbz	x1, <addr>
               	mov	x1, #0x0                // =0
               	str	x1, [x20]
               	sxtw	x0, w0
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	add	x20, x21, x0
               	mov	x0, #0x4                // =4
               	stur	x0, [x29, #-0x8]
               	mov	x1, #0x4                // =4
               	sub	x2, x29, #0x8
               	bl	<addr>
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	add	x0, x20, x0
               	mov	x1, #0x5                // =5
               	stur	x1, [x29, #-0x8]
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	ldur	x1, [x29, #-0x8]
               	sub	x1, x1, #0x1
               	add	x20, x0, x1
               	mov	x0, #0x5                // =5
               	stur	x0, [x29, #-0x8]
               	mov	x1, #0x5                // =5
               	sub	x2, x29, #0x8
               	bl	<addr>
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	add	x0, x20, x0
               	mov	x1, #0x6                // =6
               	stur	x1, [x29, #-0x8]
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	ldur	x1, [x29, #-0x8]
               	sub	x1, x1, #0x1
               	add	x20, x0, x1
               	mov	x0, #0x6                // =6
               	stur	x0, [x29, #-0x8]
               	mov	x1, #0x6                // =6
               	sub	x2, x29, #0x8
               	bl	<addr>
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	add	x0, x20, x0
               	mov	x1, #0x7                // =7
               	stur	x1, [x29, #-0x8]
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	ldur	x1, [x29, #-0x8]
               	sub	x1, x1, #0x1
               	add	x20, x0, x1
               	mov	x0, #0x7                // =7
               	stur	x0, [x29, #-0x8]
               	mov	x1, #0x7                // =7
               	sub	x2, x29, #0x8
               	bl	<addr>
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	add	x0, x20, x0
               	mov	x1, #0x8                // =8
               	stur	x1, [x29, #-0x8]
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	ldur	x1, [x29, #-0x8]
               	sub	x1, x1, #0x1
               	add	x20, x0, x1
               	mov	x0, #0x8                // =8
               	stur	x0, [x29, #-0x8]
               	mov	x1, #0x8                // =8
               	sub	x2, x29, #0x8
               	bl	<addr>
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	add	x20, x20, x0
               	mov	x0, #0x9                // =9
               	stur	x0, [x29, #-0x8]
               	sub	x1, x29, #0x8
               	mov	x0, #0x0                // =0
               	mov	x0, #0xb                // =11
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x1, #0x0                // =0
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	sxtw	x0, w0
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	add	x20, x20, x0
               	mov	x0, #0x9                // =9
               	stur	x0, [x29, #-0x8]
               	mov	x1, #0x9                // =9
               	sub	x2, x29, #0x8
               	bl	<addr>
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	add	x0, x20, x0
               	mov	x1, #0xa                // =10
               	stur	x1, [x29, #-0x8]
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	ldur	x1, [x29, #-0x8]
               	sub	x1, x1, #0x1
               	add	x20, x0, x1
               	mov	x0, #0xa                // =10
               	stur	x0, [x29, #-0x8]
               	mov	x1, #0xa                // =10
               	sub	x2, x29, #0x8
               	bl	<addr>
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	add	x0, x20, x0
               	mov	x1, #0xb                // =11
               	stur	x1, [x29, #-0x8]
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	ldur	x1, [x29, #-0x8]
               	sub	x1, x1, #0x1
               	add	x20, x0, x1
               	mov	x0, #0xb                // =11
               	stur	x0, [x29, #-0x8]
               	mov	x1, #0xb                // =11
               	sub	x2, x29, #0x8
               	bl	<addr>
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	add	x0, x20, x0
               	cmp	x0, #0x131
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
