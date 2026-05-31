
for_init_decl_in_loop.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400480 <.text+0x200>
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
               	bl	0x4005f8 <dlsym>
               	cbz	x0, 0x400394 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x12]
               	b	0x400394 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x21, x19
               	lsl	x0, x20, #3
               	add	x20, x21, x0
               	ldr	x0, [x20]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x8]
               	mov	x14, #0x1               // =1
               	stur	w14, [x29, #-0x10]
               	b	0x4003e8 <.text+0x168>
               	ldursw	x14, [x29, #-0x10]
               	cmp	x14, #0x5
               	b.ge	0x400418 <.text+0x198>
               	b	0x40040c <.text+0x18c>
               	sub	x14, x29, #0x10
               	ldrsw	x15, [x14]
               	add	x13, x15, #0x1
               	str	w13, [x14]
               	b	0x4003e8 <.text+0x168>
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x18]
               	b	0x400428 <.text+0x1a8>
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x13, [x29, #-0x18]
               	cmp	x13, #0x10
               	b.ge	0x40047c <.text+0x1fc>
               	b	0x40044c <.text+0x1cc>
               	sub	x13, x29, #0x18
               	ldrsw	x15, [x13]
               	add	x14, x15, #0x1
               	str	w14, [x13]
               	b	0x400428 <.text+0x1a8>
               	sub	x14, x29, #0x8
               	ldrsw	x15, [x14]
               	ldursw	x13, [x29, #-0x10]
               	mov	x17, #0x64              // =100
               	mul	x12, x13, x17
               	sxtw	x12, w12
               	ldursw	x13, [x29, #-0x18]
               	add	x11, x12, x13
               	sxtw	x11, w11
               	add	x13, x15, x11
               	str	w13, [x14]
               	b	0x400438 <.text+0x1b8>
               	b	0x4003f8 <.text+0x178>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	0x4003c8 <.text+0x148>
               	mov	x17, #0x4060            // =16480
               	cmp	x0, x17
               	b.eq	0x4004a4 <.text+0x224>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x0               // =0
               	mov	x0, x14
               	ldp	x29, x30, [sp], #0x10
               	ret
