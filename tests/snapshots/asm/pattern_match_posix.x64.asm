
pattern_match_posix.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	xorq	%rbx, %rbx
               	cmpl	$0x37, %ebx
               	jge	<addr>
               	leaq	<rip>, %r12
               	movslq	%ebx, %rax
               	imulq	$0x18, %rax, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rsi
               	movslq	0x10(%rax), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%ebx, %rcx
               	imulq	$0x18, %rcx, %rcx
               	addq	%r12, %rcx
               	movslq	0x14(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0x37, %ebx
               	jl	<addr>
               	xorq	%rbx, %rbx
               	cmpl	$0x2f, %ebx
               	jge	<addr>
               	leaq	-0x50(%rbp), %rdi
               	leaq	<rip>, %rax
               	movslq	%ebx, %r12
               	imulq	$0x30, %r12, %r13
               	addq	%r13, %rax
               	movq	(%rax), %rsi
               	movslq	0x8(%rax), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movabsq	$-0x2, %rcx
               	movl	%ecx, (%rax)
               	movl	%ecx, 0x4(%rax)
               	movl	%ecx, 0x8(%rax)
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x50(%rbp), %rdi
               	leaq	<rip>, %rax
               	leaq	(%rax,%r13), %rcx
               	movq	0x10(%rcx), %rsi
               	movl	$0x2, %edx
               	leaq	-0x10(%rbp), %rcx
               	movslq	%ebx, %r12
               	imulq	$0x30, %r12, %r13
               	addq	%r13, %rax
               	movslq	0x18(%rax), %r8
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	leaq	<rip>, %rcx
               	addq	%r13, %rcx
               	movslq	0x1c(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rdi
               	leaq	<rip>, %rsi
               	movslq	%ebx, %rcx
               	imulq	$0x30, %rcx, %rdx
               	addq	%rdx, %rsi
               	movslq	0x20(%rsi), %rsi
               	cmpl	%esi, %edi
               	jne	<addr>
               	movslq	0x4(%rax), %rdi
               	leaq	<rip>, %rsi
               	addq	%rdx, %rsi
               	movslq	0x24(%rsi), %rsi
               	cmpl	%esi, %edi
               	jne	<addr>
               	movslq	0x8(%rax), %rsi
               	leaq	<rip>, %rax
               	addq	%rdx, %rax
               	movslq	0x28(%rax), %rax
               	cmpl	%eax, %esi
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movslq	0xc(%rax), %rcx
               	leaq	<rip>, %rax
               	movslq	%ebx, %rdx
               	imulq	$0x30, %rdx, %rdx
               	addq	%rdx, %rax
               	movslq	0x2c(%rax), %rax
               	cmpl	%eax, %ecx
               	je	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	-0x50(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	incq	%rbx
               	cmpl	$0x2f, %ebx
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x50(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x38(%rbx), %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x50(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	0x38(%rbx), %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	0x38(%rbx), %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	0x1(%rbx), %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
