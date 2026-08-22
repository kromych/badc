
getopt_unistd_globals.aarch64:	file format elf64-littleaarch64

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
               	str	x20, [sp, #-0x30]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	mov	x0, #0x1                // =1
               	str	w0, [x1]
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	mov	x20, #0x0               // =0
               	str	w20, [x1]
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	ldr	x1, [x1]
               	cbz	x1, <addr>
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	ldrsw	x1, [x1]
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
