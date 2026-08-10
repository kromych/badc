
phi_group_dead_phi_interference.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	sub	x0, x29, #0x60
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	sub	x1, x29, #0x18
               	mov	x0, #0x0                // =0
               	str	x0, [x1]
               	str	x0, [x1, #0x8]
               	str	x0, [x1, #0x10]
               	mov	x1, #0x0                // =0
               	mov	x2, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x18
               	ldrh	w1, [x2]
               	ldr	x2, [x2, #0x8]
               	add	x0, x3, #0x1
               	sxtw	x3, w0
               	cmp	x3, #0x5
               	b.lt	<addr>
               	mov	x17, #0xffff            // =65535
               	and	x0, x1, x17
               	eor	x0, x0, x2
               	mov	x17, #0xf0b5            // =61621
               	movk	x17, #0xe59a, lsl #16
               	movk	x17, #0x5c7c, lsl #32
               	movk	x17, #0xd13b, lsl #48
               	eor	x1, x0, x17
               	sub	x0, x29, #0x18
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x18
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0x7f              // =127
               	and	x0, x1, x17
               	sxtw	x0, w0
               	cmp	x0, #0x35
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
