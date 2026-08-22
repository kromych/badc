
va_arg_int_seq.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<show>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xe0, %rsp
               	movq	%rdi, -0xd0(%rbp)
               	movq	%rsi, -0xc8(%rbp)
               	movq	%rdx, -0xc0(%rbp)
               	movq	%rcx, -0xb8(%rbp)
               	movq	%r8, -0xb0(%rbp)
               	movq	%r9, -0xa8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movsd	%xmm0, -0xa0(%rbp,%riz)
               	movsd	%xmm1, -0x90(%rbp,%riz)
               	movsd	%xmm2, -0x80(%rbp,%riz)
               	movsd	%xmm3, -0x70(%rbp,%riz)
               	movsd	%xmm4, -0x60(%rbp,%riz)
               	movsd	%xmm5, -0x50(%rbp,%riz)
               	movsd	%xmm6, -0x40(%rbp,%riz)
               	movsd	%xmm7, -0x30(%rbp,%riz)
               	movq	%rbx, (%rsp)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xc8(%rbp), %rcx
               	movl	$0x10, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	leaq	<rip>, %rdi
               	movq	-0xd0(%rbp), %rsi
               	movslq	-0xc8(%rbp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rbx, %rbx
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rax
               	movq	%rax, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x8, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rax
               	movslq	(%rax), %rdx
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	%ebx, %rax
               	leaq	0x1(%rax), %rbx
               	movslq	%ebx, %rsi
               	movslq	-0xc8(%rbp), %rax
               	cmpq	%rax, %rsi
               	jl	<addr>
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rdi
               	movl	$0x3, %esi
               	movl	$0xb, %edx
               	movl	$0x16, %ecx
               	movl	$0x21, %r8d
               	movb	$0x0, %al
               	callq	<addr>
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
