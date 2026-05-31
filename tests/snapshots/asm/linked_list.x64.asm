
linked_list.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400287 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe51(%rip)           # 0x4100d8
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%r11, %r11
               	movq	%r11, -0x8(%rbp)
               	movl	%r11d, -0x20(%rbp)
               	movl	%r11d, -0x28(%rbp)
               	jmp	0x4002aa <.text+0x3a>
               	movslq	-0x28(%rbp), %r11
               	cmpq	$0x5, %r11
               	jge	0x400320 <.text+0xb0>
               	jmp	0x4002d9 <.text+0x69>
               	leaq	-0x28(%rbp), %r11
               	movslq	(%r11), %r9
               	movq	%r9, %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%r11)
               	jmp	0x4002aa <.text+0x3a>
               	movl	$0x10, %r8d
               	movslq	%r8d, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x4004c7 <malloc>
               	movq	%rax, %r9
               	movq	%r9, -0x18(%rbp)
               	movq	-0x18(%rbp), %rbx
               	movslq	-0x28(%rbp), %r9
               	movq	%r9, (%rbx)
               	movq	-0x18(%rbp), %r11
               	movq	%r11, %r9
               	addq	$0x8, %r9
               	movq	-0x8(%rbp), %r11
               	movq	%r11, (%r9)
               	movq	-0x18(%rbp), %rbx
               	movq	%rbx, -0x8(%rbp)
               	jmp	0x4002c0 <.text+0x50>
               	movq	-0x8(%rbp), %rbx
               	movq	%rbx, -0x10(%rbp)
               	jmp	0x40032d <.text+0xbd>
               	movq	-0x10(%rbp), %rbx
               	cmpq	$0x0, %rbx
               	je	0x400368 <.text+0xf8>
               	movslq	-0x20(%rbp), %rbx
               	movq	-0x10(%rbp), %r11
               	movq	(%r11), %r9
               	movq	%rbx, %rdi
               	addq	%r9, %rdi
               	movl	%edi, -0x20(%rbp)
               	movq	%r11, %r9
               	addq	$0x8, %r9
               	movq	(%r9), %r11
               	movq	%r11, -0x10(%rbp)
               	jmp	0x40032d <.text+0xbd>
               	movslq	-0x20(%rbp), %r11
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
