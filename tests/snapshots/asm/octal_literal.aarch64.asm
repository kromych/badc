
octal_literal.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400248 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xd0]
               	blr	x16
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x400258 <.text+0x28>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x400268 <.text+0x38>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x400278 <.text+0x48>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x400288 <.text+0x58>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x400298 <.text+0x68>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x15, #0x1e4             // =484
               	cmp	x15, #0x1e4
               	b.eq	0x4002b0 <.text+0x80>
               	mov	x15, #0x6               // =6
               	mov	x0, x15
               	ret
               	mov	x0, #0x180              // =384
               	cmp	x0, #0x180
               	b.eq	0x4002c4 <.text+0x94>
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
               	b.eq	0x4002f8 <.text+0xc8>
               	mov	x15, #0x8               // =8
               	mov	x0, x15
               	ret
               	mov	x0, #0x2a               // =42
               	ret
