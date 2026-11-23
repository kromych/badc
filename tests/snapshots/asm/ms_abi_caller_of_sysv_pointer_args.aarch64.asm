
ms_abi_caller_of_sysv_pointer_args.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<callee>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x8, <page>
               	add	x8, x8, <lo12>
               	add	x0, x0, x0, lsl #1
               	add	x0, x0, x1
               	str	x0, [x8]
               	adrp	x0, <page>
               	str	x2, [x0, #0xa0]
               	str	x3, [x8, #0x10]
               	add	x0, x4, x4, lsl #1
               	add	x0, x0, x5
               	str	x0, [x8, #0x18]
               	add	x0, x6, x6, lsl #1
               	add	x0, x0, x7
               	str	x0, [x8, #0x20]
               	ldr	w0, [x29, #0x10]
               	str	x0, [x8, #0x28]
               	ldr	x0, [x29, #0x18]
               	str	x0, [x8, #0x30]
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp], #0x10
               	ret

<caller>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x2, x7
               	add	x0, x3, #0x1
               	mov	x5, #0x2                // =2
               	add	x3, x4, x4, lsl #3
               	add	x3, x3, #0x2
               	add	x4, x1, #0x1
               	mov	x7, #0x5                // =5
               	add	x6, x6, #0x1
               	mov	x8, #0x6                // =6
               	lsl	x1, x1, #1
               	add	x1, x1, #0x5
               	str	x1, [sp]
               	mov	x16, #0x34ac            // =13484
               	movk	x16, #0x1, lsl #16
               	str	x16, [sp, #0x8]
               	mov	x1, x5
               	mov	x5, x7
               	mov	x7, x8
               	blr	x2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x0, [x1]
               	ucvtf	d0, x0
               	fmov	d1, #0.50000000
               	fadd	d0, d0, d1
               	ldr	x0, [x1, #0x8]
               	add	x0, x0, #0x1
               	ldr	x2, [x1, #0x10]
               	add	x20, x2, #0x2
               	ldr	x2, [x1, #0x18]
               	add	x2, x2, #0x3
               	ldr	x3, [x1, #0x20]
               	add	x21, x3, #0x4
               	ldr	x3, [x1, #0x28]
               	add	x23, x3, #0x5
               	ldr	x3, [x1, #0x30]
               	add	x5, x3, #0x6
               	ldr	x1, [x1, #0x38]
               	add	x22, x1, #0x7
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	mov	x1, x20
               	mov	x6, x22
               	mov	x4, x23
               	mov	x3, x21
               	bl	<addr>
               	mov	x1, #0x1                // =1
               	mov	x2, #0x0                // =0
               	cmp	x0, #0x8
               	csel	x1, x1, x2, ne
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	add	x3, x21, #0x1
               	add	x3, x3, x3, lsl #1
               	add	x3, x3, #0x2
               	cmp	x2, x3
               	b.ne	<addr>
               	adrp	x2, <page>
               	ldr	x2, [x2, <lo12>]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	cmp	x2, x3
               	b.ne	<addr>
               	ldr	x2, [x0, #0x10]
               	add	x3, x23, x23, lsl #3
               	add	x3, x3, #0x2
               	cmp	x2, x3
               	b.eq	<addr>
               	orr	x1, x1, #0x2
               	add	x2, x20, #0x1
               	add	x2, x2, x2, lsl #1
               	add	x2, x2, #0x5
               	orr	x3, x1, #0x4
               	ldr	x4, [x0, #0x18]
               	cmp	x4, x2
               	csel	x1, x3, x1, ne
               	ldr	x2, [x0, #0x20]
               	add	x3, x22, #0x1
               	add	x3, x3, x3, lsl #1
               	add	x3, x3, #0x6
               	cmp	x2, x3
               	b.ne	<addr>
               	ldr	x2, [x0, #0x30]
               	mov	x17, #0x34ac            // =13484
               	movk	x17, #0x1, lsl #16
               	cmp	x2, x17
               	b.eq	<addr>
               	orr	x1, x1, #0x8
               	lsl	x2, x20, #1
               	add	x2, x2, #0x5
               	mov	w2, w2
               	orr	x3, x1, #0x10
               	ldr	x0, [x0, #0x28]
               	cmp	x0, x2
               	csel	x0, x3, x1, ne
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
