
vtable_back_to_back.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	leaq	<rip>, %r12
               	movq	(%r12,%rbx,8), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	(%r12,%rbx,8), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x8, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x10, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	(%rax,%rbx,8), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	(%rax), %rax
               	movq	%rax, (%r12,%rbx,8)
               	jmp	<addr>
               	movq	(%r12,%rbx,8), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	%edx, %rdx
               	movslq	%ecx, %rcx
               	leaq	<rip>, %rax
               	movq	%rax, (%rdi)
               	movq	%rdi, %rax
               	addq	$0x8, %rax
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	retq
               	movq	%rdx, %rax
               	movslq	%eax, %rax
               	movq	%rdi, %rcx
               	addq	$0x8, %rcx
               	movslq	(%rcx), %rcx
               	movl	%ecx, (%rsi)
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rcx), %r11
               	movq	%r11, 0x8(%rax)
               	popq	%r11
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	-0x10(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x2a, %edx
               	movl	$0x8, %ecx
               	movq	%rax, %r11
               	callq	*%r11
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rax
               	leaq	-0x10(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x1, %edx
               	movq	%rax, %r11
               	callq	*%r11
               	leaq	<rip>, %rdi
               	movslq	-0x40(%rbp), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	-0x40(%rbp), %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
