
overaligned_automatic16.aarch64:	file format elf64-littleaarch64

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

<probe_even>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sxtw	x0, w0
               	asr	x1, x0, #63
               	sub	x2, x29, #0x30
               	stur	x0, [x29, #-0x30]
               	stur	x1, [x29, #-0x28]
               	sub	x3, x29, #0x20
               	add	x1, x0, #0x1
               	sxtw	x1, w1
               	stur	x1, [x29, #-0x20]
               	add	x1, x0, #0x2
               	sxtw	x1, w1
               	stur	x1, [x29, #-0x18]
               	sub	x4, x29, #0x10
               	add	x1, x0, #0x3
               	sxtw	x1, w1
               	asr	x5, x1, #63
               	stur	x1, [x29, #-0x10]
               	stur	x5, [x29, #-0x8]
               	and	x2, x2, #0xf
               	and	x3, x3, #0xf
               	orr	x2, x2, x3
               	and	x3, x4, #0xf
               	orr	x2, x2, x3
               	cbz	x2, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x3, [x2]
               	orr	x3, x3, #0x1
               	str	w3, [x2]
               	ldur	x2, [x29, #-0x30]
               	cmp	x2, x0
               	b.ne	<addr>
               	ldur	x2, [x29, #-0x20]
               	ldur	x3, [x29, #-0x18]
               	add	x2, x2, x3
               	lsl	x0, x0, #1
               	add	x0, x0, #0x3
               	sxtw	x0, w0
               	cmp	x2, x0
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x10]
               	cmp	x0, x1
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	orr	x1, x1, #0x2
               	str	w1, [x0]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<probe_odd>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sxtw	x0, w0
               	stur	x0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	asr	x2, x1, #63
               	sub	x3, x29, #0x40
               	stur	x1, [x29, #-0x40]
               	stur	x2, [x29, #-0x38]
               	sub	x2, x29, #0x30
               	ldur	x1, [x29, #-0x8]
               	add	x1, x1, #0x1
               	stur	x1, [x29, #-0x30]
               	ldur	x1, [x29, #-0x8]
               	add	x1, x1, #0x2
               	stur	x1, [x29, #-0x28]
               	sub	x4, x29, #0x20
               	ldur	x1, [x29, #-0x8]
               	add	x1, x1, #0x3
               	asr	x5, x1, #63
               	stur	x1, [x29, #-0x20]
               	stur	x5, [x29, #-0x18]
               	and	x1, x3, #0xf
               	and	x2, x2, #0xf
               	orr	x1, x1, x2
               	and	x2, x4, #0xf
               	orr	x1, x1, x2
               	cbz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	orr	x2, x2, #0x4
               	str	w2, [x1]
               	ldur	x1, [x29, #-0x40]
               	cmp	x1, x0
               	b.ne	<addr>
               	ldur	x1, [x29, #-0x30]
               	ldur	x2, [x29, #-0x28]
               	add	x1, x1, x2
               	lsl	x2, x0, #1
               	add	x2, x2, #0x3
               	sxtw	x2, w2
               	cmp	x1, x2
               	b.ne	<addr>
               	ldur	x1, [x29, #-0x20]
               	add	x0, x0, #0x3
               	sxtw	x0, w0
               	cmp	x1, x0
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	orr	x1, x1, #0x8
               	str	w1, [x0]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<walk>:
               	str	x20, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	sxtw	x20, w0
               	sub	x1, x29, #0x18
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x20, x17
               	asr	x0, x0, #32
               	lsr	x2, x0, #63
               	add	x0, x0, x2
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	sub	x0, x20, x0
               	lsl	x0, x0, #3
               	add	x0, x1, x0
               	str	x20, [x0]
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, x20
               	bl	<addr>
               	cmp	w20, #0x0
               	b.le	<addr>
               	sub	x0, x20, #0x1
               	bl	<addr>
               	sub	x1, x29, #0x18
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x0, x20, x17
               	asr	x0, x0, #32
               	lsr	x2, x0, #63
               	add	x0, x0, x2
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	sub	x0, x20, x0
               	lsl	x0, x0, #3
               	add	x0, x1, x0
               	ldr	x0, [x0]
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x6                // =6
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	ldp	x29, x30, [sp], #0x10
               	ret
