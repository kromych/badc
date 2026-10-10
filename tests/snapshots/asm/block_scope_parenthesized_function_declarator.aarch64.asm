
block_scope_parenthesized_function_declarator.aarch64:	file format elf64-littleaarch64

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

<calls>:
               	sub	x0, x0, x1
               	mov	x17, #0x3e8             // =1000
               	mul	x0, x0, x17
               	add	x0, x0, #0xc8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x17, #0xa               // =10
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	add	x0, x0, #0x1
               	mov	x17, #0xd40             // =3392
               	movk	x17, #0x3, lsl #16
               	add	x0, x0, x17
               	ret

<sub>:
               	sub	x0, x0, x1
               	ret

<twice>:
               	lsl	x0, x0, #1
               	ret

<where>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ret

<msf>:
               	sdiv	x0, x0, x1
               	ret

<main>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x17, #0xa               // =10
               	mul	x0, x0, x17
               	add	x0, x0, #0x898
               	add	x0, x0, #0x1
               	mov	x17, #0xd40             // =3392
               	movk	x17, #0x3, lsl #16
               	add	x0, x0, x17
               	mov	x17, #0x161f            // =5663
               	movk	x17, #0x3, lsl #16
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
