
errno_socket_constants.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	sub	x0, x29, #0x40
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
               	ldr	x10, [x1, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [x1, #0x28]
               	str	x10, [x0, #0x28]
               	ldr	x10, [x1, #0x30]
               	str	x10, [x0, #0x30]
               	ldr	x10, [x1, #0x38]
               	str	x10, [x0, #0x38]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x40               // =64
               	mov	x2, #0x0                // =0
               	add	x0, x0, x2
               	asr	x0, x0, #2
               	sxtw	x1, w2
               	sxtw	x3, w0
               	cmp	x1, x3
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x1, w2
               	add	x2, x1, #0x1
               	b	<addr>
               	sub	x1, x29, #0x40
               	sxtw	x3, w2
               	ldrsw	x1, [x1, x3, lsl #2]
               	cmp	x1, #0x0
               	b.gt	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x1, x2, #0x1
               	sxtw	x3, w1
               	sxtw	x1, w3
               	sxtw	x4, w0
               	cmp	x1, x4
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x1, w3
               	add	x3, x1, #0x1
               	b	<addr>
               	sub	x1, x29, #0x40
               	sxtw	x4, w2
               	ldrsw	x1, [x1, x4, lsl #2]
               	sub	x4, x29, #0x40
               	sxtw	x5, w3
               	ldrsw	x4, [x4, x5, lsl #2]
               	cmp	x1, x4
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
