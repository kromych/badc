
posix_os_headers.aarch64:	file format elf64-littleaarch64

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
               	str	x20, [sp, #-0xa0]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x90]
               	add	x29, sp, #0x90
               	sub	x0, x29, #0x50
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0xa0
               	ret
               	sub	x0, x29, #0x50
               	ldr	x0, [x0]
               	mov	x17, #0xf100            // =61696
               	movk	x17, #0x6553, lsl #16
               	cmp	x0, x17
               	b.ge	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0xa0
               	ret
               	sub	x0, x29, #0x58
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0xa0
               	ret
               	sub	x0, x29, #0x58
               	ldrsw	x0, [x0, #0x4]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x1                // =1
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0xa0
               	ret
               	sub	x0, x29, #0x60
               	sub	x1, x29, #0x58
               	mov	x2, #0x0                // =0
               	ldrsw	x1, [x1]
               	str	w1, [x0]
               	sub	x0, x29, #0x60
               	mov	x1, #0x1                // =1
               	strh	w1, [x0, #0x4]
               	sub	x0, x29, #0x60
               	strh	w2, [x0, #0x6]
               	sub	x0, x29, #0x60
               	mov	x2, #0x3e8              // =1000
               	bl	<addr>
               	sxtw	x0, w0
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0xa0
               	ret
               	sub	x0, x29, #0x60
               	ldrsh	x0, [x0, #0x6]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0xa0
               	ret
               	sub	x0, x29, #0x58
               	mov	x20, #0x0               // =0
               	ldrsw	x0, [x0]
               	bl	<addr>
               	sxtw	x0, w0
               	sub	x0, x29, #0x58
               	ldrsw	x0, [x0, #0x4]
               	bl	<addr>
               	sxtw	x0, w0
               	sub	x1, x29, #0x40
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, #0x5413             // =21523
               	sub	x2, x29, #0x68
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0xa0
               	ret
