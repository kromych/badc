
vfork_shared_stack_slot_reuse.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<stir>:
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x120]
               	eor	x1, x1, #0x1
               	str	w1, [x0, #0x120]
               	ret

<child_exec>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	add	x0, x0, x1
               	add	x0, x0, x2
               	add	x0, x0, x3
               	add	x0, x0, x4
               	add	x0, x0, x5
               	add	x0, x0, x6
               	add	x0, x0, x7
               	ldrsw	x1, [x29, #0x10]
               	add	x0, x0, x1
               	ldrsw	x1, [x29, #0x18]
               	add	x0, x0, x1
               	ldrsw	x1, [x29, #0x20]
               	add	x0, x0, x1
               	ldrsw	x1, [x29, #0x28]
               	add	x0, x0, x1
               	ldrsw	x1, [x29, #0x30]
               	add	x0, x0, x1
               	ldrsw	x1, [x29, #0x38]
               	add	x0, x0, x1
               	ldrsw	x1, [x29, #0x40]
               	add	x0, x0, x1
               	ldrsw	x1, [x29, #0x48]
               	add	x0, x0, x1
               	ldrsw	x1, [x29, #0x50]
               	add	x0, x0, x1
               	ldrsw	x1, [x29, #0x58]
               	add	x0, x0, x1
               	ldrsw	x1, [x29, #0x60]
               	add	x0, x0, x1
               	ldrsw	x1, [x29, #0x68]
               	add	x0, x0, x1
               	and	x0, x0, #0x7f
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x20, x21, [sp, #-0xe0]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	str	x28, [sp, #0x40]
               	stp	x29, x30, [sp, #0xd0]
               	add	x29, sp, #0xd0
               	mov	x0, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x1, x0, #0x1
               	str	w1, [x2, x0, lsl #2]
               	mov	x0, x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x20, x1, x1, lsl #1
               	ldrsw	x1, [x0, #0x4]
               	add	x1, x1, x1, lsl #1
               	add	x21, x1, #0x1
               	ldrsw	x1, [x0, #0x8]
               	add	x1, x1, x1, lsl #1
               	add	x22, x1, #0x2
               	ldrsw	x1, [x0, #0xc]
               	add	x1, x1, x1, lsl #1
               	add	x23, x1, #0x3
               	ldrsw	x1, [x0, #0x10]
               	add	x1, x1, x1, lsl #1
               	add	x24, x1, #0x4
               	ldrsw	x1, [x0, #0x14]
               	add	x1, x1, x1, lsl #1
               	add	x25, x1, #0x5
               	ldrsw	x1, [x0, #0x18]
               	add	x1, x1, x1, lsl #1
               	add	x26, x1, #0x6
               	ldrsw	x1, [x0, #0x1c]
               	add	x1, x1, x1, lsl #1
               	add	x27, x1, #0x7
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, x1, lsl #1
               	add	x28, x1, #0x8
               	ldrsw	x1, [x0, #0x24]
               	add	x1, x1, x1, lsl #1
               	add	x16, x1, #0x9
               	str	x16, [sp, #0xb8]
               	ldrsw	x1, [x0, #0x28]
               	add	x1, x1, x1, lsl #1
               	add	x16, x1, #0xa
               	str	x16, [sp, #0xb0]
               	ldrsw	x0, [x0, #0x2c]
               	add	x0, x0, x0, lsl #1
               	add	x16, x0, #0xb
               	str	x16, [sp, #0xa8]
               	bl	<addr>
               	cmp	w0, #0x0
               	b.ge	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	cbz	w0, <addr>
               	mov	x2, #0x0                // =0
               	stur	w2, [x29, #-0x8]
               	sub	x1, x29, #0x8
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, x1, lsl #1
               	cmp	w20, w1
               	mov	x16, #0x1               // =1
               	csel	x1, x16, xzr, ne
               	ldrsw	x2, [x0, #0x4]
               	add	x2, x2, x2, lsl #1
               	add	x2, x2, #0x1
               	orr	x3, x1, #0x2
               	cmp	w21, w2
               	csel	x1, x3, x1, ne
               	ldrsw	x2, [x0, #0x8]
               	add	x2, x2, x2, lsl #1
               	add	x2, x2, #0x2
               	orr	x3, x1, #0x4
               	cmp	w22, w2
               	csel	x1, x3, x1, ne
               	ldrsw	x2, [x0, #0xc]
               	add	x2, x2, x2, lsl #1
               	add	x2, x2, #0x3
               	orr	x3, x1, #0x8
               	cmp	w23, w2
               	csel	x1, x3, x1, ne
               	ldrsw	x2, [x0, #0x10]
               	add	x2, x2, x2, lsl #1
               	add	x2, x2, #0x4
               	orr	x3, x1, #0x10
               	cmp	w24, w2
               	csel	x1, x3, x1, ne
               	ldrsw	x2, [x0, #0x14]
               	add	x2, x2, x2, lsl #1
               	add	x2, x2, #0x5
               	orr	x3, x1, #0x20
               	cmp	w25, w2
               	csel	x1, x3, x1, ne
               	ldrsw	x2, [x0, #0x18]
               	add	x2, x2, x2, lsl #1
               	add	x2, x2, #0x6
               	orr	x3, x1, #0x40
               	cmp	w26, w2
               	csel	x1, x3, x1, ne
               	ldrsw	x0, [x0, #0x1c]
               	add	x0, x0, x0, lsl #1
               	add	x0, x0, #0x7
               	orr	x2, x1, #0x80
               	cmp	w27, w0
               	csel	x1, x2, x1, ne
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0, #0x20]
               	add	x2, x2, x2, lsl #1
               	add	x2, x2, #0x8
               	orr	x3, x1, #0x100
               	cmp	w28, w2
               	csel	x1, x3, x1, ne
               	ldrsw	x2, [x0, #0x24]
               	add	x2, x2, x2, lsl #1
               	add	x2, x2, #0x9
               	orr	x3, x1, #0x200
               	ldr	x16, [sp, #0xb8]
               	cmp	w16, w2
               	csel	x1, x3, x1, ne
               	ldrsw	x2, [x0, #0x28]
               	add	x2, x2, x2, lsl #1
               	add	x2, x2, #0xa
               	orr	x3, x1, #0x400
               	ldr	x16, [sp, #0xb0]
               	cmp	w16, w2
               	csel	x1, x3, x1, ne
               	ldrsw	x0, [x0, #0x2c]
               	add	x0, x0, x0, lsl #1
               	add	x0, x0, #0xb
               	orr	x2, x1, #0x800
               	ldr	x16, [sp, #0xa8]
               	cmp	w16, w0
               	csel	x1, x2, x1, ne
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0, #0x40]
               	add	x1, x1, x1, lsl #2
               	add	x20, x1, #0x1
               	ldrsw	x1, [x0, #0x44]
               	add	x1, x1, x1, lsl #2
               	add	x21, x1, #0x2
               	ldrsw	x1, [x0, #0x48]
               	add	x1, x1, x1, lsl #2
               	add	x22, x1, #0x3
               	ldrsw	x1, [x0, #0x4c]
               	add	x1, x1, x1, lsl #2
               	add	x23, x1, #0x4
               	ldrsw	x1, [x0, #0x50]
               	add	x1, x1, x1, lsl #2
               	add	x24, x1, #0x5
               	ldrsw	x1, [x0, #0x54]
               	add	x1, x1, x1, lsl #2
               	add	x25, x1, #0x6
               	ldrsw	x1, [x0, #0x58]
               	add	x1, x1, x1, lsl #2
               	add	x26, x1, #0x7
               	ldrsw	x1, [x0, #0x5c]
               	add	x1, x1, x1, lsl #2
               	add	x27, x1, #0x8
               	ldrsw	x1, [x0, #0x60]
               	add	x1, x1, x1, lsl #2
               	add	x28, x1, #0x9
               	ldrsw	x1, [x0, #0x64]
               	add	x1, x1, x1, lsl #2
               	add	x16, x1, #0xa
               	str	x16, [sp, #0xa0]
               	ldrsw	x1, [x0, #0x68]
               	add	x1, x1, x1, lsl #2
               	add	x16, x1, #0xb
               	str	x16, [sp, #0x98]
               	ldrsw	x1, [x0, #0x6c]
               	add	x1, x1, x1, lsl #2
               	add	x16, x1, #0xc
               	str	x16, [sp, #0x90]
               	ldrsw	x1, [x0, #0x70]
               	add	x1, x1, x1, lsl #2
               	add	x16, x1, #0xd
               	str	x16, [sp, #0x88]
               	ldrsw	x1, [x0, #0x74]
               	add	x1, x1, x1, lsl #2
               	add	x16, x1, #0xe
               	str	x16, [sp, #0x80]
               	ldrsw	x1, [x0, #0x78]
               	add	x1, x1, x1, lsl #2
               	add	x16, x1, #0xf
               	str	x16, [sp, #0x78]
               	ldrsw	x1, [x0, #0x7c]
               	add	x1, x1, x1, lsl #2
               	add	x16, x1, #0x10
               	str	x16, [sp, #0x70]
               	ldrsw	x1, [x0, #0x80]
               	add	x1, x1, x1, lsl #2
               	add	x16, x1, #0x11
               	str	x16, [sp, #0x68]
               	ldrsw	x1, [x0, #0x84]
               	add	x1, x1, x1, lsl #2
               	add	x16, x1, #0x12
               	str	x16, [sp, #0x60]
               	ldrsw	x1, [x0, #0x88]
               	add	x1, x1, x1, lsl #2
               	add	x16, x1, #0x13
               	str	x16, [sp, #0x58]
               	ldrsw	x0, [x0, #0x8c]
               	add	x0, x0, x0, lsl #2
               	add	x16, x0, #0x14
               	str	x16, [sp, #0x50]
               	bl	<addr>
               	add	x0, x20, x21
               	add	x0, x0, x22
               	add	x0, x0, x23
               	add	x0, x0, x24
               	add	x0, x0, x25
               	add	x0, x0, x26
               	add	x0, x0, x27
               	add	x0, x0, x28
               	ldr	x17, [sp, #0xa0]
               	add	x0, x0, x17
               	ldr	x17, [sp, #0x98]
               	add	x0, x0, x17
               	ldr	x17, [sp, #0x90]
               	add	x0, x0, x17
               	ldr	x17, [sp, #0x88]
               	add	x0, x0, x17
               	ldr	x17, [sp, #0x80]
               	add	x0, x0, x17
               	ldr	x17, [sp, #0x78]
               	add	x0, x0, x17
               	ldr	x17, [sp, #0x70]
               	add	x0, x0, x17
               	ldr	x17, [sp, #0x68]
               	add	x0, x0, x17
               	ldr	x17, [sp, #0x60]
               	add	x0, x0, x17
               	ldr	x17, [sp, #0x58]
               	add	x0, x0, x17
               	ldr	x17, [sp, #0x50]
               	add	x0, x0, x17
               	and	x0, x0, #0x7f
               	bl	<addr>
               	brk	#0x1
