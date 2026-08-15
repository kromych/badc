
overaligned_automatic16.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<probe_even>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x90
               	sxtw	x0, w0
               	sub	x1, x29, #0x40
               	str	x0, [x1]
               	asr	x2, x0, #63
               	str	x2, [x1, #0x8]
               	sub	x2, x29, #0x90
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	sub	x2, x29, #0x80
               	add	x1, x0, #0x1
               	sxtw	x1, w1
               	str	x1, [x2]
               	sub	x1, x29, #0x80
               	add	x2, x0, #0x2
               	sxtw	x2, w2
               	str	x2, [x1, #0x8]
               	sub	x3, x29, #0x70
               	add	x1, x0, #0x3
               	sxtw	x2, w1
               	sub	x1, x29, #0x50
               	str	x2, [x1]
               	asr	x2, x2, #63
               	str	x2, [x1, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x3]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x3
               	sub	x1, x29, #0x90
               	mov	x17, #0xf               // =15
               	and	x1, x1, x17
               	sub	x2, x29, #0x80
               	mov	x17, #0xf               // =15
               	and	x2, x2, x17
               	orr	x1, x1, x2
               	sub	x2, x29, #0x70
               	mov	x17, #0xf               // =15
               	and	x2, x2, x17
               	orr	x1, x1, x2
               	cbz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	mov	x17, #0x1               // =1
               	orr	x2, x2, x17
               	str	w2, [x1]
               	sub	x1, x29, #0x90
               	ldr	x1, [x1]
               	cmp	x1, x0
               	cset	x2, ne
               	mov	x1, #0x1                // =1
               	cbnz	x2, <addr>
               	sub	x1, x29, #0x80
               	ldr	x2, [x1]
               	sub	x1, x29, #0x80
               	ldr	x1, [x1, #0x8]
               	add	x2, x2, x1
               	lsl	x1, x0, #1
               	add	x1, x1, #0x3
               	sxtw	x1, w1
               	cmp	x2, x1
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x1, x29, #0x70
               	ldr	x1, [x1]
               	add	x0, x0, #0x3
               	sxtw	x0, w0
               	cmp	x1, x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	mov	x17, #0x2               // =2
               	orr	x1, x1, x17
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>

<probe_odd>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x90
               	mov	x1, x0
               	sxtw	x1, w1
               	stur	x1, [x29, #-0x58]
               	ldur	x2, [x29, #-0x58]
               	sub	x0, x29, #0x40
               	str	x2, [x0]
               	asr	x2, x2, #63
               	str	x2, [x0, #0x8]
               	sub	x2, x29, #0x90
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	sub	x0, x29, #0x80
               	ldur	x2, [x29, #-0x58]
               	add	x2, x2, #0x1
               	str	x2, [x0]
               	sub	x0, x29, #0x80
               	ldur	x2, [x29, #-0x58]
               	add	x2, x2, #0x2
               	str	x2, [x0, #0x8]
               	sub	x3, x29, #0x70
               	ldur	x0, [x29, #-0x58]
               	add	x2, x0, #0x3
               	sub	x0, x29, #0x50
               	str	x2, [x0]
               	asr	x2, x2, #63
               	str	x2, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	sub	x0, x29, #0x90
               	mov	x17, #0xf               // =15
               	and	x0, x0, x17
               	sub	x2, x29, #0x80
               	mov	x17, #0xf               // =15
               	and	x2, x2, x17
               	orr	x0, x0, x2
               	sub	x2, x29, #0x70
               	mov	x17, #0xf               // =15
               	and	x2, x2, x17
               	orr	x0, x0, x2
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	mov	x17, #0x4               // =4
               	orr	x2, x2, x17
               	str	w2, [x0]
               	sub	x0, x29, #0x90
               	ldr	x0, [x0]
               	cmp	x0, x1
               	cset	x2, ne
               	mov	x0, #0x1                // =1
               	cbnz	x2, <addr>
               	sub	x0, x29, #0x80
               	ldr	x2, [x0]
               	sub	x0, x29, #0x80
               	ldr	x0, [x0, #0x8]
               	add	x2, x2, x0
               	lsl	x0, x1, #1
               	add	x0, x0, #0x3
               	sxtw	x0, w0
               	cmp	x2, x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x70
               	ldr	x2, [x0]
               	add	x0, x1, #0x3
               	sxtw	x0, w0
               	cmp	x2, x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	mov	x17, #0x8               // =8
               	orr	x1, x1, x17
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>

<walk>:
               	str	x20, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x20, x0
               	sxtw	x20, w20
               	sub	x0, x29, #0x18
               	mov	x1, #0x3                // =3
               	sdiv	x17, x20, x1
               	msub	x1, x17, x1, x20
               	lsl	x1, x1, #3
               	add	x0, x0, x1
               	str	x20, [x0]
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, x20
               	bl	<addr>
               	cmp	x20, #0x0
               	b.le	<addr>
               	sub	x0, x20, #0x1
               	bl	<addr>
               	sub	x0, x29, #0x18
               	mov	x1, #0x3                // =3
               	sdiv	x17, x20, x1
               	msub	x1, x17, x1, x20
               	lsl	x1, x1, #3
               	add	x0, x0, x1
               	ldr	x0, [x0]
               	mov	x0, #0x0                // =0
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
