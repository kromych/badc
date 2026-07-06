
indirect_call_narrow_scalar_args.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtb	x0, w0
               	sxth	x1, w1
               	mov	x17, #0x86a0            // =34464
               	movk	x17, #0x1, lsl #16
               	mul	x0, x0, x17
               	mov	x17, #0xa               // =10
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	add	x0, x0, x2
               	sxtw	x0, w0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	sxtw	x2, w1
               	sxtb	x3, w2
               	sxth	x4, w2
               	mov	x17, #0x86a0            // =34464
               	movk	x17, #0x1, lsl #16
               	mul	x2, x3, x17
               	mov	x17, #0xa               // =10
               	mul	x3, x4, x17
               	add	x2, x2, x3
               	add	x2, x2, x1
               	sxtw	x20, w2
               	mov	x9, x0
               	mov	x0, x1
               	mov	x2, x1
               	blr	x9
               	sxtw	x0, w0
               	sxtw	x1, w20
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xcd17            // =52503
               	movk	x17, #0x6b, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
