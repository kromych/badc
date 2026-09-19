
loop_iv_spill_priority.aarch64:	file format elf64-littleaarch64

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

<hot>:
               	mov	x3, x0
               	mov	x0, #0x0                // =0
               	ldr	w1, [x3]
               	add	x6, x1, #0x1
               	ldr	w1, [x3, #0x4]
               	add	x7, x1, #0x2
               	ldr	w1, [x3, #0x8]
               	add	x8, x1, #0x3
               	ldr	w1, [x3, #0xc]
               	add	x9, x1, #0x4
               	ldr	w1, [x3, #0x10]
               	add	x10, x1, #0x5
               	ldr	w1, [x3, #0x14]
               	add	x11, x1, #0x6
               	ldr	w1, [x3, #0x18]
               	add	x12, x1, #0x7
               	ldr	w1, [x3, #0x1c]
               	add	x13, x1, #0x8
               	mov	x1, x0
               	and	x2, x0, #0x7
               	ldr	w4, [x3, x2, lsl #2]
               	add	x2, x0, #0x1
               	madd	x1, x4, x2, x1
               	lsl	x4, x1, #1
               	eor	x1, x1, x4
               	add	x1, x1, x0
               	mov	x0, x2
               	cmp	w0, #0x3e8
               	b.lo	<addr>
               	eor	x0, x1, x6
               	eor	x0, x0, x7
               	eor	x0, x0, x8
               	eor	x0, x0, x9
               	eor	x0, x0, x10
               	eor	x0, x0, x11
               	eor	x0, x0, x12
               	eor	x0, x0, x13
               	mov	w0, w0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [sp], #0x10
               	mov	x1, #0x3e8              // =1000
               	bl	<addr>
               	and	x0, x0, #0xff
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
