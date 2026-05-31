
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
               	sub	sp, sp, #0x220
               	str	x19, [sp]
               	adrp	x19, <page>
               	add	x19, x19, #0xd0
               	mov	x15, x19
               	ldr	x14, [x15]
               	cmp	x14, #0x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xd0
               	mov	x14, x19
               	add	x14, x14, #0x78
               	ldr	x0, [x14]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x14, #0x2               // =2
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x150
               	mov	x0, x19
               	ldr	x14, [x0]
               	cmp	x14, #0x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x19, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x150
               	mov	x14, x19
               	add	x14, x14, #0x8
               	ldr	x0, [x14]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x14, #0x4               // =4
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x150
               	mov	x0, x19
               	add	x0, x0, #0x78
               	ldr	x14, [x0]
               	cmp	x14, #0x0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldr	x19, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x14, x19
               	ldr	x0, [x14]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x14, #0x6               // =6
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	add	x0, x0, #0x10
               	ldr	x14, [x0]
               	cmp	x14, #0x7
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldr	x19, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x14, x19
               	add	x14, x14, #0x78
               	ldr	x0, [x14]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x14, #0x8               // =8
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x40               // =64
               	sxtw	x0, w0
               	lsl	x0, x0, #3
               	sxtw	x0, w0
               	cmp	x0, #0x200
               	b.eq	<addr>
               	mov	x14, #0x9               // =9
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x40               // =64
               	sxtw	x0, w0
               	lsl	x0, x0, #3
               	sxtw	x0, w0
               	cmp	x0, #0x200
               	b.eq	<addr>
               	mov	x14, #0xa               // =10
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x250
               	mov	x0, x19
               	add	x0, x0, #0x138
               	mov	x14, #0x2a              // =42
               	str	x14, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x450
               	mov	x13, x19
               	add	x13, x13, #0x1f8
               	mov	x14, #0xffff            // =65535
               	movk	x14, #0xffff, lsl #16
               	movk	x14, #0xffff, lsl #32
               	movk	x14, #0xffff, lsl #48
               	str	x14, [x13]
               	ldr	x12, [x0]
               	cmp	x12, #0x2a
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldr	x19, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x450
               	mov	x12, x19
               	add	x12, x12, #0x1f8
               	ldr	x0, [x12]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x12, #0xc               // =12
               	mov	x0, x12
               	ldr	x19, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x250
               	mov	x0, x19
               	ldr	x12, [x0]
               	cmp	x12, #0x0
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldr	x19, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x450
               	mov	x12, x19
               	ldr	x0, [x12]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x12, #0xe               // =14
               	mov	x0, x12
               	ldr	x19, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x208
               	add	x0, x0, #0x200
               	mov	x12, #0x63              // =99
               	str	w12, [x0]
               	sub	x14, x29, #0x208
               	add	x14, x14, #0x200
               	ldrsw	x12, [x14]
               	cmp	x12, #0x63
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldr	x19, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x12, #0x40              // =64
               	lsl	x12, x12, #3
               	sxtw	x12, w12
               	add	x12, x12, #0x4
               	sxtw	x12, w12
               	cmp	x12, #0x208
               	b.le	<addr>
               	mov	x0, #0x10               // =16
               	ldr	x19, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x12, #0x0               // =0
               	mov	x0, x12
               	ldr	x19, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
