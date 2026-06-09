
multidim_array_init.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x40
               	b	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xd0
               	ldrsw	x0, [x0, #0x10]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xd0
               	ldrsw	x0, [x0, #0x14]
               	cmp	x0, #0x1
               	cset	x0, ne
               	mov	x2, #0x1                // =1
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0xd0
               	ldrsw	x0, [x0, #0x20]
               	cmp	x0, #0x6
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x2, ne
               	b	<addr>
               	cbnz	x2, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0xd0
               	ldrsw	x0, [x0, #0x24]
               	cmp	x0, #0x7
               	cset	x2, ne
               	b	<addr>
               	cbz	x2, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xd0
               	ldrsw	x0, [x0, #0x28]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xd0
               	ldrsw	x0, [x0, #0x3c]
               	cmp	x0, #0x1
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0xd0
               	ldrsw	x0, [x0, #0x40]
               	cmp	x0, #0x2
               	cset	x1, ne
               	b	<addr>
               	cbz	x1, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xd0
               	ldrsw	x0, [x0, #0x60]
               	cmp	x0, #0x7
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0xd0
               	ldrsw	x0, [x0, #0x50]
               	cmp	x0, #0x0
               	cset	x1, ne
               	b	<addr>
               	cbz	x1, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x148
               	ldrsw	x0, [x0, #0x24]
               	adrp	x1, <page>
               	add	x1, x1, #0xd0
               	ldrsw	x1, [x1, #0x24]
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x148
               	ldrsw	x0, [x0, #0x60]
               	adrp	x1, <page>
               	add	x1, x1, #0xd0
               	ldrsw	x1, [x1, #0x60]
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x1c0
               	ldrsw	x0, [x0]
               	cmp	x0, #0x1
               	cset	x0, ne
               	mov	x2, #0x1                // =1
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1c0
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x2
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x2, ne
               	b	<addr>
               	cbnz	x2, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1c0
               	ldrsw	x0, [x0, #0xc]
               	cmp	x0, #0x0
               	cset	x2, ne
               	b	<addr>
               	cbz	x2, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x1c0
               	ldrsw	x0, [x0, #0x18]
               	cmp	x0, #0x9
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1c0
               	ldrsw	x0, [x0, #0x10]
               	cmp	x0, #0x0
               	cset	x1, ne
               	b	<addr>
               	cbz	x1, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x1c0
               	ldrsw	x0, [x0, #0x20]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
