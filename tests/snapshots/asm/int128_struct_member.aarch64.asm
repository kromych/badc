
int128_struct_member.aarch64:	file format elf64-littleaarch64

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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	orr	x1, x0, x1
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x4, [x3]
               	cmp	w4, #0x1
               	b.ne	<addr>
               	ldrsw	x4, [x3, #0x20]
               	cmp	w4, #0x2
               	b.ne	<addr>
               	ldr	x4, [x3, #0x10]
               	ldr	x3, [x3, #0x18]
               	eor	x4, x4, x1
               	eor	x3, x3, x2
               	orr	x3, x4, x3
               	cbz	x3, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x4, [x3]
               	ldr	x3, [x3, #0x8]
               	eor	x4, x4, x1
               	eor	x3, x3, x2
               	orr	x3, x4, x3
               	cbz	x3, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x4, [x3]
               	ldr	x5, [x3, #0x8]
               	eor	x5, x5, #0x1000000000
               	orr	x4, x4, x5
               	cbnz	x4, <addr>
               	ldr	x3, [x3, #0x8]
               	mov	x17, #0x1000000000      // =68719476736
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	eor	x3, x1, #0x4
               	mov	x17, #0x9               // =9
               	eor	x4, x2, x17
               	orr	x3, x3, x4
               	cbz	x3, <addr>
               	mov	x0, #0x8                // =8
               	ret
               	eor	x3, x1, x1
               	eor	x4, x2, x2
               	orr	x3, x3, x4
               	cbz	x3, <addr>
               	mov	x0, #0x9                // =9
               	ret
               	add	x3, x1, #0x3
               	cmp	x3, x1
               	cset	x1, lo
               	add	x2, x2, #0x1
               	add	x1, x2, x1
               	eor	x2, x3, #0x7
               	mov	x17, #0xa               // =10
               	eor	x1, x1, x17
               	orr	x1, x2, x1
               	cbz	x1, <addr>
               	mov	x0, #0xb                // =11
               	ret
               	ret
