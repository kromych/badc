
pthread_create.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movq	%rdi, %r11
               	movl	$0xb, %eax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	xorq	%rbx, %rbx
               	movl	$0x2, %r12d
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	<rip>, %r15
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x28(%rsp)
               	leaq	<rip>, %r15
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	-0x20(%rbp), %r14
               	leaq	-<rip>, %r15       # <addr>
               	movq	0x28(%rsp), %r11
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r15, %rdx
               	movq	%rbx, %rsi
               	callq	*%r11
               	movq	-0x20(%rbp), %rbx
               	leaq	-0x28(%rbp), %r14
               	movq	%r12, %r11
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	callq	*%r11
               	movq	-0x28(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
