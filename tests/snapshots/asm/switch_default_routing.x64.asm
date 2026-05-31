
switch_default_routing.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x63, %r11d
               	xorq	%r9, %r9
               	movl	%r9d, -0x10(%rbp)
               	movslq	%r11d, %r8
               	jmp	0x400291 <.text+0x71>
               	movslq	-0x10(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %r11d
               	movl	%r11d, -0x10(%rbp)
               	jmp	0x400257 <.text+0x37>
               	movl	$0x14, %r11d
               	movl	%r11d, -0x10(%rbp)
               	jmp	0x400257 <.text+0x37>
               	movl	$0x64, %r11d
               	movl	%r11d, -0x10(%rbp)
               	jmp	0x400257 <.text+0x37>
               	cmpq	$0x1, %r8
               	je	0x400264 <.text+0x44>
               	cmpq	$0x2, %r8
               	je	0x400273 <.text+0x53>
               	jmp	0x400282 <.text+0x62>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
