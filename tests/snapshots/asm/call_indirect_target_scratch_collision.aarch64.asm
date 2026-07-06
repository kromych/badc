
call_indirect_target_scratch_collision.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x0, #0x0                // =0
               	ldrb	w1, [x1]
               	add	x1, x3, x1
               	str	w1, [x4]
               	ret

<forward>:
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	sxtw	x3, w3
               	ldr	x5, [x0]
               	mov	x17, #0xffff            // =65535
               	and	x3, x3, x17
               	mov	x9, x5
               	blr	x9
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret

<main>:
               	str	x20, [sp, #-0x80]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x70]
               	add	x29, sp, #0x70
               	sub	x0, x29, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x1, [x0]
               	mov	x2, #0x0                // =0
               	stur	w2, [x29, #-0x10]
               	sub	x0, x29, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0x1, lsl #16
               	sub	x4, x29, #0x10
               	bl	<addr>
               	mov	x20, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sxtw	x1, w20
               	ldursw	x2, [x29, #-0x10]
               	bl	<addr>
               	sxtw	x0, w0
               	sxtw	x0, w20
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldursw	x0, [x29, #-0x10]
               	mov	x17, #0x40              // =64
               	movk	x17, #0x1, lsl #16
               	cmp	x0, x17
               	cset	x1, eq
               	cbz	x1, <addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x1                // =1
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x80
               	ret
               	b	<addr>
