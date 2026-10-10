
ms_abi_caller_of_sysv_pointer.aarch64:	file format elf64-littleaarch64

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

<callee>:
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x2, [x3]
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	add	x0, x0, x1
               	ret

<caller>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x2, x0
               	sub	x0, x29, #0x10
               	stp	xzr, xzr, [x0]
               	stur	x1, [x29, #-0x10]
               	mov	x1, #0x7                // =7
               	stur	x1, [x29, #-0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	blr	x2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x20, [x0]
               	ldr	x21, [x0, #0x8]
               	ldr	x22, [x0, #0x10]
               	ldr	x23, [x0, #0x18]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x20
               	bl	<addr>
               	cmp	x0, #0xa
               	b.ne	<addr>
               	mov	x17, #0xa               // =10
               	mul	x0, x21, x17
               	add	x0, x20, x0
               	mov	x17, #0x64              // =100
               	mul	x1, x22, x17
               	add	x0, x0, x1
               	mov	x17, #0x3e8             // =1000
               	mul	x1, x23, x17
               	add	x0, x0, x1
               	mov	x17, #0x10e1            // =4321
               	cmp	x0, x17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
