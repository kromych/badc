
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
               	mov	x0, #0x20               // =32
               	stur	w0, [x29, #-0x8]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldur	w0, [x29, #-0x8]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	lsr	x0, x0, #5
               	cmp	w0, #0x9
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x4, #0x1                // =1
               	str	w4, [x1]
               	cmp	w0, #0x4
               	b.lo	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x4, #0x1                // =1
               	str	w4, [x1]
               	mov	x17, #0x18              // =24
               	mul	x4, x0, x17
               	add	x1, x3, x4
               	ldr	w5, [x1]
               	cbnz	x5, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x6, #0x1                // =1
               	str	w6, [x5]
               	ldr	w0, [x1]
               	ldr	w5, [x1, #0x4]
               	ldrh	w3, [x1, #0x8]
               	ldrb	w6, [x1, #0xa]
               	ldrb	w4, [x1, #0xb]
               	ldr	x7, [x1, #0x10]
               	cbnz	x0, <addr>
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
               	and	x0, x0, #0x3
               	ldrsw	x0, [x2, x0, lsl #2]
               	b	<addr>
