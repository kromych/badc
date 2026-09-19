
inline_indirect_call_region_share.aarch64:	file format elf64-littleaarch64

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

<twice>:
               	ldr	x1, [x0]
               	lsl	x1, x1, #1
               	str	x1, [x0]
               	ret

<negate>:
               	ldr	x1, [x0]
               	mov	x17, #-0x1              // =-1
               	mul	x1, x1, x17
               	str	x1, [x0]
               	ret

<main>:
               	str	x20, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x1, #0x3                // =3
               	sub	x0, x29, #0x20
               	str	x1, [x0]
               	mov	x1, #0x4                // =4
               	str	x1, [x0, #0x8]
               	mov	x1, #0x5                // =5
               	str	x1, [x0, #0x10]
               	mov	x1, #0x6                // =6
               	str	x1, [x0, #0x18]
               	add	x0, x0, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	blr	x1
               	sub	x0, x29, #0x20
               	add	x0, x0, #0x18
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	blr	x1
               	sub	x0, x29, #0x20
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	add	x1, x1, x2
               	ldr	x2, [x0, #0x10]
               	add	x1, x1, x2
               	ldr	x2, [x0, #0x18]
               	add	x20, x1, x2
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x2, [x1]
               	mov	x2, #0xa                // =10
               	str	x2, [x0]
               	mov	x2, #0xb                // =11
               	str	x2, [x0, #0x8]
               	mov	x2, #0xc                // =12
               	str	x2, [x0, #0x10]
               	mov	x2, #0xd                // =13
               	str	x2, [x0, #0x18]
               	add	x0, x0, #0x8
               	ldr	x1, [x1]
               	blr	x1
               	sub	x0, x29, #0x20
               	add	x0, x0, #0x18
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	blr	x1
               	sub	x0, x29, #0x20
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	add	x1, x1, x2
               	ldr	x2, [x0, #0x10]
               	add	x1, x1, x2
               	ldr	x0, [x0, #0x18]
               	add	x0, x1, x0
               	cmp	x20, #0x1c
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x17, #-0x2              // =-2
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
