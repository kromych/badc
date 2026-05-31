
switch_goto_label_into_case.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4002f8 <.text+0xd8>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sxtw	x15, w0
               	b	0x4002a8 <.text+0x88>
               	mov	x15, #0x0               // =0
               	mov	x0, x15
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x14              // =20
               	mov	x0, x13
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1e               // =30
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x15, #0x5
               	cset	x13, ge
               	stur	x13, [x29, #-0x8]
               	cbz	x13, 0x4002dc <.text+0xbc>
               	b	0x4002cc <.text+0xac>
               	cmp	x15, #0x1
               	b.eq	0x400260 <.text+0x40>
               	cmp	x15, #0x2
               	b.eq	0x400270 <.text+0x50>
               	cmp	x15, #0x3
               	b.eq	0x400284 <.text+0x64>
               	cmp	x15, #0x4
               	b.eq	0x400284 <.text+0x64>
               	b	0x400294 <.text+0x74>
               	cmp	x15, #0x8
               	cset	x15, le
               	stur	x15, [x29, #-0x8]
               	b	0x4002dc <.text+0xbc>
               	ldur	x15, [x29, #-0x8]
               	cbz	x15, 0x4002e8 <.text+0xc8>
               	b	0x400284 <.text+0x64>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	mov	x20, #0x1               // =1
               	mov	x0, x20
               	bl	0x400238 <.text+0x18>
               	cmp	x0, #0xa
               	b.eq	0x40033c <.text+0x11c>
               	mov	x20, #0x1               // =1
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400238 <.text+0x18>
               	cmp	x0, #0x14
               	b.eq	0x40036c <.text+0x14c>
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x3               // =3
               	mov	x0, x20
               	bl	0x400238 <.text+0x18>
               	cmp	x0, #0x1e
               	b.eq	0x40039c <.text+0x17c>
               	mov	x20, #0x3               // =3
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x4               // =4
               	mov	x0, x21
               	bl	0x400238 <.text+0x18>
               	cmp	x0, #0x1e
               	b.eq	0x4003cc <.text+0x1ac>
               	mov	x21, #0x4               // =4
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x5               // =5
               	mov	x0, x20
               	bl	0x400238 <.text+0x18>
               	cmp	x0, #0x1e
               	b.eq	0x4003fc <.text+0x1dc>
               	mov	x20, #0x5               // =5
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x7               // =7
               	mov	x0, x21
               	bl	0x400238 <.text+0x18>
               	cmp	x0, #0x1e
               	b.eq	0x40042c <.text+0x20c>
               	mov	x21, #0x6               // =6
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x8               // =8
               	mov	x0, x20
               	bl	0x400238 <.text+0x18>
               	cmp	x0, #0x1e
               	b.eq	0x40045c <.text+0x23c>
               	mov	x20, #0x7               // =7
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	bl	0x400238 <.text+0x18>
               	cmp	x0, #0x0
               	b.eq	0x40048c <.text+0x26c>
               	mov	x21, #0x8               // =8
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x9               // =9
               	mov	x0, x20
               	bl	0x400238 <.text+0x18>
               	cmp	x0, #0x0
               	b.eq	0x4004bc <.text+0x29c>
               	mov	x20, #0x9               // =9
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
