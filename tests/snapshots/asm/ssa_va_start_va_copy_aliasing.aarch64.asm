
ssa_va_start_va_copy_aliasing.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xf0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x20, x0
               	sxtw	x20, w20
               	adrp	x21, <page>
               	add	x21, x21, #0x100
               	lsl	x0, x20, #3
               	add	x0, x21, x0
               	ldr	x0, [x0]
               	cbz	x0, <addr>
               	lsl	x0, x20, #3
               	add	x0, x21, x0
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, #0x118
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x8
               	adrp	x2, <page>
               	add	x2, x2, #0x11e
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x10
               	adrp	x2, <page>
               	add	x2, x2, #0x125
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	lsl	x2, x20, #3
               	add	x0, x0, x2
               	ldr	x0, [x0]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	cbz	x0, <addr>
               	lsl	x1, x20, #3
               	add	x1, x21, x1
               	ldr	x0, [x0]
               	str	x0, [x1]
               	b	<addr>
               	lsl	x0, x20, #3
               	add	x0, x21, x0
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x19, [sp]
               	sub	x0, x29, #0x8
               	add	x1, x29, #0x10
               	add	x17, x1, #0x10
               	str	x17, [x0]
               	sub	x0, x29, #0x8
               	ldr	x17, [x0]
               	add	x16, x17, #0x10
               	str	x16, [x0]
               	mov	x0, x17
               	ldr	x0, [x0]
               	sub	x1, x29, #0x8
               	ldr	x17, [x1]
               	add	x16, x17, #0x10
               	str	x16, [x1]
               	mov	x1, x17
               	ldr	x1, [x1]
               	sub	x2, x29, #0x8
               	mov	x17, #0x3e8             // =1000
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x19, [sp]
               	sub	x0, x29, #0x8
               	add	x1, x29, #0x10
               	add	x17, x1, #0x10
               	str	x17, [x0]
               	sub	x0, x29, #0x10
               	sub	x1, x29, #0x8
               	ldr	x17, [x1]
               	str	x17, [x0]
               	sub	x0, x29, #0x8
               	ldr	x17, [x0]
               	add	x16, x17, #0x10
               	str	x16, [x0]
               	mov	x0, x17
               	ldr	x0, [x0]
               	sub	x1, x29, #0x10
               	ldr	x17, [x1]
               	add	x16, x17, #0x10
               	str	x16, [x1]
               	mov	x1, x17
               	ldr	x1, [x1]
               	sub	x2, x29, #0x8
               	sub	x2, x29, #0x10
               	mov	x17, #0x11              // =17
               	mul	x0, x0, x17
               	add	x0, x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x19, [sp]
               	mov	x0, #0x2                // =2
               	mov	x1, #0xb                // =11
               	mov	x2, #0x16               // =22
               	str	x2, [sp, #-0x10]!
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	bl	<addr>
               	add	sp, sp, #0x30
               	mov	x1, x0
               	mov	x17, #0x55fb            // =22011
               	cmp	x1, x17
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x150
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	mov	x1, #0x7                // =7
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	bl	<addr>
               	add	sp, sp, #0x20
               	mov	x1, x0
               	cmp	x1, #0x7e
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x172
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x2                // =2
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
