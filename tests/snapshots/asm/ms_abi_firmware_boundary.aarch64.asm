
ms_abi_firmware_boundary.aarch64:	file format elf64-littleaarch64

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

<step>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<probe>:
               	stp	x20, x21, [sp, #-0x50]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	mov	x20, x0
               	mov	x23, x3
               	mov	x22, x2
               	mov	x21, x1
               	mov	x0, x20
               	bl	<addr>
               	mov	x24, x0
               	mov	x0, x21
               	bl	<addr>
               	mov	x25, x0
               	mov	x0, x22
               	bl	<addr>
               	mov	x26, x0
               	mov	x0, x23
               	bl	<addr>
               	mov	x27, x0
               	add	x0, x20, x23
               	bl	<addr>
               	mov	x20, x0
               	add	x0, x21, x22
               	bl	<addr>
               	mov	x17, #0x3e8             // =1000
               	mul	x1, x24, x17
               	mov	x17, #0x64              // =100
               	mul	x2, x25, x17
               	add	x1, x1, x2
               	mov	x17, #0xa               // =10
               	mul	x2, x26, x17
               	add	x1, x1, x2
               	add	x1, x1, x27
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x40]!
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x0, #0x1                // =1
               	mov	x21, #0x2               // =2
               	mov	x22, #0x3               // =3
               	mov	x23, #0x4               // =4
               	bl	<addr>
               	mov	x24, x0
               	mov	x0, x21
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, x22
               	bl	<addr>
               	mov	x22, x0
               	mov	x0, x23
               	bl	<addr>
               	mov	x23, x0
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	mov	x17, #0x3e8             // =1000
               	mul	x0, x24, x17
               	mov	x17, #0x64              // =100
               	mul	x1, x21, x17
               	add	x0, x0, x1
               	mov	x17, #0xa               // =10
               	mul	x1, x22, x17
               	add	x0, x0, x1
               	add	x0, x0, x23
               	str	x0, [x20]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1111             // =4369
               	str	x1, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x2222             // =8738
               	str	x2, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	cmp	x2, #0x4d2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	ldr	x0, [x0]
               	mov	x17, #0x1111            // =4369
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	ldr	x0, [x1]
               	mov	x17, #0x2222            // =8738
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
