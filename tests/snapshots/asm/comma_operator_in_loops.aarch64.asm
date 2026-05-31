
comma_operator_in_loops.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400408 <.text+0x188>
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
               	add	x14, x14, x13
               	ldr	x13, [x14]
               	cbz	x13, 0x40030c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
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
               	add	x11, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x116
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x11d
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x4006e8 <dlsym>
               	cbz	x0, 0x400394 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x22]
               	b	0x400394 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x21, x19
               	lsl	x20, x20, #3
               	add	x21, x21, x20
               	ldr	x20, [x21]
               	mov	x0, x20
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
               	add	x13, x13, #0x1
               	str	w13, [x14]
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
               	str	x19, [sp, #0x20]
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x8]
               	stur	w15, [x29, #-0x10]
               	b	0x400434 <.text+0x1b4>
               	sub	x15, x29, #0x10
               	ldrsw	x14, [x15]
               	add	x14, x14, #0xa
               	str	w14, [x15]
               	b	0x400448 <.text+0x1c8>
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	bl	0x4003cc <.text+0x14c>
               	cbnz	x20, 0x400434 <.text+0x1b4>
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	bl	0x4003cc <.text+0x14c>
               	mov	x0, #0x1                // =1
               	cbz	x0, 0x400480 <.text+0x200>
               	sub	x21, x29, #0x10
               	ldrsw	x0, [x21]
               	add	x0, x0, #0x64
               	str	w0, [x21]
               	b	0x400480 <.text+0x200>
               	mov	x20, #0x7               // =7
               	mov	x0, x20
               	bl	0x4003cc <.text+0x14c>
               	mov	x0, #0x2                // =2
               	b	0x4004e4 <.text+0x264>
               	mov	x20, #0x0               // =0
               	stur	w20, [x29, #-0x8]
               	b	0x4004f8 <.text+0x278>
               	sub	x20, x29, #0x10
               	ldrsw	x0, [x20]
               	add	x0, x0, #0x1
               	str	w0, [x20]
               	b	0x400494 <.text+0x214>
               	sub	x0, x29, #0x10
               	ldrsw	x21, [x0]
               	add	x21, x21, #0x3e8
               	str	w21, [x0]
               	b	0x400494 <.text+0x214>
               	sub	x21, x29, #0x10
               	ldrsw	x20, [x21]
               	mov	x17, #0x869f            // =34463
               	movk	x17, #0x1, lsl #16
               	add	x20, x20, x17
               	str	w20, [x21]
               	b	0x400494 <.text+0x214>
               	cmp	x0, #0x1
               	b.eq	0x4004a0 <.text+0x220>
               	cmp	x0, #0x2
               	b.eq	0x4004b4 <.text+0x234>
               	b	0x4004c8 <.text+0x248>
               	mov	x22, #0x0               // =0
               	mov	x0, x22
               	bl	0x4003cc <.text+0x14c>
               	ldursw	x0, [x29, #-0x8]
               	cmp	x0, #0x3
               	b.ge	0x40053c <.text+0x2bc>
               	b	0x400528 <.text+0x2a8>
               	sub	x22, x29, #0x8
               	ldrsw	x0, [x22]
               	add	x0, x0, #0x1
               	str	w0, [x22]
               	b	0x4004f8 <.text+0x278>
               	sub	x0, x29, #0x10
               	ldrsw	x21, [x0]
               	add	x21, x21, #0x1
               	str	w21, [x0]
               	b	0x400514 <.text+0x294>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x148
               	mov	x21, x19
               	ldrsw	x22, [x21]
               	cmp	x22, #0x7
               	b.eq	0x400578 <.text+0x2f8>
               	mov	x21, #0x1               // =1
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x22, [x29, #-0x10]
               	sub	x22, x22, #0x456
               	sxtw	x22, w22
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
