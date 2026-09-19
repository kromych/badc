
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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	sub	x0, x29, #0x68
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x68
               	ldr	x0, [x0]
               	mov	x17, #0xf100            // =61696
               	movk	x17, #0x6553, lsl #16
               	cmp	x0, x17
               	b.ge	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x58
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x58
               	ldrsw	x0, [x0, #0x4]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x50
               	sub	x1, x29, #0x58
               	mov	x2, #0x0                // =0
               	ldrsw	x1, [x1]
               	str	w1, [x0]
               	mov	x1, #0x1                // =1
               	strh	w1, [x0, #0x4]
               	strh	w2, [x0, #0x6]
               	mov	x2, #0x3e8              // =1000
               	bl	<addr>
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x50
               	ldrsh	x0, [x0, #0x6]
               	tbnz	w0, #0x0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x58
               	ldrsw	x0, [x0]
               	bl	<addr>
               	sub	x0, x29, #0x58
               	ldrsw	x0, [x0, #0x4]
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x48
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	mov	x1, #0x5413             // =21523
               	sub	x2, x29, #0x8
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
