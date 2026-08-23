
local_array_designator.aarch64:	file format elf64-littleaarch64

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

<use_auto>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x2, #0x5                // =5
               	sub	x0, x29, #0x28
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	str	x1, [x0, #0x18]
               	str	w1, [x0, #0x20]
               	str	w2, [x0, #0x18]
               	mov	x2, #0x6                // =6
               	str	w2, [x0, #0x1c]
               	mov	x2, #0x7                // =7
               	str	w2, [x0, #0x20]
               	mov	x2, #0xa                // =10
               	str	w2, [x0]
               	mov	x2, #0xb                // =11
               	str	w2, [x0, #0x4]
               	mov	x2, #0xc                // =12
               	str	w2, [x0, #0x8]
               	mov	x0, x1
               	mov	x0, x1
               	mov	x0, x1
               	mov	x0, x1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<use_fixed>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	mov	x2, #0x7                // =7
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	mov	x0, x1
               	mov	x0, x1
               	sub	x0, x29, #0x30
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	str	x1, [x0, #0x18]
               	str	x1, [x0, #0x20]
               	str	x1, [x0, #0x28]
               	str	w2, [x0, #0x24]
               	mov	x2, #0x8                // =8
               	str	w2, [x0, #0x28]
               	str	w1, [x0, #0x2c]
               	mov	x2, #0x4                // =4
               	str	w2, [x0, #0xc]
               	mov	x2, #0x5                // =5
               	str	w2, [x0, #0x10]
               	mov	x2, #0x6                // =6
               	str	w2, [x0, #0x14]
               	mov	x0, x1
               	mov	x0, x1
               	mov	x0, x1
               	mov	x0, x1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	mov	x1, x0
               	sxtw	x0, w1
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	bl	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
