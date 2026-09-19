
inline_struct_return_multi_block.aarch64:	file format elf64-littleaarch64

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

<reg_slot>:
               	cbnz	w1, <addr>
               	mov	x0, #-0x1               // =-1
               	ret
               	and	x1, x1, #0x3
               	ldrsw	x0, [x0, x1, lsl #2]
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x20               // =32
               	stur	w0, [x29, #-0x8]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldur	w0, [x29, #-0x8]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	lsr	x0, x0, #5
               	cmp	w0, #0x9
               	b.ne	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x5, #0x1                // =1
               	str	w5, [x3]
               	cmp	w0, #0x4
               	b.lo	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x5, #0x1                // =1
               	str	w5, [x3]
               	mov	x17, #0x18              // =24
               	mul	x3, x0, x17
               	add	x1, x1, x3
               	ldr	w1, [x1]
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x5, #0x1                // =1
               	str	w5, [x1]
               	add	x0, x4, x3
               	ldr	w1, [x0]
               	ldr	w5, [x0, #0x4]
               	ldrh	w3, [x0, #0x8]
               	ldrb	w6, [x0, #0xa]
               	ldrb	w4, [x0, #0xb]
               	ldr	x7, [x0, #0x10]
               	cbnz	x1, <addr>
               	mov	x0, #-0x1               // =-1
               	cmp	w0, #0x0
               	b.ge	<addr>
               	mov	x0, #-0x1               // =-1
               	mov	x17, #0xf1              // =241
               	movk	x17, #0x1, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w5
               	add	x0, x0, x1
               	add	x0, x0, x3
               	sxtb	x1, w6
               	add	x0, x0, x1
               	add	x0, x0, x4
               	and	x1, x7, #0xffff
               	add	x0, x0, x1
               	b	<addr>
               	and	x0, x1, #0x3
               	ldrsw	x0, [x2, x0, lsl #2]
               	b	<addr>
