
comma_operator_in_loops.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x40040c <.text+0x18c>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xe8]
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
               	add	x19, x19, #0xf8
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x12, x14, x13
               	ldr	x13, [x12]
               	cbz	x13, 0x40030c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
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
               	add	x19, x19, #0x110
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x12, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x116
               	mov	x11, x19
               	str	x11, [x12]
               	sub	x14, x29, #0x18
               	add	x11, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x11d
               	mov	x14, x19
               	str	x14, [x11]
               	sub	x12, x29, #0x18
               	lsl	x14, x20, #3
               	add	x11, x12, x14
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x400708 <dlsym>
               	mov	x11, x0
               	cbz	x11, 0x400398 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x11]
               	str	x21, [x12]
               	b	0x400398 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
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
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	sxtw	x0, w0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x148
               	mov	x14, x19
               	ldrsw	x13, [x14]
               	add	x12, x13, #0x1
               	str	w12, [x14]
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x19, [sp, #0x20]
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x8]
               	stur	w15, [x29, #-0x10]
               	b	0x40043c <.text+0x1bc>
               	sub	x15, x29, #0x10
               	ldrsw	x14, [x15]
               	add	x13, x14, #0xa
               	str	w13, [x15]
               	b	0x400450 <.text+0x1d0>
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	bl	0x4003d0 <.text+0x150>
               	mov	x14, x0
               	cbnz	x20, 0x40043c <.text+0x1bc>
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	bl	0x4003d0 <.text+0x150>
               	mov	x20, x0
               	mov	x20, #0x1               // =1
               	cbz	x20, 0x400490 <.text+0x210>
               	sub	x21, x29, #0x10
               	ldrsw	x20, [x21]
               	add	x15, x20, #0x64
               	str	w15, [x21]
               	b	0x400490 <.text+0x210>
               	mov	x22, #0x7               // =7
               	mov	x0, x22
               	bl	0x4003d0 <.text+0x150>
               	mov	x20, x0
               	mov	x20, #0x2               // =2
               	b	0x4004f8 <.text+0x278>
               	mov	x20, #0x0               // =0
               	stur	w20, [x29, #-0x8]
               	b	0x40050c <.text+0x28c>
               	sub	x22, x29, #0x10
               	ldrsw	x21, [x22]
               	add	x20, x21, #0x1
               	str	w20, [x22]
               	b	0x4004a8 <.text+0x228>
               	sub	x20, x29, #0x10
               	ldrsw	x21, [x20]
               	add	x22, x21, #0x3e8
               	str	w22, [x20]
               	b	0x4004a8 <.text+0x228>
               	sub	x22, x29, #0x10
               	ldrsw	x21, [x22]
               	mov	x17, #0x869f            // =34463
               	movk	x17, #0x1, lsl #16
               	add	x20, x21, x17
               	str	w20, [x22]
               	b	0x4004a8 <.text+0x228>
               	cmp	x20, #0x1
               	b.eq	0x4004b4 <.text+0x234>
               	cmp	x20, #0x2
               	b.eq	0x4004c8 <.text+0x248>
               	b	0x4004dc <.text+0x25c>
               	mov	x23, #0x0               // =0
               	mov	x0, x23
               	bl	0x4003d0 <.text+0x150>
               	mov	x21, x0
               	ldursw	x21, [x29, #-0x8]
               	cmp	x21, #0x3
               	b.ge	0x400554 <.text+0x2d4>
               	b	0x400540 <.text+0x2c0>
               	sub	x21, x29, #0x8
               	ldrsw	x23, [x21]
               	add	x22, x23, #0x1
               	str	w22, [x21]
               	b	0x40050c <.text+0x28c>
               	sub	x22, x29, #0x10
               	ldrsw	x23, [x22]
               	add	x21, x23, #0x1
               	str	w21, [x22]
               	b	0x40052c <.text+0x2ac>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x148
               	mov	x21, x19
               	ldrsw	x23, [x21]
               	cmp	x23, #0x7
               	b.eq	0x400594 <.text+0x314>
               	mov	x23, #0x1               // =1
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x21, [x29, #-0x10]
               	sub	x23, x21, #0x456
               	sxtw	x23, w23
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
