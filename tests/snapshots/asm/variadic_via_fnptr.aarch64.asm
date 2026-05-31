
variadic_via_fnptr.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4002fc <.text+0xdc>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x19, [sp]
               	sub	x15, x29, #0x8
               	add	x14, x29, #0x10
               	add	x17, x14, #0x10
               	str	x17, [x15]
               	sub	x13, x29, #0x8
               	ldr	x14, [x13]
               	add	x17, x14, #0x10
               	str	x17, [x13]
               	ldrsw	x13, [x14]
               	sub	x14, x29, #0x8
               	ldr	x15, [x14]
               	add	x17, x15, #0x10
               	str	x17, [x14]
               	ldrsw	x14, [x15]
               	sub	x15, x29, #0x8
               	ldr	x12, [x15]
               	add	x17, x12, #0x10
               	str	x17, [x15]
               	ldrsw	x15, [x12]
               	sub	x12, x29, #0x8
               	ldursw	x11, [x29, #0x10]
               	mov	x17, #0x3e8             // =1000
               	mul	x11, x11, x17
               	sxtw	x11, w11
               	sxtw	x13, w13
               	mov	x17, #0x64              // =100
               	mul	x13, x13, x17
               	sxtw	x13, w13
               	add	x11, x11, x13
               	sxtw	x11, w11
               	sxtw	x14, w14
               	mov	x17, #0xa               // =10
               	mul	x14, x14, x17
               	sxtw	x14, w14
               	add	x11, x11, x14
               	sxtw	x11, w11
               	sxtw	x15, w15
               	add	x11, x11, x15
               	sxtw	x0, w11
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x26, [sp, #0x30]
               	str	x19, [sp, #0x40]
               	mov	x20, #0x9               // =9
               	mov	x21, #0x1               // =1
               	mov	x22, #0x2               // =2
               	mov	x23, #0x3               // =3
               	str	x23, [sp, #-0x10]!
               	str	x22, [sp, #-0x10]!
               	str	x21, [sp, #-0x10]!
               	str	x20, [sp, #-0x10]!
               	bl	0x400238 <.text+0x18>
               	add	sp, sp, #0x40
               	mov	x17, #0x23a3            // =9123
               	cmp	x0, x17
               	b.eq	0x400390 <.text+0x170>
               	mov	x23, #0xb               // =11
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x400000
               	add	x19, x19, #0x238
               	mov	x24, x19
               	mov	x25, #0x9               // =9
               	mov	x23, #0x1               // =1
               	mov	x22, #0x2               // =2
               	mov	x21, #0x3               // =3
               	mov	x9, x24
               	str	x21, [sp, #-0x10]!
               	str	x22, [sp, #-0x10]!
               	str	x23, [sp, #-0x10]!
               	str	x25, [sp, #-0x10]!
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	ldr	x2, [sp, #0x20]
               	ldr	x3, [sp, #0x30]
               	blr	x9
               	add	sp, sp, #0x40
               	mov	x17, #0x23a3            // =9123
               	cmp	x0, x17
               	b.eq	0x400418 <.text+0x1f8>
               	mov	x20, #0xc               // =12
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	0x4002f4 <.text+0xd4>
               	adrp	x19, 0x400000
               	add	x19, x19, #0x238
               	mov	x21, x19
               	mov	x26, #0x9               // =9
               	mov	x20, #0x1               // =1
               	mov	x22, #0x2               // =2
               	mov	x23, #0x3               // =3
               	mov	x9, x21
               	str	x23, [sp, #-0x10]!
               	str	x22, [sp, #-0x10]!
               	str	x20, [sp, #-0x10]!
               	str	x26, [sp, #-0x10]!
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	ldr	x2, [sp, #0x20]
               	ldr	x3, [sp, #0x30]
               	blr	x9
               	add	sp, sp, #0x40
               	mov	x17, #0x23a3            // =9123
               	cmp	x0, x17
               	b.eq	0x4004a4 <.text+0x284>
               	mov	x23, #0xd               // =13
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
