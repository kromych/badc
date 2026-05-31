
octal_literal.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xd0]
               	blr	x16
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x15, #0x1e4             // =484
               	cmp	x15, #0x1e4
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x15, #0x180             // =384
               	cmp	x15, #0x180
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	mov	x15, #0xfe5b            // =65115
               	movk	x15, #0xffff, lsl #16
               	movk	x15, #0xffff, lsl #32
               	movk	x15, #0xffff, lsl #48
               	mov	x17, #0xfe5b            // =65115
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x15, x17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	mov	x15, #0x2a              // =42
               	mov	x0, x15
               	ret
