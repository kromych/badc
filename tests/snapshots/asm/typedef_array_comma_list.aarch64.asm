
typedef_array_comma_list.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x210
               	adrp	x15, <page>
               	add	x15, x15, #0xd0
               	ldr	x14, [x15]
               	cmp	x14, #0x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x15, x15, #0x78
               	ldr	x15, [x15]
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0x150
               	ldr	x15, [x15]
               	cmp	x15, #0x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0x150
               	add	x15, x15, #0x8
               	ldr	x15, [x15]
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0x150
               	add	x15, x15, #0x78
               	ldr	x15, [x15]
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0x1d0
               	ldr	x15, [x15]
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0x1d0
               	add	x15, x15, #0x10
               	ldr	x15, [x15]
               	cmp	x15, #0x7
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0x1d0
               	add	x15, x15, #0x78
               	ldr	x15, [x15]
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0x250
               	add	x15, x15, #0x138
               	mov	x0, #0x2a               // =42
               	str	x0, [x15]
               	adrp	x14, <page>
               	add	x14, x14, #0x450
               	add	x14, x14, #0x1f8
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	str	x0, [x14]
               	ldr	x15, [x15]
               	cmp	x15, #0x2a
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0x450
               	add	x15, x15, #0x1f8
               	ldr	x15, [x15]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x15, x17
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0x250
               	ldr	x15, [x15]
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0x450
               	ldr	x15, [x15]
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x208
               	add	x15, x15, #0x200
               	mov	x0, #0x63               // =99
               	str	w0, [x15]
               	sub	x12, x29, #0x208
               	add	x12, x12, #0x200
               	ldrsw	x12, [x12]
               	cmp	x12, #0x63
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x12, #0x0               // =0
               	mov	x0, x12
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
