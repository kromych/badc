
int128_struct_member.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
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
               	ldr	x3, [x0, #0x18]
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	orr	x2, x0, x1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x4, [x1]
               	cmp	w4, #0x1
               	b.ne	<addr>
               	ldrsw	x4, [x1, #0x20]
               	cmp	w4, #0x2
               	b.ne	<addr>
               	ldr	x4, [x1, #0x10]
               	ldr	x1, [x1, #0x18]
               	eor	x4, x4, x2
               	eor	x1, x1, x3
               	orr	x1, x4, x1
               	cbz	x1, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x4, [x1]
               	ldr	x1, [x1, #0x8]
               	eor	x4, x4, x2
               	eor	x1, x1, x3
               	orr	x1, x4, x1
               	cbz	x1, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x4, [x1]
               	ldr	x1, [x1, #0x8]
               	eor	x5, x1, #0x1000000000
               	orr	x4, x4, x5
               	cbnz	x4, <addr>
               	mov	x17, #0x1000000000      // =68719476736
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	eor	x1, x2, #0x4
               	mov	x17, #0x9               // =9
               	eor	x4, x3, x17
               	orr	x1, x1, x4
               	cbz	x1, <addr>
               	mov	x0, #0x8                // =8
               	ret
               	add	x1, x2, #0x3
               	cmp	x1, x2
               	cset	x2, lo
               	add	x3, x3, #0x1
               	add	x2, x3, x2
               	eor	x1, x1, #0x7
               	mov	x17, #0xa               // =10
               	eor	x2, x2, x17
               	orr	x1, x1, x2
               	cbz	x1, <addr>
               	mov	x0, #0xb                // =11
               	ret
               	ret
