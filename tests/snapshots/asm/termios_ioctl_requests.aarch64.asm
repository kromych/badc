
termios_ioctl_requests.aarch64:	file format elf64-littleaarch64

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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x18
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x30               // =48
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	wzr, [x29, #-0x10]
               	sub	x0, x29, #0x8
               	mov	x2, #0x18               // =24
               	strh	w2, [x0]
               	mov	x2, #0x50               // =80
               	strh	w2, [x0, #0x2]
               	strh	wzr, [x0, #0x4]
               	strh	wzr, [x0, #0x6]
               	ldursw	x0, [x29, #-0x18]
               	mov	x1, #0x5415             // =21525
               	sub	x2, x29, #0x10
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x31               // =49
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x18]
               	mov	x1, #0x5414             // =21524
               	sub	x2, x29, #0x8
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x32               // =50
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x18]
               	bl	<addr>
               	sub	x0, x29, #0x18
               	ldrsw	x0, [x0, #0x4]
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
