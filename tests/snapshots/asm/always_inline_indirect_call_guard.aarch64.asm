
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

<by_switch>:
               	cmp	w0, #0x4
               	b.lt	<addr>
               	cmp	w0, #0x9
               	b.lt	<addr>
               	cmp	w0, #0x9
               	b.eq	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ret
               	mov	w0, w1
               	add	x0, x0, #0x2
               	mov	w1, w0
               	mov	x0, #0x0                // =0
               	mov	x3, x0
               	mov	w1, w1
               	ldr	x3, [x2]
               	mov	w1, w1
               	add	x1, x3, x1
               	str	x1, [x2]
               	mov	x0, #0x2                // =2
               	mov	x0, #0x2                // =2
               	ret
               	cmp	w0, #0x4
               	b.ne	<addr>
               	mov	w0, w1
               	add	x0, x0, #0x1
               	mov	w0, w0
               	mov	w0, w0
               	mov	w0, w0
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	str	x0, [x2]
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	ret
               	cmp	w0, #0x1
               	b.lt	<addr>
               	cmp	w0, #0x1
               	b.ne	<addr>
               	mov	w1, w1
               	mov	x0, #0x0                // =0
               	mov	x3, x0
               	mov	w1, w1
               	ldr	x3, [x2]
               	mov	w1, w1
               	add	x1, x3, x1
               	str	x1, [x2]
               	mov	x0, #0x2                // =2
               	mov	x0, #0x2                // =2
               	ret
               	mov	w0, w1
               	mov	w0, w0
               	mov	w0, w0
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	str	x0, [x2]
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	ret

<by_computed_goto>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	stur	x0, [x29, #-0x40]
               	stur	x1, [x29, #-0x30]
               	stur	x2, [x29, #-0x20]
               	mov	x3, x0
               	stur	w3, [x29, #-0x40]
               	stur	x1, [x29, #-0x30]
               	stur	x2, [x29, #-0x20]
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sxtw	x2, w3
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x2, x17
               	asr	x3, x3, #32
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x17, #0x3               // =3
               	mul	x3, x3, x17
               	sub	x2, x2, x3
               	ldr	x1, [x1, x2, lsl #3]
               	br	x1
               	ldur	w1, [x29, #-0x30]
               	ldur	x2, [x29, #-0x20]
               	b	<addr>
               	stur	w0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w2, [x29, #-0x30]
               	ldur	x1, [x29, #-0x20]
               	b	<addr>
               	mov	x0, #0x4                // =4
               	stur	w0, [x29, #-0x8]
               	b	<addr>
               	ldur	w1, [x29, #-0x30]
               	add	x1, x1, #0x1
               	mov	w1, w1
               	ldur	x2, [x29, #-0x20]
               	b	<addr>
               	stur	w0, [x29, #-0x8]
               	b	<addr>
               	mov	w1, w1
               	mov	w1, w1
               	mov	x17, #0x3               // =3
               	mul	x1, x1, x17
               	str	x1, [x2]
               	b	<addr>
               	mov	x3, x0
               	mov	w2, w2
               	ldr	x3, [x1]
               	mov	w2, w2
               	add	x2, x3, x2
               	str	x2, [x1]
               	mov	x0, #0x2                // =2
               	b	<addr>
               	mov	w1, w1
               	mov	w1, w1
               	mov	x17, #0x3               // =3
               	mul	x1, x1, x17
               	str	x1, [x2]
               	mov	x1, x0
               	b	<addr>

<main>:
               	str	x20, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x8]
               	sub	x1, x29, #0x8
               	mov	x2, #0xf                // =15
               	str	x2, [x1]
               	mov	x2, x0
               	ldur	x2, [x29, #-0x8]
               	cmp	x2, #0xf
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	stur	x0, [x29, #-0x8]
               	mov	x2, #0x5                // =5
               	mov	x16, x2
               	mov	x2, x1
               	mov	x1, x16
               	bl	<addr>
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0xf
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x4                // =4
               	stur	x0, [x29, #-0x8]
               	mov	x0, #0x1                // =1
               	mov	x1, #0x5                // =5
               	sub	x2, x29, #0x8
               	bl	<addr>
               	cmp	x0, #0x2
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x9
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x8]
               	mov	x0, #0x4                // =4
               	mov	x1, #0x5                // =5
               	sub	x2, x29, #0x8
               	bl	<addr>
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x12
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x7                // =7
               	mov	x1, #0x5                // =5
               	sub	x2, x29, #0x8
               	bl	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x8]
               	mov	x1, #0x2                // =2
               	sub	x2, x29, #0x8
               	bl	<addr>
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x6
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0x8]
               	mov	x1, #0x2                // =2
               	sub	x2, x29, #0x8
               	bl	<addr>
               	cmp	x0, #0x4
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x3
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x8]
               	mov	x0, #0x2                // =2
               	sub	x2, x29, #0x8
               	mov	x1, x0
               	bl	<addr>
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x9
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x8]
               	sub	x2, x29, #0x8
               	mov	x1, x0
               	bl	<addr>
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	add	x20, x0, #0x0
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x8]
               	sub	x2, x29, #0x8
               	mov	x1, x0
               	bl	<addr>
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	add	x20, x20, x0
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0x8]
               	sub	x2, x29, #0x8
               	mov	x1, x0
               	bl	<addr>
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	add	x20, x20, x0
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0x8]
               	sub	x2, x29, #0x8
               	mov	x1, x0
               	bl	<addr>
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	add	x20, x20, x0
               	mov	x0, #0x2                // =2
               	stur	x0, [x29, #-0x8]
               	sub	x2, x29, #0x8
               	mov	x1, x0
               	bl	<addr>
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	add	x20, x20, x0
               	mov	x0, #0x2                // =2
               	stur	x0, [x29, #-0x8]
               	sub	x2, x29, #0x8
               	mov	x1, x0
               	bl	<addr>
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	add	x20, x20, x0
               	mov	x0, #0x3                // =3
               	stur	x0, [x29, #-0x8]
               	sub	x2, x29, #0x8
               	mov	x1, x0
               	bl	<addr>
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	add	x20, x20, x0
               	mov	x0, #0x3                // =3
               	stur	x0, [x29, #-0x8]
               	sub	x2, x29, #0x8
               	mov	x1, x0
               	bl	<addr>
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	add	x20, x20, x0
               	mov	x0, #0x4                // =4
               	stur	x0, [x29, #-0x8]
               	sub	x2, x29, #0x8
               	mov	x1, x0
               	bl	<addr>
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	add	x20, x20, x0
               	mov	x0, #0x4                // =4
               	stur	x0, [x29, #-0x8]
               	sub	x2, x29, #0x8
               	mov	x1, x0
               	bl	<addr>
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	add	x20, x20, x0
               	mov	x0, #0x5                // =5
               	stur	x0, [x29, #-0x8]
               	sub	x2, x29, #0x8
               	mov	x1, x0
               	bl	<addr>
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	add	x20, x20, x0
               	mov	x0, #0x5                // =5
               	stur	x0, [x29, #-0x8]
               	sub	x2, x29, #0x8
               	mov	x1, x0
               	bl	<addr>
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	add	x20, x20, x0
               	mov	x0, #0x6                // =6
               	stur	x0, [x29, #-0x8]
               	sub	x2, x29, #0x8
               	mov	x1, x0
               	bl	<addr>
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	add	x20, x20, x0
               	mov	x0, #0x6                // =6
               	stur	x0, [x29, #-0x8]
               	sub	x2, x29, #0x8
               	mov	x1, x0
               	bl	<addr>
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	add	x20, x20, x0
               	mov	x0, #0x7                // =7
               	stur	x0, [x29, #-0x8]
               	sub	x2, x29, #0x8
               	mov	x1, x0
               	bl	<addr>
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	add	x20, x20, x0
               	mov	x0, #0x7                // =7
               	stur	x0, [x29, #-0x8]
               	sub	x2, x29, #0x8
               	mov	x1, x0
               	bl	<addr>
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	add	x20, x20, x0
               	mov	x0, #0x8                // =8
               	stur	x0, [x29, #-0x8]
               	sub	x2, x29, #0x8
               	mov	x1, x0
               	bl	<addr>
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	add	x20, x20, x0
               	mov	x0, #0x8                // =8
               	stur	x0, [x29, #-0x8]
               	sub	x2, x29, #0x8
               	mov	x1, x0
               	bl	<addr>
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	add	x20, x20, x0
               	mov	x0, #0x9                // =9
               	stur	x0, [x29, #-0x8]
               	sub	x2, x29, #0x8
               	mov	x1, x0
               	bl	<addr>
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	add	x20, x20, x0
               	mov	x0, #0x9                // =9
               	stur	x0, [x29, #-0x8]
               	sub	x2, x29, #0x8
               	mov	x1, x0
               	bl	<addr>
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	add	x20, x20, x0
               	mov	x0, #0xa                // =10
               	stur	x0, [x29, #-0x8]
               	sub	x2, x29, #0x8
               	mov	x1, x0
               	bl	<addr>
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	add	x20, x20, x0
               	mov	x0, #0xa                // =10
               	stur	x0, [x29, #-0x8]
               	sub	x2, x29, #0x8
               	mov	x1, x0
               	bl	<addr>
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	add	x20, x20, x0
               	mov	x0, #0xb                // =11
               	stur	x0, [x29, #-0x8]
               	sub	x2, x29, #0x8
               	mov	x1, x0
               	bl	<addr>
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	add	x20, x20, x0
               	mov	x0, #0xb                // =11
               	stur	x0, [x29, #-0x8]
               	sub	x2, x29, #0x8
               	mov	x1, x0
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
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
