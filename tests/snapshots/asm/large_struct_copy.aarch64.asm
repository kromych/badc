
large_struct_copy.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2b0              // =688
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x490
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	sub	x0, x29, #0x210
               	mov	x1, #0x64               // =100
               	str	w1, [x0]
               	sub	x0, x29, #0x210
               	mov	x1, #0xc8               // =200
               	str	w1, [x0, #0x4]
               	sub	x0, x29, #0x210
               	mov	x1, #0x12c              // =300
               	str	w1, [x0, #0x8]
               	sub	x0, x29, #0x210
               	mov	x1, #0x190              // =400
               	str	w1, [x0, #0xc]
               	sub	x0, x29, #0x210
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	str	w1, [x0, #0xb0]
               	sub	x0, x29, #0x210
               	mov	x1, #0xfffe             // =65534
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	str	w1, [x0, #0x154]
               	sub	x0, x29, #0x210
               	mov	x1, #0xfffd             // =65533
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	str	w1, [x0, #0x1f8]
               	sub	x0, x29, #0x210
               	mov	x1, #0x1f4              // =500
               	str	w1, [x0, #0x1fc]
               	sub	x0, x29, #0x210
               	mov	x1, #0x258              // =600
               	str	w1, [x0, #0x200]
               	sub	x0, x29, #0x210
               	mov	x1, #0x2bc              // =700
               	str	w1, [x0, #0x204]
               	sub	x0, x29, #0x210
               	mov	x1, #0x320              // =800
               	str	w1, [x0, #0x208]
               	mov	x1, #0x0                // =0
               	sxtw	x0, w1
               	cmp	x0, #0x28
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	b	<addr>
               	sub	x0, x29, #0x210
               	add	x0, x0, #0x10
               	sxtw	x2, w1
               	add	x3, x2, #0x3e8
               	str	w3, [x0, x2, lsl #2]
               	sub	x0, x29, #0x210
               	add	x0, x0, #0xb4
               	sxtw	x2, w1
               	add	x3, x2, #0x7d0
               	str	w3, [x0, x2, lsl #2]
               	sub	x0, x29, #0x210
               	add	x0, x0, #0x158
               	sxtw	x2, w1
               	add	x3, x2, #0xbb8
               	str	w3, [x0, x2, lsl #2]
               	b	<addr>
               	sub	x0, x29, #0x420
               	mov	x1, #0x7e               // =126
               	mov	x2, #0x20c              // =524
               	bl	<addr>
               	sub	x0, x29, #0x420
               	sub	x1, x29, #0x210
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x1, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [x1, #0x28]
               	str	x10, [x0, #0x28]
               	ldr	x10, [x1, #0x30]
               	str	x10, [x0, #0x30]
               	ldr	x10, [x1, #0x38]
               	str	x10, [x0, #0x38]
               	ldr	x10, [x1, #0x40]
               	str	x10, [x0, #0x40]
               	ldr	x10, [x1, #0x48]
               	str	x10, [x0, #0x48]
               	ldr	x10, [x1, #0x50]
               	str	x10, [x0, #0x50]
               	ldr	x10, [x1, #0x58]
               	str	x10, [x0, #0x58]
               	ldr	x10, [x1, #0x60]
               	str	x10, [x0, #0x60]
               	ldr	x10, [x1, #0x68]
               	str	x10, [x0, #0x68]
               	ldr	x10, [x1, #0x70]
               	str	x10, [x0, #0x70]
               	ldr	x10, [x1, #0x78]
               	str	x10, [x0, #0x78]
               	ldr	x10, [x1, #0x80]
               	str	x10, [x0, #0x80]
               	ldr	x10, [x1, #0x88]
               	str	x10, [x0, #0x88]
               	ldr	x10, [x1, #0x90]
               	str	x10, [x0, #0x90]
               	ldr	x10, [x1, #0x98]
               	str	x10, [x0, #0x98]
               	ldr	x10, [x1, #0xa0]
               	str	x10, [x0, #0xa0]
               	ldr	x10, [x1, #0xa8]
               	str	x10, [x0, #0xa8]
               	ldr	x10, [x1, #0xb0]
               	str	x10, [x0, #0xb0]
               	ldr	x10, [x1, #0xb8]
               	str	x10, [x0, #0xb8]
               	ldr	x10, [x1, #0xc0]
               	str	x10, [x0, #0xc0]
               	ldr	x10, [x1, #0xc8]
               	str	x10, [x0, #0xc8]
               	ldr	x10, [x1, #0xd0]
               	str	x10, [x0, #0xd0]
               	ldr	x10, [x1, #0xd8]
               	str	x10, [x0, #0xd8]
               	ldr	x10, [x1, #0xe0]
               	str	x10, [x0, #0xe0]
               	ldr	x10, [x1, #0xe8]
               	str	x10, [x0, #0xe8]
               	ldr	x10, [x1, #0xf0]
               	str	x10, [x0, #0xf0]
               	ldr	x10, [x1, #0xf8]
               	str	x10, [x0, #0xf8]
               	ldr	x10, [x1, #0x100]
               	str	x10, [x0, #0x100]
               	ldr	x10, [x1, #0x108]
               	str	x10, [x0, #0x108]
               	ldr	x10, [x1, #0x110]
               	str	x10, [x0, #0x110]
               	ldr	x10, [x1, #0x118]
               	str	x10, [x0, #0x118]
               	ldr	x10, [x1, #0x120]
               	str	x10, [x0, #0x120]
               	ldr	x10, [x1, #0x128]
               	str	x10, [x0, #0x128]
               	ldr	x10, [x1, #0x130]
               	str	x10, [x0, #0x130]
               	ldr	x10, [x1, #0x138]
               	str	x10, [x0, #0x138]
               	ldr	x10, [x1, #0x140]
               	str	x10, [x0, #0x140]
               	ldr	x10, [x1, #0x148]
               	str	x10, [x0, #0x148]
               	ldr	x10, [x1, #0x150]
               	str	x10, [x0, #0x150]
               	ldr	x10, [x1, #0x158]
               	str	x10, [x0, #0x158]
               	ldr	x10, [x1, #0x160]
               	str	x10, [x0, #0x160]
               	ldr	x10, [x1, #0x168]
               	str	x10, [x0, #0x168]
               	ldr	x10, [x1, #0x170]
               	str	x10, [x0, #0x170]
               	ldr	x10, [x1, #0x178]
               	str	x10, [x0, #0x178]
               	ldr	x10, [x1, #0x180]
               	str	x10, [x0, #0x180]
               	ldr	x10, [x1, #0x188]
               	str	x10, [x0, #0x188]
               	ldr	x10, [x1, #0x190]
               	str	x10, [x0, #0x190]
               	ldr	x10, [x1, #0x198]
               	str	x10, [x0, #0x198]
               	ldr	x10, [x1, #0x1a0]
               	str	x10, [x0, #0x1a0]
               	ldr	x10, [x1, #0x1a8]
               	str	x10, [x0, #0x1a8]
               	ldr	x10, [x1, #0x1b0]
               	str	x10, [x0, #0x1b0]
               	ldr	x10, [x1, #0x1b8]
               	str	x10, [x0, #0x1b8]
               	ldr	x10, [x1, #0x1c0]
               	str	x10, [x0, #0x1c0]
               	ldr	x10, [x1, #0x1c8]
               	str	x10, [x0, #0x1c8]
               	ldr	x10, [x1, #0x1d0]
               	str	x10, [x0, #0x1d0]
               	ldr	x10, [x1, #0x1d8]
               	str	x10, [x0, #0x1d8]
               	ldr	x10, [x1, #0x1e0]
               	str	x10, [x0, #0x1e0]
               	ldr	x10, [x1, #0x1e8]
               	str	x10, [x0, #0x1e8]
               	ldr	x10, [x1, #0x1f0]
               	str	x10, [x0, #0x1f0]
               	ldr	x10, [x1, #0x1f8]
               	str	x10, [x0, #0x1f8]
               	ldr	x10, [x1, #0x200]
               	str	x10, [x0, #0x200]
               	ldrb	w10, [x1, #0x208]
               	strb	w10, [x0, #0x208]
               	ldrb	w10, [x1, #0x209]
               	strb	w10, [x0, #0x209]
               	ldrb	w10, [x1, #0x20a]
               	strb	w10, [x0, #0x20a]
               	ldrb	w10, [x1, #0x20b]
               	strb	w10, [x0, #0x20b]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x420
               	ldrsw	x0, [x0]
               	cmp	x0, #0x64
               	cset	x0, ne
               	mov	x20, #0x1               // =1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x420
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0xc8
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x20, ne
               	mov	x21, #0x1               // =1
               	cbnz	x20, <addr>
               	sub	x0, x29, #0x420
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x12c
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x21, ne
               	cbnz	x21, <addr>
               	sub	x0, x29, #0x420
               	ldrsw	x0, [x0, #0xc]
               	cmp	x0, #0x190
               	cset	x21, ne
               	cbz	x21, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x420
               	ldrsw	x0, [x0, #0x1fc]
               	cmp	x0, #0x1f4
               	cset	x0, ne
               	mov	x20, #0x1               // =1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x420
               	ldrsw	x0, [x0, #0x200]
               	cmp	x0, #0x258
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x20, ne
               	mov	x21, #0x1               // =1
               	cbnz	x20, <addr>
               	sub	x0, x29, #0x420
               	ldrsw	x0, [x0, #0x204]
               	cmp	x0, #0x2bc
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x21, ne
               	cbnz	x21, <addr>
               	sub	x0, x29, #0x420
               	ldrsw	x0, [x0, #0x208]
               	cmp	x0, #0x320
               	cset	x21, ne
               	cbz	x21, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x420
               	ldrsw	x0, [x0, #0xb0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x420
               	ldrsw	x0, [x0, #0x154]
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x420
               	ldrsw	x0, [x0, #0x1f8]
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x0               // =0
               	sxtw	x0, w20
               	cmp	x0, #0x28
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w20
               	add	x20, x0, #0x1
               	b	<addr>
               	sub	x0, x29, #0x420
               	add	x0, x0, #0x10
               	sxtw	x1, w20
               	ldrsw	x0, [x0, x1, lsl #2]
               	add	x1, x1, #0x3e8
               	sxtw	x1, w1
               	cmp	x0, x1
               	b.eq	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x20, #0xa
               	sxtw	x0, w0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x420
               	add	x0, x0, #0xb4
               	sxtw	x1, w20
               	ldrsw	x0, [x0, x1, lsl #2]
               	add	x1, x1, #0x7d0
               	sxtw	x1, w1
               	cmp	x0, x1
               	b.eq	<addr>
               	add	x0, x20, #0x3c
               	sxtw	x0, w0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x420
               	add	x0, x0, #0x158
               	sxtw	x1, w20
               	ldrsw	x0, [x0, x1, lsl #2]
               	add	x1, x1, #0xbb8
               	sxtw	x1, w1
               	cmp	x0, x1
               	b.eq	<addr>
               	add	x0, x20, #0x6e
               	sxtw	x0, w0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
