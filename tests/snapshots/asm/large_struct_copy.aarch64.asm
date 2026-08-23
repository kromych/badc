
large_struct_copy.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x450
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sub	x2, x29, #0x420
               	mov	x0, #0x64               // =100
               	str	w0, [x2]
               	mov	x0, #0xc8               // =200
               	str	w0, [x2, #0x4]
               	mov	x0, #0x12c              // =300
               	str	w0, [x2, #0x8]
               	mov	x0, #0x190              // =400
               	str	w0, [x2, #0xc]
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	str	w0, [x2, #0xb0]
               	mov	x0, #0xfffe             // =65534
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	str	w0, [x2, #0x154]
               	mov	x0, #0xfffd             // =65533
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	str	w0, [x2, #0x1f8]
               	mov	x0, #0x1f4              // =500
               	str	w0, [x2, #0x1fc]
               	mov	x0, #0x258              // =600
               	str	w0, [x2, #0x200]
               	mov	x0, #0x2bc              // =700
               	str	w0, [x2, #0x204]
               	mov	x0, #0x320              // =800
               	str	w0, [x2, #0x208]
               	mov	x1, #0x0                // =0
               	b	<addr>
               	add	x4, x2, #0x10
               	sxtw	x0, w1
               	add	x3, x0, #0x3e8
               	str	w3, [x4, x0, lsl #2]
               	add	x4, x2, #0xb4
               	add	x3, x0, #0x7d0
               	str	w3, [x4, x0, lsl #2]
               	add	x4, x2, #0x158
               	add	x3, x0, #0xbb8
               	str	w3, [x4, x0, lsl #2]
               	add	x1, x0, #0x1
               	cmp	w1, #0x28
               	b.lt	<addr>
               	sub	x20, x29, #0x210
               	mov	x1, #0x7e               // =126
               	mov	x2, #0x20c              // =524
               	mov	x0, x20
               	bl	<addr>
               	sub	x0, x29, #0x420
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x20, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x20, #0x10]
               	ldr	x10, [x0, #0x18]
               	str	x10, [x20, #0x18]
               	ldr	x10, [x0, #0x20]
               	str	x10, [x20, #0x20]
               	ldr	x10, [x0, #0x28]
               	str	x10, [x20, #0x28]
               	ldr	x10, [x0, #0x30]
               	str	x10, [x20, #0x30]
               	ldr	x10, [x0, #0x38]
               	str	x10, [x20, #0x38]
               	ldr	x10, [x0, #0x40]
               	str	x10, [x20, #0x40]
               	ldr	x10, [x0, #0x48]
               	str	x10, [x20, #0x48]
               	ldr	x10, [x0, #0x50]
               	str	x10, [x20, #0x50]
               	ldr	x10, [x0, #0x58]
               	str	x10, [x20, #0x58]
               	ldr	x10, [x0, #0x60]
               	str	x10, [x20, #0x60]
               	ldr	x10, [x0, #0x68]
               	str	x10, [x20, #0x68]
               	ldr	x10, [x0, #0x70]
               	str	x10, [x20, #0x70]
               	ldr	x10, [x0, #0x78]
               	str	x10, [x20, #0x78]
               	ldr	x10, [x0, #0x80]
               	str	x10, [x20, #0x80]
               	ldr	x10, [x0, #0x88]
               	str	x10, [x20, #0x88]
               	ldr	x10, [x0, #0x90]
               	str	x10, [x20, #0x90]
               	ldr	x10, [x0, #0x98]
               	str	x10, [x20, #0x98]
               	ldr	x10, [x0, #0xa0]
               	str	x10, [x20, #0xa0]
               	ldr	x10, [x0, #0xa8]
               	str	x10, [x20, #0xa8]
               	ldr	x10, [x0, #0xb0]
               	str	x10, [x20, #0xb0]
               	ldr	x10, [x0, #0xb8]
               	str	x10, [x20, #0xb8]
               	ldr	x10, [x0, #0xc0]
               	str	x10, [x20, #0xc0]
               	ldr	x10, [x0, #0xc8]
               	str	x10, [x20, #0xc8]
               	ldr	x10, [x0, #0xd0]
               	str	x10, [x20, #0xd0]
               	ldr	x10, [x0, #0xd8]
               	str	x10, [x20, #0xd8]
               	ldr	x10, [x0, #0xe0]
               	str	x10, [x20, #0xe0]
               	ldr	x10, [x0, #0xe8]
               	str	x10, [x20, #0xe8]
               	ldr	x10, [x0, #0xf0]
               	str	x10, [x20, #0xf0]
               	ldr	x10, [x0, #0xf8]
               	str	x10, [x20, #0xf8]
               	ldr	x10, [x0, #0x100]
               	str	x10, [x20, #0x100]
               	ldr	x10, [x0, #0x108]
               	str	x10, [x20, #0x108]
               	ldr	x10, [x0, #0x110]
               	str	x10, [x20, #0x110]
               	ldr	x10, [x0, #0x118]
               	str	x10, [x20, #0x118]
               	ldr	x10, [x0, #0x120]
               	str	x10, [x20, #0x120]
               	ldr	x10, [x0, #0x128]
               	str	x10, [x20, #0x128]
               	ldr	x10, [x0, #0x130]
               	str	x10, [x20, #0x130]
               	ldr	x10, [x0, #0x138]
               	str	x10, [x20, #0x138]
               	ldr	x10, [x0, #0x140]
               	str	x10, [x20, #0x140]
               	ldr	x10, [x0, #0x148]
               	str	x10, [x20, #0x148]
               	ldr	x10, [x0, #0x150]
               	str	x10, [x20, #0x150]
               	ldr	x10, [x0, #0x158]
               	str	x10, [x20, #0x158]
               	ldr	x10, [x0, #0x160]
               	str	x10, [x20, #0x160]
               	ldr	x10, [x0, #0x168]
               	str	x10, [x20, #0x168]
               	ldr	x10, [x0, #0x170]
               	str	x10, [x20, #0x170]
               	ldr	x10, [x0, #0x178]
               	str	x10, [x20, #0x178]
               	ldr	x10, [x0, #0x180]
               	str	x10, [x20, #0x180]
               	ldr	x10, [x0, #0x188]
               	str	x10, [x20, #0x188]
               	ldr	x10, [x0, #0x190]
               	str	x10, [x20, #0x190]
               	ldr	x10, [x0, #0x198]
               	str	x10, [x20, #0x198]
               	ldr	x10, [x0, #0x1a0]
               	str	x10, [x20, #0x1a0]
               	ldr	x10, [x0, #0x1a8]
               	str	x10, [x20, #0x1a8]
               	ldr	x10, [x0, #0x1b0]
               	str	x10, [x20, #0x1b0]
               	ldr	x10, [x0, #0x1b8]
               	str	x10, [x20, #0x1b8]
               	ldr	x10, [x0, #0x1c0]
               	str	x10, [x20, #0x1c0]
               	ldr	x10, [x0, #0x1c8]
               	str	x10, [x20, #0x1c8]
               	ldr	x10, [x0, #0x1d0]
               	str	x10, [x20, #0x1d0]
               	ldr	x10, [x0, #0x1d8]
               	str	x10, [x20, #0x1d8]
               	ldr	x10, [x0, #0x1e0]
               	str	x10, [x20, #0x1e0]
               	ldr	x10, [x0, #0x1e8]
               	str	x10, [x20, #0x1e8]
               	ldr	x10, [x0, #0x1f0]
               	str	x10, [x20, #0x1f0]
               	ldr	x10, [x0, #0x1f8]
               	str	x10, [x20, #0x1f8]
               	ldr	x10, [x0, #0x200]
               	str	x10, [x20, #0x200]
               	ldrb	w10, [x0, #0x208]
               	strb	w10, [x20, #0x208]
               	ldrb	w10, [x0, #0x209]
               	strb	w10, [x20, #0x209]
               	ldrb	w10, [x0, #0x20a]
               	strb	w10, [x20, #0x20a]
               	ldrb	w10, [x0, #0x20b]
               	strb	w10, [x20, #0x20b]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	ldrsw	x0, [x20]
               	cmp	w0, #0x64
               	mov	x0, #0x1                // =1
               	b.ne	<addr>
               	ldrsw	x1, [x20, #0x4]
               	cmp	w1, #0xc8
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldrsw	x1, [x20, #0x8]
               	cmp	w1, #0x12c
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldrsw	x1, [x20, #0xc]
               	cmp	w1, #0x190
               	cset	x1, ne
               	cbz	x1, <addr>
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp]
               	add	sp, sp, #0x450
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x210
               	ldrsw	x1, [x2, #0x1fc]
               	cmp	w1, #0x1f4
               	b.ne	<addr>
               	ldrsw	x1, [x2, #0x200]
               	cmp	w1, #0x258
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldrsw	x0, [x2, #0x204]
               	cmp	w0, #0x2bc
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldrsw	x0, [x2, #0x208]
               	cmp	w0, #0x320
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp]
               	add	sp, sp, #0x450
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2, #0xb0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp]
               	add	sp, sp, #0x450
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2, #0x154]
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp]
               	add	sp, sp, #0x450
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2, #0x1f8]
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp]
               	add	sp, sp, #0x450
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	b	<addr>
               	add	x3, x2, #0x10
               	sxtw	x0, w1
               	ldrsw	x4, [x3, x0, lsl #2]
               	add	x3, x0, #0x3e8
               	cmp	w4, w3
               	b.ne	<addr>
               	add	x3, x2, #0xb4
               	ldrsw	x4, [x3, x0, lsl #2]
               	add	x3, x0, #0x7d0
               	cmp	w4, w3
               	b.ne	<addr>
               	add	x3, x2, #0x158
               	ldrsw	x4, [x3, x0, lsl #2]
               	add	x3, x0, #0xbb8
               	cmp	w4, w3
               	b.ne	<addr>
               	add	x1, x0, #0x1
               	cmp	w1, #0x28
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp]
               	add	sp, sp, #0x450
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x1, #0x6e
               	sxtw	x0, w0
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp]
               	add	sp, sp, #0x450
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x1, #0x3c
               	sxtw	x0, w0
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp]
               	add	sp, sp, #0x450
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x1, #0xa
               	sxtw	x0, w0
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp]
               	add	sp, sp, #0x450
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
