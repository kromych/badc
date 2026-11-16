
archive_format_constants.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x200
               	sub	x1, x29, #0x200
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	stp	xzr, xzr, [x1, #0x20]
               	stp	xzr, xzr, [x1, #0x30]
               	stp	xzr, xzr, [x1, #0x40]
               	stp	xzr, xzr, [x1, #0x50]
               	stp	xzr, xzr, [x1, #0x60]
               	stp	xzr, xzr, [x1, #0x70]
               	stp	xzr, xzr, [x1, #0x80]
               	stp	xzr, xzr, [x1, #0x90]
               	stp	xzr, xzr, [x1, #0xa0]
               	stp	xzr, xzr, [x1, #0xb0]
               	stp	xzr, xzr, [x1, #0xc0]
               	stp	xzr, xzr, [x1, #0xd0]
               	stp	xzr, xzr, [x1, #0xe0]
               	stp	xzr, xzr, [x1, #0xf0]
               	stp	xzr, xzr, [x1, #0x100]
               	stp	xzr, xzr, [x1, #0x110]
               	stp	xzr, xzr, [x1, #0x120]
               	stp	xzr, xzr, [x1, #0x130]
               	stp	xzr, xzr, [x1, #0x140]
               	stp	xzr, xzr, [x1, #0x150]
               	stp	xzr, xzr, [x1, #0x160]
               	stp	xzr, xzr, [x1, #0x170]
               	stp	xzr, xzr, [x1, #0x180]
               	stp	xzr, xzr, [x1, #0x190]
               	stp	xzr, xzr, [x1, #0x1a0]
               	stp	xzr, xzr, [x1, #0x1b0]
               	stp	xzr, xzr, [x1, #0x1c0]
               	stp	xzr, xzr, [x1, #0x1d0]
               	stp	xzr, xzr, [x1, #0x1e0]
               	add	x17, x1, #0x1f0
               	stp	xzr, xzr, [x17]
               	add	x0, x1, #0x101
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	w16, [x2]
               	str	w16, [x0]
               	ldrh	w16, [x2, #0x4]
               	strh	w16, [x0, #0x4]
               	add	x1, x1, #0x107
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrh	w16, [x2]
               	strh	w16, [x1]
               	mov	x1, #0x35               // =53
               	strb	w1, [sp, #0x9c]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldurb	w0, [x29, #-0xf9]
               	cmp	w0, #0x30
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [sp, #0x9c]
               	cmp	w0, #0x35
               	cset	x0, ne
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
