
mul_pow2_to_shift.aarch64:	file format elf64-littleaarch64

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
               	bl	0x4006a8 <dlsym>
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
               	str	x19, [sp, #0x10]
               	mov	x15, #0x7               // =7
               	sxtw	x14, w15
               	lsl	x13, x14, #1
               	sxtw	x13, w13
               	lsl	x12, x14, #2
               	sxtw	x12, w12
               	lsl	x11, x14, #3
               	sxtw	x11, w11
               	lsl	x10, x14, #4
               	sxtw	x10, w10
               	lsl	x9, x14, #10
               	sxtw	x9, w9
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x15, x17
               	lsl	x8, x14, #1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x7, x8, x17
               	lsl	x8, x14, #8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x8, x17
               	lsl	x8, x15, #5
               	lsl	x6, x15, #16
               	sxtw	x15, w13
               	sxtw	x13, w12
               	add	x12, x15, x13
               	sxtw	x12, w12
               	sxtw	x13, w11
               	add	x11, x12, x13
               	sxtw	x11, w11
               	sxtw	x13, w10
               	add	x10, x11, x13
               	sxtw	x10, w10
               	sxtw	x13, w9
               	add	x9, x10, x13
               	sxtw	x9, w9
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x7, x17
               	add	x7, x9, x13
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x7, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x7, x14, x17
               	add	x14, x13, x7
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x7, x14, x17
               	add	x14, x7, x8
               	add	x20, x14, x6
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x21, x19
               	mov	x0, x21
               	mov	x1, x20
               	bl	0x4006b4 <printf>
               	sxtw	x0, w0
               	mov	x6, x0
               	mov	x17, #0x24c0            // =9408
               	movk	x17, #0x7, lsl #16
               	cmp	x20, x17
               	b.ne	0x40053c <.text+0x27c>
               	mov	x20, #0x0               // =0
               	stur	x20, [x29, #-0x88]
               	b	0x400548 <.text+0x288>
               	mov	x20, #0x1               // =1
               	stur	x20, [x29, #-0x88]
               	b	0x400548 <.text+0x288>
               	ldur	x20, [x29, #-0x88]
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
