
indirect_call_target_scratch_exhausted.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sub	sp, sp, #0x90
               	ldr	x16, [sp, #0x90]
               	str	x16, [sp]
               	ldr	x16, [sp, #0x98]
               	str	x16, [sp, #0x10]
               	ldr	x16, [sp, #0xa0]
               	str	x16, [sp, #0x20]
               	ldr	x16, [sp, #0xa8]
               	str	x16, [sp, #0x30]
               	ldr	x16, [sp, #0xb0]
               	str	x16, [sp, #0x40]
               	ldr	x16, [sp, #0xb8]
               	str	x16, [sp, #0x50]
               	ldr	x16, [sp, #0xc0]
               	str	x16, [sp, #0x60]
               	ldr	x16, [sp, #0xc8]
               	str	x16, [sp, #0x70]
               	ldr	x16, [sp, #0xd0]
               	str	x16, [sp, #0x80]
               	sub	sp, sp, #0x80
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	add	x0, x0, x1
               	add	x0, x0, x2
               	add	x0, x0, x3
               	add	x0, x0, x4
               	add	x0, x0, x5
               	add	x0, x0, x6
               	add	x0, x0, x7
               	ldur	x1, [x29, #0x90]
               	add	x0, x0, x1
               	ldur	x1, [x29, #0xa0]
               	add	x0, x0, x1
               	ldur	x1, [x29, #0xb0]
               	add	x0, x0, x1
               	ldur	x1, [x29, #0xc0]
               	add	x0, x0, x1
               	ldur	x1, [x29, #0xd0]
               	add	x0, x0, x1
               	ldur	x1, [x29, #0xe0]
               	add	x0, x0, x1
               	ldur	x1, [x29, #0xf0]
               	add	x0, x0, x1
               	add	x16, x29, #0x100
               	ldr	x1, [x16]
               	add	x0, x0, x1
               	add	x16, x29, #0x110
               	ldr	x1, [x16]
               	add	x0, x0, x1
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x110
               	ret

<sum16p>:
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x100
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x16, x29, #0x20
               	str	x2, [x16]
               	str	x3, [x16, #0x8]
               	sub	x16, x29, #0x30
               	str	x4, [x16]
               	str	x5, [x16, #0x8]
               	sub	x16, x29, #0x40
               	str	x6, [x16]
               	str	x7, [x16, #0x8]
               	sub	x16, x29, #0x50
               	ldr	x17, [x29, #0x110]
               	str	x17, [x16]
               	ldr	x17, [x29, #0x118]
               	str	x17, [x16, #0x8]
               	sub	x16, x29, #0x60
               	ldr	x17, [x29, #0x120]
               	str	x17, [x16]
               	ldr	x17, [x29, #0x128]
               	str	x17, [x16, #0x8]
               	sub	x16, x29, #0x70
               	ldr	x17, [x29, #0x130]
               	str	x17, [x16]
               	ldr	x17, [x29, #0x138]
               	str	x17, [x16, #0x8]
               	sub	x16, x29, #0x80
               	ldr	x17, [x29, #0x140]
               	str	x17, [x16]
               	ldr	x17, [x29, #0x148]
               	str	x17, [x16, #0x8]
               	sub	x16, x29, #0x90
               	ldr	x17, [x29, #0x150]
               	str	x17, [x16]
               	ldr	x17, [x29, #0x158]
               	str	x17, [x16, #0x8]
               	sub	x16, x29, #0xa0
               	ldr	x17, [x29, #0x160]
               	str	x17, [x16]
               	ldr	x17, [x29, #0x168]
               	str	x17, [x16, #0x8]
               	sub	x16, x29, #0xb0
               	ldr	x17, [x29, #0x170]
               	str	x17, [x16]
               	ldr	x17, [x29, #0x178]
               	str	x17, [x16, #0x8]
               	sub	x16, x29, #0xc0
               	ldr	x17, [x29, #0x180]
               	str	x17, [x16]
               	ldr	x17, [x29, #0x188]
               	str	x17, [x16, #0x8]
               	sub	x16, x29, #0xd0
               	ldr	x17, [x29, #0x190]
               	str	x17, [x16]
               	ldr	x17, [x29, #0x198]
               	str	x17, [x16, #0x8]
               	sub	x16, x29, #0xe0
               	ldr	x17, [x29, #0x1a0]
               	str	x17, [x16]
               	ldr	x17, [x29, #0x1a8]
               	str	x17, [x16, #0x8]
               	sub	x16, x29, #0xf0
               	ldr	x17, [x29, #0x1b0]
               	str	x17, [x16]
               	ldr	x17, [x29, #0x1b8]
               	str	x17, [x16, #0x8]
               	sub	x16, x29, #0x100
               	ldr	x17, [x29, #0x1c0]
               	str	x17, [x16]
               	ldr	x17, [x29, #0x1c8]
               	str	x17, [x16, #0x8]
               	sub	x0, x29, #0x10
               	ldr	x0, [x0]
               	sub	x1, x29, #0x10
               	ldr	x1, [x1, #0x8]
               	add	x0, x0, x1
               	sub	x1, x29, #0x20
               	ldr	x1, [x1]
               	add	x0, x0, x1
               	sub	x1, x29, #0x20
               	ldr	x1, [x1, #0x8]
               	add	x0, x0, x1
               	sub	x1, x29, #0x30
               	ldr	x1, [x1]
               	add	x0, x0, x1
               	sub	x1, x29, #0x30
               	ldr	x1, [x1, #0x8]
               	add	x0, x0, x1
               	sub	x1, x29, #0x40
               	ldr	x1, [x1]
               	add	x0, x0, x1
               	sub	x1, x29, #0x40
               	ldr	x1, [x1, #0x8]
               	add	x0, x0, x1
               	sub	x1, x29, #0x50
               	ldr	x1, [x1]
               	add	x0, x0, x1
               	sub	x1, x29, #0x50
               	ldr	x1, [x1, #0x8]
               	add	x0, x0, x1
               	sub	x1, x29, #0x60
               	ldr	x1, [x1]
               	add	x0, x0, x1
               	sub	x1, x29, #0x60
               	ldr	x1, [x1, #0x8]
               	add	x0, x0, x1
               	sub	x1, x29, #0x70
               	ldr	x1, [x1]
               	add	x0, x0, x1
               	sub	x1, x29, #0x70
               	ldr	x1, [x1, #0x8]
               	add	x0, x0, x1
               	sub	x1, x29, #0x80
               	ldr	x1, [x1]
               	add	x0, x0, x1
               	sub	x1, x29, #0x80
               	ldr	x1, [x1, #0x8]
               	add	x0, x0, x1
               	sub	x1, x29, #0x90
               	ldr	x1, [x1]
               	add	x0, x0, x1
               	sub	x1, x29, #0x90
               	ldr	x1, [x1, #0x8]
               	add	x0, x0, x1
               	sub	x1, x29, #0xa0
               	ldr	x1, [x1]
               	add	x0, x0, x1
               	sub	x1, x29, #0xa0
               	ldr	x1, [x1, #0x8]
               	add	x0, x0, x1
               	sub	x1, x29, #0xb0
               	ldr	x1, [x1]
               	add	x0, x0, x1
               	sub	x1, x29, #0xb0
               	ldr	x1, [x1, #0x8]
               	add	x0, x0, x1
               	sub	x1, x29, #0xc0
               	ldr	x1, [x1]
               	add	x0, x0, x1
               	sub	x1, x29, #0xc0
               	ldr	x1, [x1, #0x8]
               	add	x0, x0, x1
               	sub	x1, x29, #0xd0
               	ldr	x1, [x1]
               	add	x0, x0, x1
               	sub	x1, x29, #0xd0
               	ldr	x1, [x1, #0x8]
               	add	x0, x0, x1
               	sub	x1, x29, #0xe0
               	ldr	x1, [x1]
               	add	x0, x0, x1
               	sub	x1, x29, #0xe0
               	ldr	x1, [x1, #0x8]
               	add	x0, x0, x1
               	sub	x1, x29, #0xf0
               	ldr	x1, [x1]
               	add	x0, x0, x1
               	sub	x1, x29, #0xf0
               	ldr	x1, [x1, #0x8]
               	add	x0, x0, x1
               	sub	x1, x29, #0x100
               	ldr	x1, [x1]
               	add	x0, x0, x1
               	sub	x1, x29, #0x100
               	ldr	x1, [x1, #0x8]
               	add	x0, x0, x1
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x100
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xd0
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x19, [sp, #0x20]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x2, #0x0                // =0
               	cmp	x2, #0x10
               	b.ge	<addr>
               	b	<addr>
               	add	x2, x2, #0x1
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	lsl	x3, x2, #4
               	add	x3, x1, x3
               	str	x2, [x3]
               	lsl	x3, x2, #4
               	add	x1, x1, x3
               	lsl	x3, x2, #1
               	str	x3, [x1, #0x8]
               	b	<addr>
               	mov	x1, #0x1                // =1
               	mov	x2, #0x2                // =2
               	mov	x3, #0x3                // =3
               	mov	x4, #0x4                // =4
               	mov	x5, #0x5                // =5
               	mov	x6, #0x6                // =6
               	mov	x7, #0x7                // =7
               	mov	x8, #0x8                // =8
               	mov	x9, #0x9                // =9
               	mov	x10, #0xa               // =10
               	mov	x11, #0xb               // =11
               	mov	x12, #0xc               // =12
               	mov	x13, #0xd               // =13
               	mov	x14, #0xe               // =14
               	mov	x15, #0xf               // =15
               	mov	x21, #0x10              // =16
               	mov	x22, #0x11              // =17
               	mov	x16, x0
               	sub	sp, sp, #0x60
               	str	x16, [sp, #0x50]
               	str	x9, [sp]
               	str	x10, [sp, #0x8]
               	str	x11, [sp, #0x10]
               	str	x12, [sp, #0x18]
               	str	x13, [sp, #0x20]
               	str	x14, [sp, #0x28]
               	str	x15, [sp, #0x30]
               	str	x21, [sp, #0x38]
               	str	x22, [sp, #0x40]
               	mov	x0, x1
               	mov	x1, x2
               	mov	x2, x3
               	mov	x3, x4
               	mov	x4, x5
               	mov	x5, x6
               	mov	x6, x7
               	mov	x7, x8
               	ldr	x9, [sp, #0x50]
               	blr	x9
               	add	sp, sp, #0x60
               	cmp	x0, #0x99
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x0, #0x10
               	add	x2, x0, #0x20
               	add	x3, x0, #0x30
               	add	x4, x0, #0x40
               	add	x5, x0, #0x50
               	add	x6, x0, #0x60
               	add	x7, x0, #0x70
               	add	x8, x0, #0x80
               	add	x9, x0, #0x90
               	add	x10, x0, #0xa0
               	add	x11, x0, #0xb0
               	add	x12, x0, #0xc0
               	add	x13, x0, #0xd0
               	add	x14, x0, #0xe0
               	add	x15, x0, #0xf0
               	mov	x16, x20
               	sub	sp, sp, #0xd0
               	str	x16, [sp, #0xc0]
               	mov	x16, x4
               	ldr	x17, [x16]
               	str	x17, [sp]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x8]
               	mov	x16, x5
               	ldr	x17, [x16]
               	str	x17, [sp, #0x10]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x18]
               	mov	x16, x6
               	ldr	x17, [x16]
               	str	x17, [sp, #0x20]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x28]
               	mov	x16, x7
               	ldr	x17, [x16]
               	str	x17, [sp, #0x30]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x38]
               	mov	x16, x8
               	ldr	x17, [x16]
               	str	x17, [sp, #0x40]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x48]
               	mov	x16, x9
               	ldr	x17, [x16]
               	str	x17, [sp, #0x50]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x58]
               	mov	x16, x10
               	ldr	x17, [x16]
               	str	x17, [sp, #0x60]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x68]
               	mov	x16, x11
               	ldr	x17, [x16]
               	str	x17, [sp, #0x70]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x78]
               	mov	x16, x12
               	ldr	x17, [x16]
               	str	x17, [sp, #0x80]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x88]
               	mov	x16, x13
               	ldr	x17, [x16]
               	str	x17, [sp, #0x90]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x98]
               	mov	x16, x14
               	ldr	x17, [x16]
               	str	x17, [sp, #0xa0]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0xa8]
               	mov	x16, x15
               	ldr	x17, [x16]
               	str	x17, [sp, #0xb0]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0xb8]
               	mov	x4, x2
               	mov	x6, x3
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	ldr	x5, [x4, #0x8]
               	ldr	x4, [x4]
               	ldr	x7, [x6, #0x8]
               	ldr	x6, [x6]
               	ldr	x9, [sp, #0xc0]
               	blr	x9
               	add	sp, sp, #0xd0
               	cmp	x0, #0x168
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
