
anon_member_inner_brace.x64:	file format elf64-x86-64

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

<dsame>:
               	movslq	(%rdi), %rax
               	movslq	(%rsi), %rcx
               	cmpl	%ecx, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	0x4(%rdi), %rcx
               	movslq	0x4(%rsi), %rdx
               	cmpl	%edx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	0x8(%rdi), %rcx
               	movslq	0x8(%rsi), %rdx
               	cmpl	%edx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	0xc(%rdi), %rcx
               	movslq	0xc(%rsi), %rdx
               	cmpl	%edx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	0x10(%rdi), %rcx
               	movslq	0x10(%rsi), %rdx
               	cmpl	%edx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	0x14(%rdi), %rax
               	movslq	0x14(%rsi), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	retq
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	leaq	<rip>, %rax
               	leaq	<rip>, %rbx
               	movsbq	(%rax), %rcx
               	movsbq	(%rbx), %rdx
               	cmpl	%edx, %ecx
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorq	%rcx, %rcx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	0x4(%rax), %rdx
               	movsbq	0x4(%rbx), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	0x8(%rax), %rdx
               	movsbq	0x8(%rbx), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movslq	0xc(%rax), %rdx
               	movslq	0xc(%rbx), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	0x10(%rax), %rax
               	movsbq	0x10(%rbx), %rdx
               	cmpl	%edx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rdx
               	movsbq	(%rbx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	movsbq	0x4(%rax), %rcx
               	movsbq	0x4(%rbx), %rdx
               	cmpl	%edx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rdx, %rdx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	0x8(%rax), %rcx
               	movsbq	0x8(%rbx), %rsi
               	cmpl	%esi, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	0xc(%rax), %rcx
               	movslq	0xc(%rbx), %rsi
               	cmpl	%esi, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	0x10(%rax), %rax
               	movsbq	0x10(%rbx), %rcx
               	cmpl	%ecx, %eax
               	sete	%dl
               	movzbq	%dl, %rdx
               	movslq	%edx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	movl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	0x4(%rcx), %rcx
               	cmpl	$0x2, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	0xc(%rcx), %rcx
               	cmpl	$0x3, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movzbq	0x8(%rcx), %rcx
               	xorq	$0x7, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x9(%rax), %rax
               	xorq	$0x8, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0xa(%rax), %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movsbq	(%rbx), %rax
               	cmpl	$0x1, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	0x4(%rbx), %rcx
               	cmpl	$0x2, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	0x8(%rbx), %rcx
               	cmpl	$0x3, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	0xc(%rbx), %rcx
               	cmpl	$0x4, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	0x10(%rbx), %rcx
               	cmpl	$0x5, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movsbq	(%rbx), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movsbq	0x4(%rbx), %rcx
               	cmpl	$0x2, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	0x8(%rbx), %rax
               	cmpl	$0x3, %eax
               	sete	%al
               	movzbq	%al, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movslq	0xc(%rbx), %rax
               	cmpl	$0x4, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movsbq	0x10(%rbx), %rax
               	cmpl	$0x5, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rdx
               	movsbq	(%rbx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	movsbq	0x4(%rax), %rdx
               	movsbq	0x4(%rbx), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	0x8(%rax), %rdx
               	movsbq	0x8(%rbx), %rsi
               	cmpl	%esi, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movslq	0xc(%rax), %rcx
               	movslq	0xc(%rbx), %rdx
               	cmpl	%edx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rdx, %rdx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	0x10(%rax), %rax
               	movsbq	0x10(%rbx), %rcx
               	cmpl	%ecx, %eax
               	sete	%dl
               	movzbq	%dl, %rdx
               	movslq	%edx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
