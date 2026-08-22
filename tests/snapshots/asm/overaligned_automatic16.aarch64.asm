
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
               	sub	sp, sp, #0x80
               	sxtw	x0, w0
               	sub	x1, x29, #0x40
               	str	x0, [x1]
               	asr	x2, x0, #63
               	str	x2, [x1, #0x8]
               	sub	x4, x29, #0x80
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x4]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x4
               	sub	x2, x29, #0x70
               	add	x3, x0, #0x1
               	sxtw	x3, w3
               	str	x3, [x2]
               	add	x3, x0, #0x2
               	sxtw	x3, w3
               	str	x3, [x2, #0x8]
               	sub	x5, x29, #0x60
               	add	x3, x0, #0x3
               	sxtw	x6, w3
               	str	x6, [x1]
               	asr	x7, x6, #63
               	str	x7, [x1, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x5]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x5, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x5
               	mov	x17, #0xf               // =15
               	and	x1, x4, x17
               	mov	x17, #0xf               // =15
               	and	x7, x2, x17
               	orr	x1, x1, x7
               	mov	x17, #0xf               // =15
               	and	x7, x5, x17
               	orr	x1, x1, x7
               	cbz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x7, [x1]
               	mov	x17, #0x1               // =1
               	orr	x7, x7, x17
               	str	w7, [x1]
               	ldr	x1, [x4]
               	cmp	x1, x0
               	mov	x1, #0x1                // =1
               	b.ne	<addr>
               	ldr	x1, [x2]
               	ldr	x2, [x2, #0x8]
               	add	x2, x1, x2
               	lsl	x1, x0, #1
               	add	x1, x1, #0x3
               	sxtw	x1, w1
               	cmp	x2, x1
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldr	x1, [x5]
               	cmp	x1, x6
               	cset	x1, ne
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	mov	x17, #0x2               // =2
               	orr	x1, x1, x17
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>

<probe_odd>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	mov	x2, x0
               	sxtw	x2, w2
               	stur	x2, [x29, #-0x38]
               	ldur	x1, [x29, #-0x38]
               	sub	x0, x29, #0x48
               	str	x1, [x0]
               	asr	x1, x1, #63
               	str	x1, [x0, #0x8]
               	sub	x3, x29, #0x80
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x3
               	sub	x1, x29, #0x70
               	ldur	x4, [x29, #-0x38]
               	add	x4, x4, #0x1
               	str	x4, [x1]
               	ldur	x4, [x29, #-0x38]
               	add	x4, x4, #0x2
               	str	x4, [x1, #0x8]
               	sub	x4, x29, #0x60
               	ldur	x5, [x29, #-0x38]
               	add	x5, x5, #0x3
               	str	x5, [x0]
               	asr	x5, x5, #63
               	str	x5, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x4]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x4
               	mov	x17, #0xf               // =15
               	and	x0, x3, x17
               	mov	x17, #0xf               // =15
               	and	x5, x1, x17
               	orr	x0, x0, x5
               	mov	x17, #0xf               // =15
               	and	x5, x4, x17
               	orr	x0, x0, x5
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x5, [x0]
               	mov	x17, #0x4               // =4
               	orr	x5, x5, x17
               	str	w5, [x0]
               	ldr	x0, [x3]
               	cmp	x0, x2
               	mov	x0, #0x1                // =1
               	b.ne	<addr>
               	ldr	x0, [x1]
               	ldr	x1, [x1, #0x8]
               	add	x1, x0, x1
               	lsl	x0, x2, #1
               	add	x0, x0, #0x3
               	sxtw	x0, w0
               	cmp	x1, x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldr	x1, [x4]
               	add	x0, x2, #0x3
               	sxtw	x0, w0
               	cmp	x1, x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	mov	x17, #0x8               // =8
               	orr	x1, x1, x17
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>

<walk>:
               	stp	x20, x21, [sp, #-0x70]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	str	x26, [sp, #0x30]
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	mov	x20, x0
               	sxtw	x20, w20
               	sub	x22, x29, #0x18
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x23, x20, x17
               	asr	x21, x23, #32
               	lsr	x24, x21, #63
               	add	x25, x21, x24
               	mov	x17, #0x3               // =3
               	mul	x26, x25, x17
               	sub	x0, x20, x26
               	lsl	x0, x0, #3
               	add	x0, x22, x0
               	str	x20, [x0]
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, x20
               	bl	<addr>
               	cmp	x20, #0x0
               	b.le	<addr>
               	sub	x0, x20, #0x1
               	bl	<addr>
               	sub	x0, x20, x26
               	lsl	x0, x0, #3
               	add	x0, x22, x0
               	ldr	x0, [x0]
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x26, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
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
