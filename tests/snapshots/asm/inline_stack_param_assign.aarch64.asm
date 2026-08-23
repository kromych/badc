
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
               	sub	sp, sp, #0x30
               	ldr	x16, [sp, #0x30]
               	str	x16, [sp]
               	ldr	x16, [sp, #0x38]
               	str	x16, [sp, #0x10]
               	ldr	x16, [sp, #0x40]
               	str	x16, [sp, #0x20]
               	sub	sp, sp, #0x10
               	str	x6, [sp, #-0x10]!
               	sub	sp, sp, #0x60
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x8, x0
               	sxth	x4, w4
               	sxtb	x6, w6
               	sturb	w6, [x29, #0x70]
               	sub	x0, x4, x1
               	sxtw	x1, w0
               	sxth	x1, w1
               	mov	x17, #0xff              // =255
               	and	x0, x5, x17
               	add	x0, x0, #0x3
               	sxtw	x0, w0
               	mov	x17, #0xff              // =255
               	and	x4, x0, x17
               	mov	x17, #0xffff            // =65535
               	and	x0, x7, x17
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	mov	x17, #0xffff            // =65535
               	and	x5, x0, x17
               	ldursw	x0, [x29, #0x90]
               	add	x0, x0, x8
               	stur	w0, [x29, #0x90]
               	add	x0, x29, #0xa0
               	ldr	x6, [x0]
               	sub	x2, x6, x2
               	str	x2, [x0]
               	ldur	x0, [x29, #0xa0]
               	ldursb	x2, [x29, #0x70]
               	add	x0, x0, x2
               	stur	x0, [x29, #0xa0]
               	ldur	w2, [x29, #0xb0]
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	add	x1, x1, x4
               	mov	x17, #0xffff            // =65535
               	and	x4, x5, x17
               	add	x1, x1, x4
               	ldursw	x4, [x29, #0x90]
               	add	x1, x1, x4
               	add	x0, x1, x0
               	mov	w1, w2
               	add	x0, x0, x1
               	mov	w1, w3
               	add	x0, x0, x1
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xb0
               	ret

<main>:
               	str	x20, [sp, #-0x50]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	mov	x1, #0x86a0             // =34464
               	movk	x1, #0x1, lsl #16
               	mov	x2, #0x5e00             // =24064
               	movk	x2, #0xb2d0, lsl #16
               	stur	x1, [x29, #-0x18]
               	stur	x2, [x29, #-0x8]
               	mov	x3, #0xfff9             // =65529
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	sturb	w3, [x29, #-0x10]
               	add	x4, x0, #0x9
               	sub	x3, x29, #0x18
               	ldr	x5, [x3]
               	sub	x5, x5, #0x12c
               	str	x5, [x3]
               	ldur	x3, [x29, #-0x18]
               	ldursb	x5, [x29, #-0x10]
               	add	x3, x3, x5
               	stur	x3, [x29, #-0x18]
               	ldur	w5, [x29, #-0x8]
               	sxtw	x4, w4
               	add	x4, x4, #0x64b
               	add	x3, x4, x3
               	mov	w4, w5
               	add	x3, x3, x4
               	mov	x17, #0x9c40            // =40000
               	add	x3, x3, x17
               	mov	x17, #0x8602            // =34306
               	movk	x17, #0xb2d2, lsl #16
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x50
               	ret
               	mov	x20, #0x2               // =2
               	mov	x4, #0x12c              // =300
               	mov	x5, #0x9c40             // =40000
               	mov	x6, #0xffce             // =65486
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	mov	x7, #0x3c               // =60
               	mov	x8, #0xfff9             // =65529
               	movk	x8, #0xffff, lsl #16
               	movk	x8, #0xffff, lsl #32
               	movk	x8, #0xffff, lsl #48
               	mov	x9, #0x320              // =800
               	mov	x10, #0x9               // =9
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x3, [x3]
               	mov	x11, x3
               	sub	sp, sp, #0x20
               	str	x10, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	mov	x1, x20
               	mov	x2, x4
               	mov	x3, x5
               	mov	x5, x7
               	mov	x4, x6
               	mov	x7, x9
               	mov	x6, x8
               	blr	x11
               	add	sp, sp, #0x20
               	mov	x17, #0x8602            // =34306
               	movk	x17, #0xb2d2, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x50
               	ret
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x50
               	ret
