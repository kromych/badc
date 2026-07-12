
runtime_struct_array_member_init.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xb0
               	sub	x0, x29, #0xa8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x1, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [x1, #0x28]
               	str	x10, [x0, #0x28]
               	ldr	x10, [x1, #0x30]
               	str	x10, [x0, #0x30]
               	ldr	x10, [x1, #0x38]
               	str	x10, [x0, #0x38]
               	ldr	x10, [x1, #0x40]
               	str	x10, [x0, #0x40]
               	ldr	x10, [x1, #0x48]
               	str	x10, [x0, #0x48]
               	ldr	x10, [x1, #0x50]
               	str	x10, [x0, #0x50]
               	ldr	x10, [x1, #0x58]
               	str	x10, [x0, #0x58]
               	ldr	x10, [x1, #0x60]
               	str	x10, [x0, #0x60]
               	ldr	x10, [x1, #0x68]
               	str	x10, [x0, #0x68]
               	ldr	x10, [x1, #0x70]
               	str	x10, [x0, #0x70]
               	ldr	x10, [x1, #0x78]
               	str	x10, [x0, #0x78]
               	ldr	x10, [x1, #0x80]
               	str	x10, [x0, #0x80]
               	ldr	x10, [x1, #0x88]
               	str	x10, [x0, #0x88]
               	ldr	x10, [x1, #0x90]
               	str	x10, [x0, #0x90]
               	ldr	x10, [x1, #0x98]
               	str	x10, [x0, #0x98]
               	ldr	x10, [x1, #0xa0]
               	str	x10, [x0, #0xa0]
               	ldr	x10, [sp], #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0xa8
               	str	x0, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x0, x29, #0xa8
               	str	x1, [x0, #0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0xa8
               	str	x0, [x1, #0x10]
               	mov	x2, #0x1000             // =4096
               	sub	x1, x29, #0xa8
               	str	x2, [x1, #0x18]
               	mov	x2, #0x1                // =1
               	sub	x1, x29, #0xa8
               	str	w2, [x1, #0x20]
               	mov	x2, #0x2                // =2
               	sub	x1, x29, #0xa8
               	str	w2, [x1, #0x24]
               	mov	x2, #0x3                // =3
               	sub	x1, x29, #0xa8
               	str	w2, [x1, #0x28]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x1, x29, #0xa8
               	str	x2, [x1, #0x30]
               	add	x2, x0, #0x8
               	sub	x1, x29, #0xa8
               	str	x2, [x1, #0x38]
               	mov	x2, #0x2000             // =8192
               	sub	x1, x29, #0xa8
               	str	x2, [x1, #0x40]
               	sub	x1, x29, #0xa8
               	ldr	x1, [x1, #0x10]
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xa8
               	ldr	x1, [x1, #0x10]
               	ldrsw	x1, [x1]
               	cmp	x1, #0xa
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xa8
               	ldr	x1, [x1, #0x18]
               	mov	x17, #0x1000            // =4096
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xa8
               	ldrsw	x1, [x1, #0x20]
               	cmp	x1, #0x1
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x1, x29, #0xa8
               	ldrsw	x1, [x1, #0x28]
               	cmp	x1, #0x3
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xa8
               	ldr	x1, [x1, #0x38]
               	add	x0, x0, #0x8
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa8
               	ldr	x0, [x0, #0x38]
               	ldrsw	x0, [x0]
               	cmp	x0, #0x1e
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa8
               	ldr	x0, [x0, #0x40]
               	mov	x17, #0x2000            // =8192
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa8
               	ldrsw	x0, [x0, #0x48]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa8
               	ldr	x0, [x0, #0x30]
               	ldrb	w0, [x0]
               	mov	x17, #0x70              // =112
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa8
               	ldr	x0, [x0, #0x58]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
