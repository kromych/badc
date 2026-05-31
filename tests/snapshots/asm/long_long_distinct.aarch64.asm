
long_long_distinct.aarch64:	file format elf64-littleaarch64

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
               	bl	0x400818 <dlsym>
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
               	sub	sp, sp, #0x90
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x400448 <.text+0x188>
               	mov	x14, #0x1               // =1
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x40046c <.text+0x1ac>
               	mov	x14, #0x2               // =2
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x400490 <.text+0x1d0>
               	mov	x14, #0x3               // =3
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x4004b4 <.text+0x1f4>
               	mov	x14, #0x4               // =4
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x4004d8 <.text+0x218>
               	mov	x14, #0x5               // =5
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0xcdef            // =52719
               	movk	x15, #0x89ab, lsl #16
               	movk	x15, #0x4567, lsl #32
               	movk	x15, #0x123, lsl #48
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x89ab, lsl #16
               	movk	x17, #0x4567, lsl #32
               	movk	x17, #0x123, lsl #48
               	cmp	x15, x17
               	b.eq	0x40051c <.text+0x25c>
               	mov	x15, #0x6               // =6
               	mov	x0, x15
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0xffff            // =65535
               	movk	x14, #0xffff, lsl #16
               	movk	x14, #0xffff, lsl #32
               	movk	x14, #0xffff, lsl #48
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x14, x17
               	b.eq	0x400560 <.text+0x2a0>
               	mov	x14, #0x7               // =7
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x64              // =100
               	mov	x14, #0xc8              // =200
               	add	x13, x15, x14
               	cmp	x13, #0x12c
               	b.eq	0x400590 <.text+0x2d0>
               	mov	x13, #0x8               // =8
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x40
               	mov	x13, #0xa               // =10
               	str	x13, [x14]
               	sub	x15, x29, #0x40
               	add	x13, x15, #0x8
               	mov	x15, #0x14              // =20
               	str	x15, [x13]
               	sub	x14, x29, #0x40
               	add	x15, x14, #0x10
               	mov	x14, #0x1e              // =30
               	str	x14, [x15]
               	sub	x13, x29, #0x40
               	add	x14, x13, #0x8
               	ldr	x15, [x14]
               	cmp	x15, #0x14
               	b.eq	0x4005ec <.text+0x32c>
               	mov	x15, #0x9               // =9
               	mov	x0, x15
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x14, x13, #0x10
               	ldr	x13, [x14]
               	cmp	x13, #0x1e
               	b.eq	0x400618 <.text+0x358>
               	mov	x13, #0xa               // =10
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x60
               	mov	x13, #0x64              // =100
               	str	x13, [x14]
               	sub	x15, x29, #0x60
               	add	x13, x15, #0x8
               	mov	x15, #0xc8              // =200
               	str	x15, [x13]
               	sub	x14, x29, #0x60
               	add	x15, x14, #0x10
               	mov	x14, #0x12c             // =300
               	str	x14, [x15]
               	sub	x13, x29, #0x60
               	add	x14, x13, #0x8
               	ldr	x15, [x14]
               	cmp	x15, #0xc8
               	b.eq	0x400674 <.text+0x3b4>
               	mov	x15, #0xb               // =11
               	mov	x0, x15
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x14, x13, #0x10
               	ldr	x13, [x14]
               	cmp	x13, #0x12c
               	b.eq	0x4006a0 <.text+0x3e0>
               	mov	x13, #0xc               // =12
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x20, x19
               	mov	x0, x20
               	bl	0x400824 <printf>
               	sxtw	x0, w0
               	mov	x13, x0
               	mov	x13, #0x0               // =0
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
