
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
               	sub	sp, sp, #0x420
               	sub	x1, x29, #0x420
               	mov	x0, #0x64               // =100
               	str	w0, [x1]
               	mov	x0, #0xc8               // =200
               	str	w0, [x1, #0x4]
               	mov	x0, #0x12c              // =300
               	str	w0, [x1, #0x8]
               	mov	x0, #0x190              // =400
               	str	w0, [x1, #0xc]
               	mov	x0, #-0x1               // =-1
               	str	w0, [x1, #0xb0]
               	mov	x0, #-0x2               // =-2
               	str	w0, [x1, #0x154]
               	mov	x0, #-0x3               // =-3
               	str	w0, [x1, #0x1f8]
               	mov	x0, #0x1f4              // =500
               	str	w0, [x1, #0x1fc]
               	mov	x0, #0x258              // =600
               	str	w0, [x1, #0x200]
               	mov	x0, #0x2bc              // =700
               	str	w0, [x1, #0x204]
               	mov	x0, #0x320              // =800
               	str	w0, [x1, #0x208]
               	mov	x0, #0x0                // =0
               	add	x2, x1, #0x10
               	add	x3, x0, #0x3e8
               	str	w3, [x2, x0, lsl #2]
               	add	x2, x1, #0xb4
               	add	x3, x0, #0x7d0
               	str	w3, [x2, x0, lsl #2]
               	add	x2, x1, #0x158
               	add	x3, x0, #0xbb8
               	str	w3, [x2, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x28
               	b.lt	<addr>
               	sub	x0, x29, #0x210
               	mov	x1, #0x7e               // =126
               	mov	x2, #0x20c              // =524
               	bl	<addr>
               	sub	x1, x29, #0x210
               	sub	x0, x29, #0x420
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [x0, #0x18]
               	str	x10, [x1, #0x18]
               	ldr	x10, [x0, #0x20]
               	str	x10, [x1, #0x20]
               	ldr	x10, [x0, #0x28]
               	str	x10, [x1, #0x28]
               	ldr	x10, [x0, #0x30]
               	str	x10, [x1, #0x30]
               	ldr	x10, [x0, #0x38]
               	str	x10, [x1, #0x38]
               	ldr	x10, [x0, #0x40]
               	str	x10, [x1, #0x40]
               	ldr	x10, [x0, #0x48]
               	str	x10, [x1, #0x48]
               	ldr	x10, [x0, #0x50]
               	str	x10, [x1, #0x50]
               	ldr	x10, [x0, #0x58]
               	str	x10, [x1, #0x58]
               	ldr	x10, [x0, #0x60]
               	str	x10, [x1, #0x60]
               	ldr	x10, [x0, #0x68]
               	str	x10, [x1, #0x68]
               	ldr	x10, [x0, #0x70]
               	str	x10, [x1, #0x70]
               	ldr	x10, [x0, #0x78]
               	str	x10, [x1, #0x78]
               	ldr	x10, [x0, #0x80]
               	str	x10, [x1, #0x80]
               	ldr	x10, [x0, #0x88]
               	str	x10, [x1, #0x88]
               	ldr	x10, [x0, #0x90]
               	str	x10, [x1, #0x90]
               	ldr	x10, [x0, #0x98]
               	str	x10, [x1, #0x98]
               	ldr	x10, [x0, #0xa0]
               	str	x10, [x1, #0xa0]
               	ldr	x10, [x0, #0xa8]
               	str	x10, [x1, #0xa8]
               	ldr	x10, [x0, #0xb0]
               	str	x10, [x1, #0xb0]
               	ldr	x10, [x0, #0xb8]
               	str	x10, [x1, #0xb8]
               	ldr	x10, [x0, #0xc0]
               	str	x10, [x1, #0xc0]
               	ldr	x10, [x0, #0xc8]
               	str	x10, [x1, #0xc8]
               	ldr	x10, [x0, #0xd0]
               	str	x10, [x1, #0xd0]
               	ldr	x10, [x0, #0xd8]
               	str	x10, [x1, #0xd8]
               	ldr	x10, [x0, #0xe0]
               	str	x10, [x1, #0xe0]
               	ldr	x10, [x0, #0xe8]
               	str	x10, [x1, #0xe8]
               	ldr	x10, [x0, #0xf0]
               	str	x10, [x1, #0xf0]
               	ldr	x10, [x0, #0xf8]
               	str	x10, [x1, #0xf8]
               	ldr	x10, [x0, #0x100]
               	str	x10, [x1, #0x100]
               	ldr	x10, [x0, #0x108]
               	str	x10, [x1, #0x108]
               	ldr	x10, [x0, #0x110]
               	str	x10, [x1, #0x110]
               	ldr	x10, [x0, #0x118]
               	str	x10, [x1, #0x118]
               	ldr	x10, [x0, #0x120]
               	str	x10, [x1, #0x120]
               	ldr	x10, [x0, #0x128]
               	str	x10, [x1, #0x128]
               	ldr	x10, [x0, #0x130]
               	str	x10, [x1, #0x130]
               	ldr	x10, [x0, #0x138]
               	str	x10, [x1, #0x138]
               	ldr	x10, [x0, #0x140]
               	str	x10, [x1, #0x140]
               	ldr	x10, [x0, #0x148]
               	str	x10, [x1, #0x148]
               	ldr	x10, [x0, #0x150]
               	str	x10, [x1, #0x150]
               	ldr	x10, [x0, #0x158]
               	str	x10, [x1, #0x158]
               	ldr	x10, [x0, #0x160]
               	str	x10, [x1, #0x160]
               	ldr	x10, [x0, #0x168]
               	str	x10, [x1, #0x168]
               	ldr	x10, [x0, #0x170]
               	str	x10, [x1, #0x170]
               	ldr	x10, [x0, #0x178]
               	str	x10, [x1, #0x178]
               	ldr	x10, [x0, #0x180]
               	str	x10, [x1, #0x180]
               	ldr	x10, [x0, #0x188]
               	str	x10, [x1, #0x188]
               	ldr	x10, [x0, #0x190]
               	str	x10, [x1, #0x190]
               	ldr	x10, [x0, #0x198]
               	str	x10, [x1, #0x198]
               	ldr	x10, [x0, #0x1a0]
               	str	x10, [x1, #0x1a0]
               	ldr	x10, [x0, #0x1a8]
               	str	x10, [x1, #0x1a8]
               	ldr	x10, [x0, #0x1b0]
               	str	x10, [x1, #0x1b0]
               	ldr	x10, [x0, #0x1b8]
               	str	x10, [x1, #0x1b8]
               	ldr	x10, [x0, #0x1c0]
               	str	x10, [x1, #0x1c0]
               	ldr	x10, [x0, #0x1c8]
               	str	x10, [x1, #0x1c8]
               	ldr	x10, [x0, #0x1d0]
               	str	x10, [x1, #0x1d0]
               	ldr	x10, [x0, #0x1d8]
               	str	x10, [x1, #0x1d8]
               	ldr	x10, [x0, #0x1e0]
               	str	x10, [x1, #0x1e0]
               	ldr	x10, [x0, #0x1e8]
               	str	x10, [x1, #0x1e8]
               	ldr	x10, [x0, #0x1f0]
               	str	x10, [x1, #0x1f0]
               	ldr	x10, [x0, #0x1f8]
               	str	x10, [x1, #0x1f8]
               	ldr	x10, [x0, #0x200]
               	str	x10, [x1, #0x200]
               	ldrb	w10, [x0, #0x208]
               	strb	w10, [x1, #0x208]
               	ldrb	w10, [x0, #0x209]
               	strb	w10, [x1, #0x209]
               	ldrb	w10, [x0, #0x20a]
               	strb	w10, [x1, #0x20a]
               	ldrb	w10, [x0, #0x20b]
               	strb	w10, [x1, #0x20b]
               	ldr	x10, [sp], #0x10
               	ldrsw	x0, [x1]
               	cmp	w0, #0x64
               	b.ne	<addr>
               	ldrsw	x0, [x1, #0x4]
               	cmp	w0, #0xc8
               	b.ne	<addr>
               	ldrsw	x0, [x1, #0x8]
               	cmp	w0, #0x12c
               	b.ne	<addr>
               	ldrsw	x0, [x1, #0xc]
               	cmp	w0, #0x190
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x420
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x1, #0x1fc]
               	cmp	w0, #0x1f4
               	b.ne	<addr>
               	ldrsw	x0, [x1, #0x200]
               	cmp	w0, #0x258
               	b.ne	<addr>
               	ldrsw	x0, [x1, #0x204]
               	cmp	w0, #0x2bc
               	b.ne	<addr>
               	ldrsw	x0, [x1, #0x208]
               	cmp	w0, #0x320
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x420
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x1, #0xb0]
               	mov	x17, #-0x1              // =-1
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x420
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x1, #0x154]
               	mov	x17, #-0x2              // =-2
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x420
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x1, #0x1f8]
               	mov	x17, #-0x3              // =-3
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x420
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	x2, x1, #0x10
               	ldrsw	x2, [x2, x0, lsl #2]
               	add	x3, x0, #0x3e8
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x2, x1, #0xb4
               	ldrsw	x2, [x2, x0, lsl #2]
               	add	x3, x0, #0x7d0
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x2, x1, #0x158
               	ldrsw	x2, [x2, x0, lsl #2]
               	add	x3, x0, #0xbb8
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x28
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x420
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x0, #0x6e
               	add	sp, sp, #0x420
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x0, #0x3c
               	add	sp, sp, #0x420
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x0, #0xa
               	add	sp, sp, #0x420
               	ldp	x29, x30, [sp], #0x10
               	ret
