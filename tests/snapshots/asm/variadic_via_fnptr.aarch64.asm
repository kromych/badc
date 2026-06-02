
variadic_via_fnptr.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
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
               	ldrsw	x14, [x14]
               	sub	x13, x29, #0x8
               	ldr	x15, [x13]
               	add	x17, x15, #0x10
               	str	x17, [x13]
               	ldrsw	x15, [x15]
               	sub	x13, x29, #0x8
               	ldr	x12, [x13]
               	add	x17, x12, #0x10
               	str	x17, [x13]
               	ldrsw	x12, [x12]
               	sub	x13, x29, #0x8
               	ldursw	x11, [x29, #0x10]
               	mov	x17, #0x3e8             // =1000
               	mul	x11, x11, x17
               	sxtw	x11, w11
               	mov	x17, #0x64              // =100
               	mul	x14, x14, x17
               	sxtw	x14, w14
               	add	x11, x11, x14
               	sxtw	x11, w11
               	mov	x17, #0xa               // =10
               	mul	x15, x15, x17
               	sxtw	x15, w15
               	add	x11, x11, x15
               	sxtw	x11, w11
               	add	x11, x11, x12
               	sxtw	x0, w11
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	str	x19, [sp]
               	mov	x0, #0x9                // =9
               	mov	x1, #0x1                // =1
               	mov	x2, #0x2                // =2
               	mov	x3, #0x3                // =3
               	str	x3, [sp, #-0x10]!
               	str	x2, [sp, #-0x10]!
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	bl	<addr>
               	add	sp, sp, #0x40
               	mov	x11, x0
               	mov	x17, #0x23a3            // =9123
               	cmp	x11, x17
               	b.eq	<addr>
               	mov	x3, #0xb                // =11
               	mov	x0, x3
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x11, <page>
               	add	x11, x11, #0x238
               	mov	x0, #0x9                // =9
               	mov	x1, #0x1                // =1
               	mov	x2, #0x2                // =2
               	mov	x3, #0x3                // =3
               	mov	x9, x11
               	str	x3, [sp, #-0x10]!
               	str	x2, [sp, #-0x10]!
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	ldr	x2, [sp, #0x20]
               	ldr	x3, [sp, #0x30]
               	blr	x9
               	add	sp, sp, #0x40
               	mov	x10, x0
               	mov	x17, #0x23a3            // =9123
               	cmp	x10, x17
               	b.eq	<addr>
               	mov	x3, #0xc                // =12
               	mov	x0, x3
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x10, <page>
               	add	x10, x10, #0x238
               	mov	x0, #0x9                // =9
               	mov	x1, #0x1                // =1
               	mov	x2, #0x2                // =2
               	mov	x3, #0x3                // =3
               	mov	x9, x10
               	str	x3, [sp, #-0x10]!
               	str	x2, [sp, #-0x10]!
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	ldr	x2, [sp, #0x20]
               	ldr	x3, [sp, #0x30]
               	blr	x9
               	add	sp, sp, #0x40
               	mov	x11, x0
               	mov	x17, #0x23a3            // =9123
               	cmp	x11, x17
               	b.eq	<addr>
               	mov	x3, #0xd                // =13
               	mov	x0, x3
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x11, #0x0               // =0
               	mov	x0, x11
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
