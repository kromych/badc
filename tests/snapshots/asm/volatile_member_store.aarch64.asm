
volatile_member_store.aarch64:	file format elf64-littleaarch64

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
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x29               // =41
               	str	x0, [x1]
               	ldr	x0, [x1]
               	cmp	x0, #0x29
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldr	x0, [x1]
               	add	x0, x0, #0x3
               	str	x0, [x1]
               	ldr	x0, [x1]
               	add	x0, x0, #0x1
               	str	x0, [x1]
               	ldr	x0, [x1]
               	add	x0, x0, #0x1
               	str	x0, [x1]
               	ldr	x0, [x1]
               	sub	x0, x0, #0x1
               	str	x0, [x1]
               	ldr	x0, [x1]
               	cmp	x0, #0x2d
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x7                // =7
               	str	x0, [x1, #0x8]
               	ldr	x0, [x1, #0x8]
               	add	x0, x0, #0x7
               	str	x0, [x1, #0x8]
               	ldr	x0, [x1, #0x8]
               	cmp	x0, #0xe
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x5                // =5
               	add	x2, x1, #0x10
               	str	x0, [x2, #0x8]
               	ldr	x3, [x2, #0x8]
               	add	x3, x3, #0x5
               	str	x3, [x2, #0x8]
               	ldr	x2, [x2, #0x8]
               	cmp	x2, #0xa
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	ldr	w2, [x1, #0x20]
               	and	x2, x2, #0xffffffffffffffe0
               	mov	x17, #0x9               // =9
               	orr	x2, x2, x17
               	str	w2, [x1, #0x20]
               	ldr	w2, [x1, #0x20]
               	and	x2, x2, #0x1f
               	add	x2, x2, #0x1
               	and	x2, x2, #0x1f
               	ldr	w3, [x1, #0x20]
               	and	x3, x3, #0xffffffffffffffe0
               	orr	x2, x3, x2
               	str	w2, [x1, #0x20]
               	ldr	w1, [x1, #0x20]
               	and	x1, x1, #0x1f
               	mov	x17, #0xa               // =10
               	eor	x1, x1, x17
               	cbz	w1, <addr>
               	ret
               	mov	x0, #0x0                // =0
               	ret
