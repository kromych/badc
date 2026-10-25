
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
               	sub	x0, x29, #0x200
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	stp	xzr, xzr, [x0, #0x30]
               	stp	xzr, xzr, [x0, #0x40]
               	stp	xzr, xzr, [x0, #0x50]
               	stp	xzr, xzr, [x0, #0x60]
               	stp	xzr, xzr, [x0, #0x70]
               	stp	xzr, xzr, [x0, #0x80]
               	stp	xzr, xzr, [x0, #0x90]
               	stp	xzr, xzr, [x0, #0xa0]
               	stp	xzr, xzr, [x0, #0xb0]
               	stp	xzr, xzr, [x0, #0xc0]
               	stp	xzr, xzr, [x0, #0xd0]
               	stp	xzr, xzr, [x0, #0xe0]
               	stp	xzr, xzr, [x0, #0xf0]
               	stp	xzr, xzr, [x0, #0x100]
               	stp	xzr, xzr, [x0, #0x110]
               	stp	xzr, xzr, [x0, #0x120]
               	stp	xzr, xzr, [x0, #0x130]
               	stp	xzr, xzr, [x0, #0x140]
               	stp	xzr, xzr, [x0, #0x150]
               	stp	xzr, xzr, [x0, #0x160]
               	stp	xzr, xzr, [x0, #0x170]
               	stp	xzr, xzr, [x0, #0x180]
               	stp	xzr, xzr, [x0, #0x190]
               	stp	xzr, xzr, [x0, #0x1a0]
               	stp	xzr, xzr, [x0, #0x1b0]
               	stp	xzr, xzr, [x0, #0x1c0]
               	stp	xzr, xzr, [x0, #0x1d0]
               	stp	xzr, xzr, [x0, #0x1e0]
               	add	x17, x0, #0x1f0
               	stp	xzr, xzr, [x17]
               	add	x0, x0, #0x101
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x6                // =6
               	bl	<addr>
               	sub	x0, x29, #0x200
               	add	x0, x0, #0x107
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x2                // =2
               	bl	<addr>
               	sub	x0, x29, #0x200
               	mov	x1, #0x35               // =53
               	strb	w1, [sp, #0x9c]
               	add	x0, x0, #0x101
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldurb	w0, [x29, #-0xf9]
               	eor	x0, x0, #0x30
               	cbz	w0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [sp, #0x9c]
               	mov	x17, #0x35              // =53
               	eor	x0, x0, x17
               	cmp	w0, #0x0
               	cset	x0, ne
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
