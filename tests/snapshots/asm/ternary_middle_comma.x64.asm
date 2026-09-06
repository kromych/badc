
ternary_middle_comma.x64:	file format elf64-x86-64

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

<rt>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	%edi, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	leaq	-0x8(%rbp), %rax
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	movl	$0x2a, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	%ebx, %edx
               	cmpl	$0x80, %edx
               	jae	<addr>
               	leaq	-0x8(%rbp), %rax
               	movq	%rbx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rax)
               	movl	$0x1, %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	-0x8(%rbp), %rcx
               	movzbq	(%rcx), %rsi
               	xorq	$0x2a, %rsi
               	movl	%esi, %esi
               	testl	%esi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	%eax, %rsi
               	leaq	-0x8(%rbp), %rax
               	movzbq	(%rax), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	xorq	%rsi, %rsi
               	movl	%esi, (%rcx)
               	cmpl	$0x80, %edx
               	jae	<addr>
               	movq	%rbx, %rax
               	andq	$0xff, %rax
               	movb	%al, (%rcx)
               	movl	$0x1, %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movzbq	(%rcx), %rdi
               	xorq	$0x2a, %rdi
               	movl	%edi, %edi
               	testl	%edi, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	%eax, %rsi
               	leaq	-0x8(%rbp), %rax
               	movzbq	(%rax), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movl	%esi, (%rcx)
               	cmpl	$0x80, %edx
               	jae	<addr>
               	leaq	-0x8(%rbp), %rax
               	movq	%rbx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rax)
               	movl	$0x1, %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	-0x8(%rbp), %rcx
               	movzbq	(%rcx), %rcx
               	xorq	$0x2a, %rcx
               	movl	%ecx, %ecx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	%eax, %rsi
               	leaq	-0x8(%rbp), %rax
               	movzbq	(%rax), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	xorq	%r14, %r14
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	testl	%ebx, %ebx
               	jle	<addr>
               	movl	$0x1, %r13d
               	movl	$0x2, %r12d
               	movl	$0x3, %ecx
               	movl	$0x6, %eax
               	cmpl	$0x6, %eax
               	jne	<addr>
               	cmpl	$0x1, %r13d
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	cmpl	$0x2, %r12d
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	cmpl	$0x3, %ecx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	%eax, %rsi
               	movslq	%r13d, %rdx
               	movslq	%r12d, %rax
               	movslq	%ecx, %r8
               	movq	%rax, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	movl	$0xc8, %edi
               	callq	<addr>
               	movl	%eax, %ecx
               	cmpl	$0x80, %ecx
               	jae	<addr>
               	leaq	-0x8(%rbp), %rcx
               	andq	$0xff, %rax
               	movb	%al, (%rcx)
               	movl	$0x1, %eax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	leaq	-0x8(%rbp), %rcx
               	movzbq	(%rcx), %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	%eax, %rsi
               	leaq	-0x8(%rbp), %rax
               	movzbq	(%rax), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movl	$0x63, %eax
               	jmp	<addr>
               	movabsq	$-0x1, %rax
               	jmp	<addr>
               	movl	$0x63, %eax
               	jmp	<addr>
               	movl	$0x63, %eax
               	jmp	<addr>
               	movl	$0x63, %eax
               	jmp	<addr>
