
inline_stack_param_assign.aarch64:	file format elf64-littleaarch64

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

<mash_outline>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	sxth	x4, w4
               	sxtb	x6, w6
               	sturb	w6, [x29, #-0x20]
               	sub	x1, x4, x1
               	sxth	x1, w1
               	and	x4, x5, #0xff
               	add	x4, x4, #0x3
               	and	x4, x4, #0xff
               	and	x5, x7, #0xffff
               	lsl	x5, x5, #1
               	and	x5, x5, #0xffff
               	ldrsw	x6, [x29, #0x10]
               	add	x0, x6, x0
               	str	w0, [x29, #0x10]
               	add	x0, x29, #0x18
               	ldr	x6, [x0]
               	sub	x2, x6, x2
               	str	x2, [x0]
               	ldr	x0, [x29, #0x18]
               	ldursb	x2, [x29, #-0x20]
               	add	x0, x0, x2
               	str	x0, [x29, #0x18]
               	ldr	w2, [x29, #0x20]
               	add	x1, x1, x4
               	add	x1, x1, x5
               	ldrsw	x4, [x29, #0x10]
               	add	x1, x1, x4
               	add	x0, x1, x0
               	add	x0, x0, x2
               	mov	w1, w3
               	add	x0, x0, x1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	mov	x8, #0x86a0             // =34464
               	movk	x8, #0x1, lsl #16
               	mov	x9, #0x5e00             // =24064
               	movk	x9, #0xb2d0, lsl #16
               	stur	x8, [x29, #-0x18]
               	stur	x9, [x29, #-0x8]
               	mov	x6, #-0x7               // =-7
               	sturb	w6, [x29, #-0x10]
               	add	x2, x0, #0x9
               	sub	x1, x29, #0x18
               	ldr	x3, [x1]
               	sub	x3, x3, #0x12c
               	str	x3, [x1]
               	ldur	x1, [x29, #-0x18]
               	ldursb	x3, [x29, #-0x10]
               	add	x1, x1, x3
               	stur	x1, [x29, #-0x18]
               	ldur	w3, [x29, #-0x8]
               	sxtw	x2, w2
               	add	x2, x2, #0x64b
               	add	x1, x2, x1
               	add	x1, x1, x3
               	mov	x17, #0x9c40            // =40000
               	add	x1, x1, x17
               	mov	x17, #0x8602            // =34306
               	movk	x17, #0xb2d2, lsl #16
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x2                // =2
               	mov	x2, #0x12c              // =300
               	mov	x3, #0x9c40             // =40000
               	mov	x4, #-0x32              // =-50
               	mov	x5, #0x3c               // =60
               	mov	x7, #0x320              // =800
               	mov	x10, #0x9               // =9
               	adrp	x11, <page>
               	add	x11, x11, <lo12>
               	ldr	x11, [x11]
               	sub	sp, sp, #0x20
               	str	x10, [sp]
               	str	x8, [sp, #0x8]
               	str	x9, [sp, #0x10]
               	blr	x11
               	add	sp, sp, #0x20
               	mov	x17, #0x8602            // =34306
               	movk	x17, #0xb2d2, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
