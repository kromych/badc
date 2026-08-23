
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
               	stp	x20, x21, [sp, #-0xb0]!
               	stp	x22, x23, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0xa0]
               	add	x29, sp, #0xa0
               	sub	x20, x29, #0x68
               	mov	x23, #0x0               // =0
               	mov	x0, x20
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xb0
               	ret
               	ldr	x0, [x20]
               	mov	x17, #0xf100            // =61696
               	movk	x17, #0x6553, lsl #16
               	cmp	x0, x17
               	b.ge	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xb0
               	ret
               	sub	x21, x29, #0x58
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xb0
               	ret
               	ldrsw	x0, [x21, #0x4]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x22, #0x1               // =1
               	mov	x2, x22
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xb0
               	ret
               	sub	x20, x29, #0x50
               	ldrsw	x0, [x21]
               	str	w0, [x20]
               	strh	w22, [x20, #0x4]
               	strh	w23, [x20, #0x6]
               	mov	x2, #0x3e8              // =1000
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xb0
               	ret
               	ldrsh	x0, [x20, #0x6]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cbnz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xb0
               	ret
               	sub	x20, x29, #0x58
               	mov	x21, #0x0               // =0
               	ldrsw	x0, [x20]
               	bl	<addr>
               	sxtw	x0, w0
               	ldrsw	x0, [x20, #0x4]
               	bl	<addr>
               	sxtw	x0, w0
               	sub	x1, x29, #0x48
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, #0x5413             // =21523
               	sub	x2, x29, #0x8
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, x21
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xb0
               	ret
