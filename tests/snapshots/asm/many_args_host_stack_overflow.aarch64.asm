
many_args_host_stack_overflow.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4003ac <.text+0x18c>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	sub	sp, sp, #0x30
               	ldr	x16, [sp, #0x30]
               	str	x16, [sp]
               	ldr	x16, [sp, #0x38]
               	str	x16, [sp, #0x10]
               	ldr	x16, [sp, #0x40]
               	str	x16, [sp, #0x20]
               	sub	sp, sp, #0x80
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sxtw	x0, w0
               	sxtw	x1, w1
               	sxtw	x2, w2
               	sxtw	x3, w3
               	sxtw	x4, w4
               	sxtw	x5, w5
               	sxtw	x6, w6
               	sxtw	x7, w7
               	cmp	x0, #0x1
               	b.eq	0x40029c <.text+0x7c>
               	mov	x8, #0x1                // =1
               	mov	x0, x8
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xb0
               	ret
               	cmp	x1, #0x2
               	b.eq	0x4002b4 <.text+0x94>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xb0
               	ret
               	cmp	x2, #0x3
               	b.eq	0x4002cc <.text+0xac>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xb0
               	ret
               	cmp	x3, #0x4
               	b.eq	0x4002e4 <.text+0xc4>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xb0
               	ret
               	cmp	x4, #0x5
               	b.eq	0x4002fc <.text+0xdc>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xb0
               	ret
               	cmp	x5, #0x6
               	b.eq	0x400314 <.text+0xf4>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xb0
               	ret
               	cmp	x6, #0x7
               	b.eq	0x40032c <.text+0x10c>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xb0
               	ret
               	cmp	x7, #0x8
               	b.eq	0x400344 <.text+0x124>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xb0
               	ret
               	ldursw	x7, [x29, #0x90]
               	cmp	x7, #0x9
               	b.eq	0x400360 <.text+0x140>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xb0
               	ret
               	ldursw	x7, [x29, #0xa0]
               	cmp	x7, #0xa
               	b.eq	0x40037c <.text+0x15c>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xb0
               	ret
               	ldursw	x7, [x29, #0xb0]
               	cmp	x7, #0xb
               	b.eq	0x400398 <.text+0x178>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xb0
               	ret
               	mov	x7, #0x0                // =0
               	mov	x0, x7
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xb0
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x26, [sp, #0x30]
               	str	x27, [sp, #0x38]
               	str	x28, [sp, #0x40]
               	mov	x20, #0x1               // =1
               	mov	x21, #0x2               // =2
               	mov	x22, #0x3               // =3
               	mov	x23, #0x4               // =4
               	mov	x24, #0x5               // =5
               	mov	x25, #0x6               // =6
               	mov	x26, #0x7               // =7
               	mov	x27, #0x8               // =8
               	mov	x16, #0x9               // =9
               	str	x16, [sp, #0x58]
               	mov	x16, #0xa               // =10
               	str	x16, [sp, #0x50]
               	mov	x28, #0xb               // =11
               	sub	sp, sp, #0x20
               	ldr	x16, [sp, #0x78]
               	str	x16, [sp]
               	ldr	x16, [sp, #0x70]
               	str	x16, [sp, #0x8]
               	str	x28, [sp, #0x10]
               	mov	x0, x20
               	mov	x7, x27
               	mov	x6, x26
               	mov	x5, x25
               	mov	x4, x24
               	mov	x3, x23
               	mov	x2, x22
               	mov	x1, x21
               	bl	0x400238 <.text+0x18>
               	add	sp, sp, #0x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x28, [sp, #0x40]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
