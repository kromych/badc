
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
               	mov	x0, #0x0                // =0
               	ret

<negate>:
               	ldr	x1, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x1, x1, x17
               	str	x1, [x0]
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x70]!
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	mov	x0, #0x3                // =3
               	sub	x20, x29, #0x20
               	str	x0, [x20]
               	mov	x0, #0x4                // =4
               	str	x0, [x20, #0x8]
               	mov	x0, #0x5                // =5
               	str	x0, [x20, #0x10]
               	mov	x0, #0x6                // =6
               	str	x0, [x20, #0x18]
               	add	x1, x20, #0x8
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	ldr	x0, [x21]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	add	x1, x20, #0x18
               	ldr	x0, [x21]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	ldr	x0, [x20]
               	ldr	x1, [x20, #0x8]
               	add	x0, x0, x1
               	sub	x20, x29, #0x20
               	ldr	x1, [x20, #0x10]
               	add	x0, x0, x1
               	ldr	x1, [x20, #0x18]
               	add	x22, x0, x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x1, [x0]
               	mov	x0, #0xa                // =10
               	str	x0, [x20]
               	mov	x0, #0xb                // =11
               	str	x0, [x20, #0x8]
               	mov	x0, #0xc                // =12
               	str	x0, [x20, #0x10]
               	mov	x0, #0xd                // =13
               	str	x0, [x20, #0x18]
               	add	x1, x20, #0x8
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	ldr	x0, [x21]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	add	x1, x20, #0x18
               	ldr	x0, [x21]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	ldr	x1, [x20]
               	sub	x0, x29, #0x20
               	ldr	x2, [x0, #0x8]
               	add	x1, x1, x2
               	ldr	x2, [x0, #0x10]
               	add	x1, x1, x2
               	ldr	x0, [x0, #0x18]
               	add	x1, x1, x0
               	cmp	x22, #0x1c
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
