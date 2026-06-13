
posix_os_headers.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x3e0              // =992
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xb0
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	x0, [x0]
               	mov	x17, #0xf100            // =61696
               	movk	x17, #0x6553, lsl #16
               	cmp	x0, x17
               	b.ge	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	ldrsw	x0, [x0, #0x4]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x1                // =1
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	sub	x1, x29, #0x18
               	mov	x2, #0x0                // =0
               	ldrsw	x1, [x1]
               	str	w1, [x0]
               	sub	x0, x29, #0x20
               	mov	x1, #0x1                // =1
               	strh	w1, [x0, #0x4]
               	sub	x0, x29, #0x20
               	strh	w2, [x0, #0x6]
               	sub	x0, x29, #0x20
               	mov	x2, #0x3e8              // =1000
               	bl	<addr>
               	sxtw	x0, w0
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	ldrsh	x0, [x0, #0x6]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x20, #0x0               // =0
               	ldrsw	x0, [x0]
               	bl	<addr>
               	sxtw	x0, w0
               	sub	x0, x29, #0x18
               	ldrsw	x0, [x0, #0x4]
               	bl	<addr>
               	sxtw	x0, w0
               	sub	x1, x29, #0x68
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, #0x5413             // =21523
               	sub	x2, x29, #0x70
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
