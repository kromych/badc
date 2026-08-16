
runtime_struct_array_member_init.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xb0
               	sub	x0, x29, #0xa8
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	str	x1, [x0, #0x18]
               	str	x1, [x0, #0x20]
               	str	x1, [x0, #0x28]
               	str	x1, [x0, #0x30]
               	str	x1, [x0, #0x38]
               	str	x1, [x0, #0x40]
               	str	x1, [x0, #0x48]
               	str	x1, [x0, #0x50]
               	str	x1, [x0, #0x58]
               	str	x1, [x0, #0x60]
               	str	x1, [x0, #0x68]
               	str	x1, [x0, #0x70]
               	str	x1, [x0, #0x78]
               	str	x1, [x0, #0x80]
               	str	x1, [x0, #0x88]
               	str	x1, [x0, #0x90]
               	str	x1, [x0, #0x98]
               	str	x1, [x0, #0xa0]
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
               	mov	x3, #0x2000             // =8192
               	sub	x1, x29, #0xa8
               	str	x3, [x1, #0x40]
               	ldrsw	x1, [x0]
               	cmp	x1, #0xa
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	add	x0, x0, #0x8
               	cmp	x2, x0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	cmp	x0, #0x1e
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
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
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
