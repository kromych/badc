
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
               	mov	x8, x0
               	mov	x10, x3
               	mov	x9, x2
               	sxth	x4, w4
               	sxtb	x6, w6
               	sturb	w6, [x29, #-0x20]
               	sub	x0, x4, x1
               	mov	x1, x0
               	sxth	x4, w1
               	mov	x17, #0xff              // =255
               	and	x0, x5, x17
               	add	x0, x0, #0x3
               	sxtw	x0, w0
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	and	x1, x7, x17
               	lsl	x1, x1, #1
               	sxtw	x1, w1
               	mov	x17, #0xffff            // =65535
               	and	x1, x1, x17
               	ldursw	x2, [x29, #0x10]
               	add	x2, x2, x8
               	stur	w2, [x29, #0x10]
               	add	x2, x29, #0x18
               	ldr	x3, [x2]
               	sub	x3, x3, x9
               	str	x3, [x2]
               	ldur	x2, [x29, #0x18]
               	ldursb	x3, [x29, #-0x20]
               	add	x2, x2, x3
               	stur	x2, [x29, #0x18]
               	ldur	w3, [x29, #0x20]
               	add	x0, x4, x0
               	add	x0, x0, x1
               	ldursw	x1, [x29, #0x10]
               	add	x0, x0, x1
               	add	x0, x0, x2
               	add	x0, x0, x3
               	mov	w1, w10
               	add	x0, x0, x1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	x19, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
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
               	add	x5, x0, #0x9
               	sub	x3, x29, #0x18
               	ldr	x4, [x3]
               	sub	x4, x4, #0x12c
               	str	x4, [x3]
               	ldur	x3, [x29, #-0x18]
               	ldursb	x4, [x29, #-0x10]
               	add	x3, x3, x4
               	stur	x3, [x29, #-0x18]
               	ldur	w4, [x29, #-0x8]
               	sxtw	x5, w5
               	add	x5, x5, #0x64b
               	add	x3, x5, x3
               	add	x3, x3, x4
               	mov	x17, #0x9c40            // =40000
               	add	x3, x3, x17
               	mov	x17, #0x8602            // =34306
               	movk	x17, #0xb2d2, lsl #16
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp], #0x40
               	ret
               	mov	x4, #0x2                // =2
               	mov	x5, #0x12c              // =300
               	mov	x6, #0x9c40             // =40000
               	mov	x7, #0xffce             // =65486
               	movk	x7, #0xffff, lsl #16
               	movk	x7, #0xffff, lsl #32
               	movk	x7, #0xffff, lsl #48
               	mov	x8, #0x3c               // =60
               	mov	x9, #0xfff9             // =65529
               	movk	x9, #0xffff, lsl #16
               	movk	x9, #0xffff, lsl #32
               	movk	x9, #0xffff, lsl #48
               	mov	x10, #0x320             // =800
               	mov	x11, #0x9               // =9
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x3, [x3]
               	mov	x12, x3
               	sub	sp, sp, #0x20
               	str	x11, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	mov	x1, x4
               	mov	x2, x5
               	mov	x3, x6
               	mov	x5, x8
               	mov	x4, x7
               	mov	x7, x10
               	mov	x6, x9
               	blr	x12
               	add	sp, sp, #0x20
               	mov	x17, #0x8602            // =34306
               	movk	x17, #0xb2d2, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp], #0x40
               	ret
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp], #0x40
               	ret
