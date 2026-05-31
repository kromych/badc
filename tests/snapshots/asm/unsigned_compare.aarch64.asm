
unsigned_compare.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400410 <.text+0x150>
               	adrp	x16, 0x410000
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
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x12, x14, x13
               	ldr	x13, [x12]
               	cbz	x13, 0x40034c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x12, x19
               	lsl	x13, x20, #3
               	add	x14, x12, x13
               	ldr	x13, [x14]
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x21, #0x0               // =0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x118
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x12, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x11e
               	mov	x11, x19
               	str	x11, [x12]
               	sub	x14, x29, #0x18
               	add	x11, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x125
               	mov	x14, x19
               	str	x14, [x11]
               	sub	x12, x29, #0x18
               	lsl	x14, x20, #3
               	add	x11, x12, x14
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x400a48 <dlsym>
               	mov	x11, x0
               	cbz	x11, 0x4003d8 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x11]
               	str	x21, [x12]
               	b	0x4003d8 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x21, x19
               	lsl	x11, x20, #3
               	add	x20, x21, x11
               	ldr	x11, [x20]
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xb0
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x19, [sp, #0x30]
               	mov	x20, #0x1               // =1
               	mov	x21, #0xfffe            // =65534
               	movk	x21, #0xffff, lsl #16
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x21, x17
               	cmp	x13, x12
               	b.ls	0x4004b0 <.text+0x1f0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x22, x19
               	mov	x0, x22
               	bl	0x400a54 <printf>
               	sxtw	x0, w0
               	mov	x11, x0
               	mov	x11, #0x1               // =1
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x11, x20, x17
               	cmp	x22, x11
               	cset	x20, hi
               	cmp	x20, #0x0
               	b.ne	0x400524 <.text+0x264>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x172
               	mov	x23, x19
               	mov	x0, x23
               	bl	0x400a54 <printf>
               	sxtw	x0, w0
               	mov	x11, x0
               	mov	x11, #0x1               // =1
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x1               // =1
               	mov	x23, #0xfffe            // =65534
               	movk	x23, #0xffff, lsl #16
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x23, x17
               	cmp	x22, x21
               	b.ls	0x40059c <.text+0x2dc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x194
               	mov	x24, x19
               	mov	x0, x24
               	bl	0x400a54 <printf>
               	sxtw	x0, w0
               	mov	x13, x0
               	mov	x13, #0x1               // =1
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x23, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x20, x17
               	cmp	x24, x13
               	cset	x20, hi
               	cmp	x20, #0x0
               	b.ne	0x400610 <.text+0x350>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b7
               	mov	x21, x19
               	mov	x0, x21
               	bl	0x400a54 <printf>
               	sxtw	x0, w0
               	mov	x13, x0
               	mov	x13, #0x1               // =1
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x1               // =1
               	mov	x21, #0xfffe            // =65534
               	movk	x21, #0xffff, lsl #16
               	movk	x21, #0xffff, lsl #32
               	movk	x21, #0xffff, lsl #48
               	cmp	x20, x21
               	b.ls	0x400678 <.text+0x3b8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1da
               	mov	x25, x19
               	mov	x0, x25
               	bl	0x400a54 <printf>
               	sxtw	x0, w0
               	mov	x24, x0
               	mov	x24, #0x1               // =1
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x21, x20
               	cset	x25, hi
               	cmp	x25, #0x0
               	b.ne	0x4006d4 <.text+0x414>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1fc
               	mov	x23, x19
               	mov	x0, x23
               	bl	0x400a54 <printf>
               	sxtw	x0, w0
               	mov	x21, x0
               	mov	x21, #0x1               // =1
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x25, #0x1               // =1
               	mov	x23, #0xfffe            // =65534
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	cmp	x25, x23
               	b.lo	0x40073c <.text+0x47c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x21e
               	mov	x21, x19
               	mov	x0, x21
               	bl	0x400a54 <printf>
               	sxtw	x0, w0
               	mov	x20, x0
               	mov	x20, #0x1               // =1
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x23, x25
               	cset	x21, hs
               	cmp	x21, #0x0
               	b.ne	0x400798 <.text+0x4d8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x243
               	mov	x24, x19
               	mov	x0, x24
               	bl	0x400a54 <printf>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x23, #0x1               // =1
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x24, #0x0               // =0
               	mov	x23, #0xfe              // =254
               	mov	x17, #0xff              // =255
               	and	x25, x23, x17
               	mov	x17, #0xff              // =255
               	and	x23, x24, x17
               	cmp	x25, x23
               	b.gt	0x400804 <.text+0x544>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x268
               	mov	x21, x19
               	mov	x0, x21
               	bl	0x400a54 <printf>
               	sxtw	x0, w0
               	mov	x24, x0
               	mov	x24, #0x1               // =1
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x23, #0x1               // =1
               	mov	x21, #0xfffe            // =65534
               	movk	x21, #0xffff, lsl #16
               	movk	x21, #0xffff, lsl #32
               	movk	x21, #0xffff, lsl #48
               	sxtw	x25, w23
               	sxtw	x20, w21
               	cmp	x25, x20
               	cset	x22, gt
               	cmp	x22, #0x0
               	b.ne	0x40087c <.text+0x5bc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x287
               	mov	x24, x19
               	mov	x0, x24
               	bl	0x400a54 <printf>
               	sxtw	x0, w0
               	mov	x20, x0
               	mov	x20, #0x1               // =1
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x24, w23
               	sxtw	x20, w21
               	cmp	x24, x20
               	b.ge	0x4008d8 <.text+0x618>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x29c
               	mov	x22, x19
               	mov	x0, x22
               	bl	0x400a54 <printf>
               	sxtw	x0, w0
               	mov	x21, x0
               	mov	x21, #0x1               // =1
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x0               // =0
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
