
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
               	sub	sp, sp, #0x60
               	sxtw	x0, w0
               	asr	x1, x0, #63
               	sub	x2, x29, #0x60
               	str	x0, [x2]
               	str	x1, [x2, #0x8]
               	sub	x1, x29, #0x50
               	add	x3, x0, #0x1
               	sxtw	x3, w3
               	str	x3, [x1]
               	add	x3, x0, #0x2
               	sxtw	x3, w3
               	str	x3, [x1, #0x8]
               	sub	x3, x29, #0x40
               	add	x4, x0, #0x3
               	sxtw	x4, w4
               	asr	x5, x4, #63
               	str	x4, [x3]
               	str	x5, [x3, #0x8]
               	and	x5, x2, #0xf
               	and	x6, x1, #0xf
               	orr	x5, x5, x6
               	and	x6, x3, #0xf
               	orr	x5, x5, x6
               	cbz	x5, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldrsw	x6, [x5]
               	orr	x6, x6, #0x1
               	str	w6, [x5]
               	ldr	x2, [x2]
               	cmp	x2, x0
               	b.ne	<addr>
               	ldr	x2, [x1]
               	ldr	x1, [x1, #0x8]
               	add	x1, x2, x1
               	lsl	x0, x0, #1
               	add	x0, x0, #0x3
               	sxtw	x0, w0
               	cmp	x1, x0
               	b.ne	<addr>
               	ldr	x0, [x3]
               	cmp	x0, x4
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	orr	x1, x1, #0x2
               	str	w1, [x0]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret

<probe_odd>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	sxtw	x0, w0
               	stur	x0, [x29, #-0x38]
               	ldur	x1, [x29, #-0x38]
               	asr	x3, x1, #63
               	sub	x2, x29, #0x70
               	str	x1, [x2]
               	str	x3, [x2, #0x8]
               	sub	x1, x29, #0x60
               	ldur	x3, [x29, #-0x38]
               	add	x3, x3, #0x1
               	str	x3, [x1]
               	ldur	x3, [x29, #-0x38]
               	add	x3, x3, #0x2
               	str	x3, [x1, #0x8]
               	sub	x3, x29, #0x50
               	ldur	x4, [x29, #-0x38]
               	add	x4, x4, #0x3
               	asr	x5, x4, #63
               	str	x4, [x3]
               	str	x5, [x3, #0x8]
               	and	x4, x2, #0xf
               	and	x5, x1, #0xf
               	orr	x4, x4, x5
               	and	x5, x3, #0xf
               	orr	x4, x4, x5
               	cbz	x4, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldrsw	x5, [x4]
               	orr	x5, x5, #0x4
               	str	w5, [x4]
               	ldr	x2, [x2]
               	cmp	x2, x0
               	b.ne	<addr>
               	ldr	x2, [x1]
               	ldr	x1, [x1, #0x8]
               	add	x1, x2, x1
               	lsl	x2, x0, #1
               	add	x2, x2, #0x3
               	sxtw	x2, w2
               	cmp	x1, x2
               	b.ne	<addr>
               	ldr	x1, [x3]
               	add	x0, x0, #0x3
               	sxtw	x0, w0
               	cmp	x1, x0
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	orr	x1, x1, #0x8
               	str	w1, [x0]
               	add	sp, sp, #0x70
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
