
integer_ops_exhaustive.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xf0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sxtw	x20, w0
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x13, [x14]
               	cbz	x13, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x0, [x14]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x21, #0x0               // =0
               	adrp	x19, <page>
               	add	x19, x19, #0x118
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x11e
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, <page>
               	add	x19, x19, #0x125
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x22]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x21, x19
               	lsl	x20, x20, #3
               	add	x21, x21, x20
               	ldr	x0, [x21]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x150
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x26, [sp, #0x30]
               	str	x27, [sp, #0x38]
               	str	x19, [sp, #0x40]
               	mov	x20, #0xfffe            // =65534
               	movk	x20, #0xffff, lsl #16
               	mov	x21, #0x1               // =1
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x21, x17
               	cmp	x13, x12
               	cset	x13, hi
               	cmp	x13, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x23, #0x0               // =0
               	cbnz	x23, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x150
               	mov	x22, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x15a
               	mov	x23, x19
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x20, x17
               	cmp	x0, x23
               	cset	x0, lo
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x23, #0x0               // =0
               	cbnz	x23, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x16d
               	mov	x24, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x177
               	mov	x23, x19
               	mov	x0, x24
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x21, x17
               	cmp	x0, x23
               	cset	x0, hs
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x23, #0x0               // =0
               	cbnz	x23, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x18a
               	mov	x22, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x194
               	mov	x23, x19
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x20, x17
               	cmp	x0, x23
               	cset	x0, ls
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x23, #0x0               // =0
               	cbnz	x23, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a8
               	mov	x24, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1b2
               	mov	x23, x19
               	mov	x0, x24
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x21, x17
               	cmp	x0, x23
               	cset	x0, ne
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x23, #0x0               // =0
               	cbnz	x23, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c6
               	mov	x22, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x21, x17
               	cmp	x0, x23
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x23, #0x0               // =0
               	cbnz	x23, <addr>
               	mov	x22, #0xfffe            // =65534
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
               	mov	x25, #0x1               // =1
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1e4
               	mov	x24, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1ee
               	mov	x23, x19
               	mov	x0, x24
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	sxtw	x21, w22
               	sxtw	x20, w25
               	cmp	x21, x20
               	cset	x21, lt
               	cmp	x21, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x20, #0x0               // =0
               	cbnz	x20, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x202
               	mov	x23, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x20c
               	mov	x20, x19
               	mov	x0, x23
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	sxtw	x0, w25
               	sxtw	x20, w22
               	cmp	x0, x20
               	cset	x0, gt
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x20, #0x0               // =0
               	cbnz	x20, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x217
               	mov	x24, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x221
               	mov	x20, x19
               	mov	x0, x24
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	sxtw	x0, w22
               	sxtw	x20, w25
               	cmp	x0, x20
               	cset	x0, le
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x20, #0x0               // =0
               	cbnz	x20, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x22c
               	mov	x23, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x236
               	mov	x20, x19
               	mov	x0, x23
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	sxtw	x0, w25
               	sxtw	x20, w22
               	cmp	x0, x20
               	cset	x0, ge
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x20, #0x0               // =0
               	cbnz	x20, <addr>
               	mov	x23, #0xfffe            // =65534
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	mov	x21, #0x1               // =1
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x242
               	mov	x24, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x24c
               	mov	x20, x19
               	mov	x0, x24
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x23, x21
               	cset	x25, hi
               	cmp	x25, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x22, #0x0               // =0
               	cbnz	x22, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x258
               	mov	x20, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x262
               	mov	x22, x19
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x23, x21
               	cset	x0, hs
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x22, #0x0               // =0
               	cbnz	x22, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x26f
               	mov	x24, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x279
               	mov	x22, x19
               	mov	x0, x24
               	mov	x1, x22
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x21, x23
               	cset	x0, lo
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x22, #0x0               // =0
               	cbnz	x22, <addr>
               	mov	x24, #0xfffe            // =65534
               	movk	x24, #0xffff, lsl #16
               	movk	x24, #0xffff, lsl #32
               	movk	x24, #0xffff, lsl #48
               	mov	x25, #0x1               // =1
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x287
               	mov	x20, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x291
               	mov	x22, x19
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x25, x24
               	cset	x21, gt
               	cmp	x21, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x23, #0x0               // =0
               	cbnz	x23, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x29e
               	mov	x22, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x2a8
               	mov	x23, x19
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	cmp	x24, #0x0
               	cset	x0, lt
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x23, #0x0               // =0
               	cbnz	x23, <addr>
               	mov	x25, #0xfe              // =254
               	mov	x21, #0x1               // =1
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x2b3
               	mov	x20, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x2bd
               	mov	x23, x19
               	mov	x0, x20
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x17, #0xff              // =255
               	and	x24, x25, x17
               	mov	x17, #0xff              // =255
               	and	x20, x21, x17
               	cmp	x24, x20
               	cset	x24, gt
               	cmp	x24, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x20, #0x0               // =0
               	cbnz	x20, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x2c8
               	mov	x23, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x2d2
               	mov	x20, x19
               	mov	x0, x23
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x17, #0xff              // =255
               	and	x0, x21, x17
               	mov	x17, #0xff              // =255
               	and	x20, x25, x17
               	cmp	x0, x20
               	cset	x0, lt
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x20, #0x0               // =0
               	cbnz	x20, <addr>
               	mov	x23, #0xfffe            // =65534
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	mov	x24, #0x1               // =1
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x2de
               	mov	x22, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x2e8
               	mov	x20, x19
               	mov	x0, x22
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	sxtb	x21, w23
               	sxtb	x25, w24
               	cmp	x21, x25
               	cset	x21, lt
               	cmp	x21, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x25, #0x0               // =0
               	cbnz	x25, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x2f4
               	mov	x20, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x2fe
               	mov	x25, x19
               	mov	x0, x20
               	mov	x1, x25
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	sxtb	x0, w24
               	sxtb	x25, w23
               	cmp	x0, x25
               	cset	x0, gt
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x25, #0x0               // =0
               	cbnz	x25, <addr>
               	mov	x0, #0x64               // =100
               	stur	w0, [x29, #-0x68]
               	sub	x25, x29, #0x68
               	ldr	w0, [x25]
               	add	x0, x0, #0x5
               	str	w0, [x25]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x308
               	mov	x22, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x312
               	mov	x25, x19
               	mov	x0, x22
               	mov	x1, x25
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	ldur	w0, [x29, #-0x68]
               	mov	x17, #0x69              // =105
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x24, #0x0               // =0
               	cbnz	x24, <addr>
               	sub	x0, x29, #0x68
               	ldr	w24, [x0]
               	sub	x24, x24, #0xa
               	str	w24, [x0]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x31c
               	mov	x20, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x326
               	mov	x24, x19
               	mov	x0, x20
               	mov	x1, x24
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	ldur	w24, [x29, #-0x68]
               	mov	x17, #0x5f              // =95
               	eor	x24, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x24, x17
               	cmp	x24, #0x0
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x20, #0x0               // =0
               	cbnz	x20, <addr>
               	sub	x0, x29, #0x68
               	ldr	w20, [x0]
               	lsl	x20, x20, #1
               	str	w20, [x0]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x32f
               	mov	x25, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x339
               	mov	x20, x19
               	mov	x0, x25
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	ldur	w20, [x29, #-0x68]
               	mov	x17, #0xbe              // =190
               	eor	x20, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x20, x17
               	cmp	x20, #0x0
               	cset	x20, eq
               	cmp	x20, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x25, #0x0               // =0
               	cbnz	x25, <addr>
               	sub	x0, x29, #0x68
               	ldr	w25, [x0]
               	mov	x24, #0x5               // =5
               	udiv	x25, x25, x24
               	str	w25, [x0]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x343
               	mov	x24, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x34d
               	mov	x25, x19
               	mov	x0, x24
               	mov	x1, x25
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	ldur	w25, [x29, #-0x68]
               	mov	x17, #0x26              // =38
               	eor	x25, x25, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x25, x17
               	cmp	x25, #0x0
               	cset	x25, eq
               	cmp	x25, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x24, #0x0               // =0
               	cbnz	x24, <addr>
               	sub	x0, x29, #0x68
               	ldr	w24, [x0]
               	mov	x20, #0x7               // =7
               	udiv	x17, x24, x20
               	msub	x24, x17, x20, x24
               	str	w24, [x0]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x356
               	mov	x20, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x360
               	mov	x24, x19
               	mov	x0, x20
               	mov	x1, x24
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	ldur	w24, [x29, #-0x68]
               	mov	x17, #0x3               // =3
               	eor	x24, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x24, x17
               	cmp	x24, #0x0
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x20, #0x0               // =0
               	cbnz	x20, <addr>
               	mov	x0, #0x1                // =1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	sub	x0, x0, #0x2
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x0, x17
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x369
               	mov	x25, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x373
               	mov	x20, x19
               	mov	x0, x25
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x25, #0x0               // =0
               	cbnz	x25, <addr>
               	mov	x0, #0x3e8              // =1000
               	stur	x0, [x29, #-0x78]
               	sub	x25, x29, #0x78
               	ldr	x0, [x25]
               	add	x0, x0, #0x19f
               	str	x0, [x25]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x37c
               	mov	x20, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x386
               	mov	x25, x19
               	mov	x0, x20
               	mov	x1, x25
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	ldur	x0, [x29, #-0x78]
               	cmp	x0, #0x587
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x24, #0x0               // =0
               	cbnz	x24, <addr>
               	sub	x0, x29, #0x78
               	ldr	x24, [x0]
               	mov	x17, #0x3               // =3
               	mul	x24, x24, x17
               	str	x24, [x0]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x394
               	mov	x23, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x39e
               	mov	x24, x19
               	mov	x0, x23
               	mov	x1, x24
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	ldur	x24, [x29, #-0x78]
               	mov	x17, #0x1095            // =4245
               	cmp	x24, x17
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x23, #0x0               // =0
               	cbnz	x23, <addr>
               	sub	x0, x29, #0x78
               	ldr	x23, [x0]
               	mov	x25, #0x5               // =5
               	udiv	x23, x23, x25
               	str	x23, [x0]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x3a9
               	mov	x25, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x3b3
               	mov	x23, x19
               	mov	x0, x25
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	ldur	x23, [x29, #-0x78]
               	cmp	x23, #0x351
               	cset	x23, eq
               	cmp	x23, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x25, #0x0               // =0
               	cbnz	x25, <addr>
               	mov	x0, #0xff00             // =65280
               	movk	x0, #0xff00, lsl #16
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	mov	x17, #0xf0f             // =3855
               	movk	x17, #0xf0f, lsl #16
               	and	x23, x0, x17
               	mov	x17, #0xf000            // =61440
               	movk	x17, #0xf, lsl #16
               	orr	x25, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	eor	x24, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x0, x17
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x3bc
               	mov	x24, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x3c6
               	mov	x25, x19
               	mov	x0, x24
               	mov	x1, x25
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x23, x17
               	mov	x17, #0xf00             // =3840
               	movk	x17, #0xf00, lsl #16
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x21, #0x0               // =0
               	cbnz	x21, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x3cf
               	mov	x22, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x3d9
               	mov	x21, x19
               	mov	x0, x22
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x25, x17
               	mov	x17, #0xff00            // =65280
               	movk	x17, #0xff0f, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x21, #0x0               // =0
               	cbnz	x21, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x3df
               	mov	x26, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x3e9
               	mov	x21, x19
               	mov	x0, x26
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x24, x17
               	mov	x17, #0xff              // =255
               	movk	x17, #0xff, lsl #16
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x21, #0x0               // =0
               	cbnz	x21, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x3ef
               	mov	x23, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x3f9
               	mov	x21, x19
               	mov	x0, x23
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x20, x17
               	mov	x17, #0xff              // =255
               	movk	x17, #0xff, lsl #16
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x21, #0x0               // =0
               	cbnz	x21, <addr>
               	mov	x0, #0x5678             // =22136
               	movk	x0, #0x1234, lsl #16
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	lsl	x0, x0, #4
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x0, x17
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x3ff
               	mov	x25, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x409
               	mov	x21, x19
               	mov	x0, x25
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x24, x17
               	mov	x17, #0x6780            // =26496
               	movk	x17, #0x2345, lsl #16
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x20, #0x0               // =0
               	cbnz	x20, <addr>
               	mov	x0, #0x1                // =1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	lsl	x0, x0, #31
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x0, x17
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x40f
               	mov	x21, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x419
               	mov	x20, x19
               	mov	x0, x21
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x25, x17
               	mov	x17, #0x80000000        // =2147483648
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x24, #0x0               // =0
               	cbnz	x24, <addr>
               	mov	x21, #0x1               // =1
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x422
               	mov	x20, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x42c
               	mov	x24, x19
               	mov	x0, x20
               	mov	x1, x24
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	lsl	x24, x21, #63
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x24, x17
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x25, #0x0               // =0
               	cbnz	x25, <addr>
               	mov	x20, #0xffff            // =65535
               	movk	x20, #0xffff, lsl #16
               	movk	x20, #0xffff, lsl #32
               	movk	x20, #0xffff, lsl #48
               	mov	x24, #0x1               // =1
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x436
               	mov	x27, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x440
               	mov	x25, x19
               	mov	x0, x27
               	mov	x1, x25
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	sxtw	x21, w20
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x27, x24, x17
               	cmp	x21, x27
               	cset	x21, hi
               	cmp	x21, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x27, #0x0               // =0
               	cbnz	x27, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x44a
               	mov	x25, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x454
               	mov	x27, x19
               	mov	x0, x25
               	mov	x1, x27
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	sxtw	x0, w20
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x27, x24, x17
               	sxtw	x27, w27
               	cmp	x0, x27
               	cset	x0, lt
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x27, #0x0               // =0
               	cbnz	x27, <addr>
               	mov	x0, #0xfffe             // =65534
               	movk	x0, #0xffff, lsl #16
               	stur	w0, [x29, #-0xe0]
               	sub	x27, x29, #0xe0
               	ldr	w0, [x27]
               	add	x0, x0, #0x1
               	str	w0, [x27]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x460
               	mov	x23, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x46a
               	mov	x27, x19
               	mov	x0, x23
               	mov	x1, x27
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	ldur	w0, [x29, #-0xe0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x24, #0x0               // =0
               	cbnz	x24, <addr>
               	sub	x0, x29, #0xe0
               	ldr	w24, [x0]
               	add	x24, x24, #0x1
               	str	w24, [x0]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x475
               	mov	x25, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x47f
               	mov	x24, x19
               	mov	x0, x25
               	mov	x1, x24
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	ldur	w24, [x29, #-0xe0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x24, x17
               	cmp	x24, #0x0
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x25, #0x0               // =0
               	cbnz	x25, <addr>
               	mov	x0, #0xfe               // =254
               	sturb	w0, [x29, #-0xe8]
               	sub	x25, x29, #0xe8
               	ldrb	w0, [x25]
               	add	x0, x0, #0x1
               	strb	w0, [x25]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x48e
               	mov	x27, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x498
               	mov	x25, x19
               	mov	x0, x27
               	mov	x1, x25
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	ldurb	w0, [x29, #-0xe8]
               	mov	x17, #0xff              // =255
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x27, #0x0               // =0
               	cbnz	x27, <addr>
               	sub	x0, x29, #0xe8
               	ldrb	w27, [x0]
               	add	x27, x27, #0x1
               	strb	w27, [x0]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x4aa
               	mov	x24, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x4b4
               	mov	x27, x19
               	mov	x0, x24
               	mov	x1, x27
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	ldurb	w27, [x29, #-0xe8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x27, x27, x17
               	cmp	x27, #0x0
               	cset	x27, eq
               	cmp	x27, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x24, #0x0               // =0
               	cbnz	x24, <addr>
               	mov	x0, #0xfffe             // =65534
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	stur	x0, [x29, #-0xf0]
               	sub	x24, x29, #0xf0
               	ldr	x0, [x24]
               	add	x0, x0, #0x1
               	str	x0, [x24]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x4c7
               	mov	x25, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x4d1
               	mov	x24, x19
               	mov	x0, x25
               	mov	x1, x24
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	ldur	x0, [x29, #-0xf0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x25, #0x0               // =0
               	cbnz	x25, <addr>
               	sub	x0, x29, #0xf0
               	ldr	x25, [x0]
               	add	x25, x25, #0x1
               	str	x25, [x0]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x4e2
               	mov	x27, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x4ec
               	mov	x25, x19
               	mov	x0, x27
               	mov	x1, x25
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	ldur	x25, [x29, #-0xf0]
               	cmp	x25, #0x0
               	cset	x25, eq
               	cmp	x25, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x27, #0x0               // =0
               	cbnz	x27, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x4fb
               	mov	x24, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x505
               	mov	x27, x19
               	mov	x0, x24
               	mov	x1, x27
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x27, #0x0               // =0
               	cbnz	x27, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x517
               	mov	x25, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x521
               	mov	x27, x19
               	mov	x0, x25
               	mov	x1, x27
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x27, #0x0               // =0
               	cbnz	x27, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x52c
               	mov	x24, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x536
               	mov	x27, x19
               	mov	x0, x24
               	mov	x1, x27
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x27, #0x0               // =0
               	cbnz	x27, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x544
               	mov	x25, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x54e
               	mov	x27, x19
               	mov	x0, x25
               	mov	x1, x27
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x27, #0x0               // =0
               	cbnz	x27, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x55a
               	mov	x24, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x564
               	mov	x27, x19
               	mov	x0, x24
               	mov	x1, x27
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x27, #0x0               // =0
               	cbnz	x27, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x570
               	mov	x25, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x57a
               	mov	x27, x19
               	mov	x0, x25
               	mov	x1, x27
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x27, #0x0               // =0
               	cbnz	x27, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x586
               	mov	x24, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x590
               	mov	x27, x19
               	mov	x0, x24
               	mov	x1, x27
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x27, #0x0               // =0
               	cbnz	x27, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x5a4
               	mov	x25, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x5ae
               	mov	x27, x19
               	mov	x0, x25
               	mov	x1, x27
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x27, #0x0               // =0
               	cbnz	x27, <addr>
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x5ba
               	mov	x24, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x5c4
               	mov	x27, x19
               	mov	x0, x24
               	mov	x1, x27
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
