
switch_break_calls.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4002f4 <.text+0xd4>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	mov	x0, #0x64               // =100
               	ret
               	mov	x0, #0xc8               // =200
               	ret
               	mov	x0, #0x12c              // =300
               	ret
               	mov	x0, #0x190              // =400
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	sxtw	x15, w0
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x8]
               	b	0x4002d8 <.text+0xb8>
               	ldursw	x14, [x29, #-0x8]
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	0x400238 <.text+0x18>
               	mov	x14, x0
               	stur	w14, [x29, #-0x8]
               	b	0x40027c <.text+0x5c>
               	bl	0x400240 <.text+0x20>
               	mov	x14, x0
               	stur	w14, [x29, #-0x8]
               	b	0x40027c <.text+0x5c>
               	bl	0x400248 <.text+0x28>
               	mov	x14, x0
               	stur	w14, [x29, #-0x8]
               	b	0x40027c <.text+0x5c>
               	bl	0x400250 <.text+0x30>
               	mov	x14, x0
               	stur	w14, [x29, #-0x8]
               	b	0x40027c <.text+0x5c>
               	cmp	x15, #0x0
               	b.eq	0x400298 <.text+0x78>
               	cmp	x15, #0x1
               	b.eq	0x4002a8 <.text+0x88>
               	cmp	x15, #0x2
               	b.eq	0x4002b8 <.text+0x98>
               	b	0x4002c8 <.text+0xa8>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x20, [sp]
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	bl	0x400258 <.text+0x38>
               	mov	x14, x0
               	mov	x0, x14
               	ldr	x20, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
