
pthread_once_keys.x64:	file format elf64-x86-64

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

<init>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	leave
               	retq

<call_once>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rdi      # <addr>
               	leaq	-<rip>, %rsi       # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movl	$0x1, (%rax)
               	xorl	%eax, %eax
               	popq	%rbp
               	retq

<destroy>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rax      # <addr>
               	movslq	(%rax), %rcx
               	movslq	(%rbx), %rdx
               	addq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	popq	%rbx
               	leave
               	retq

<destroy_again>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movq	%rcx, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %edi
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	popq	%rbx
               	leave
               	retq

<never>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movslq	(%rax), %rcx
               	addq	$0x64, %rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	popq	%rbp
               	retq

<ends_process>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x63, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2

<use_keys>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %edi
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	%rbx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %edi
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	%rbx, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq

<no_value>:
               	xorl	%eax, %eax
               	retq

<set_again>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%rdi, %rsi
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbp
               	retq

<outlives_key>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	%rdi, %rsi
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rbx      # <addr>
               	movl	$0x1, (%rbx)
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	(%rbx), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	leaq	<rip>, %rdi      # <addr>
               	leaq	<rip>, %rsi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	(%rbx), %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x58, %rsp
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	leaq	-0x40(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rax,%rcx), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx      # <addr>
               	movq	%rsi, %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0x8, %ebx
               	jl	<addr>
               	xorl	%ebx, %ebx
               	leaq	-0x40(%rbp), %rax
               	movq	(%rax,%rbx,8), %rdi
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0x8, %ebx
               	jl	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x7c, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	$0x7d, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi      # <addr>
               	leaq	-<rip>, %rsi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7e, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x7f, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	$0x1, (%rax)
               	movl	$0x2, 0x4(%rax)
               	movl	$0x4, 0x8(%rax)
               	movl	$0x8, 0xc(%rax)
               	leaq	<rip>, %rdi      # <addr>
               	leaq	-<rip>, %rsi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x83, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x84, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi      # <addr>
               	leaq	-<rip>, %rsi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x85, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi      # <addr>
               	leaq	-<rip>, %rsi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x86, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi      # <addr>
               	leaq	-<rip>, %rsi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x87, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %edx
               	leaq	<rip>, %rcx      # <addr>
               	movl	(%rcx), %esi
               	cmpl	%esi, %edx
               	je	<addr>
               	movl	(%rcx), %ecx
               	leaq	<rip>, %rdx      # <addr>
               	movl	(%rdx), %edx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movl	$0x88, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	(%rax), %edi
               	leaq	<rip>, %rax      # <addr>
               	leaq	0xc(%rax), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8a, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%ebx, %ebx
               	leaq	-0x40(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rax,%rcx), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx      # <addr>
               	leaq	<rip>, %rax      # <addr>
               	movq	%rbx, %rcx
               	shlq	$0x2, %rcx
               	addq	%rax, %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0x2, %ebx
               	jl	<addr>
               	xorl	%ebx, %ebx
               	leaq	-0x40(%rbp), %rax
               	movq	(%rax,%rbx,8), %rdi
               	leaq	-0x48(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	$0x0, -0x48(%rbp)
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0x2, %ebx
               	jl	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movslq	(%rax), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movslq	(%rax), %rcx
               	leaq	<rip>, %rax      # <addr>
               	movslq	(%rax), %rdx
               	movslq	0x4(%rax), %rax
               	orq	%rdx, %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x92, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rcx      # <addr>
               	addq	$0xc, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x93, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x40(%rbp), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx      # <addr>
               	movq	%rsi, %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%esi, %esi
               	movq	-0x40(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x96, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movslq	(%rax), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x97, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x40(%rbp), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx      # <addr>
               	leaq	<rip>, %rcx      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x99, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%esi, %esi
               	movq	-0x40(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9a, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movslq	(%rax), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x9b, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x40(%rbp), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx      # <addr>
               	leaq	<rip>, %rcx      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9d, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rbx      # <addr>
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi      # <addr>
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa2, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movl	$0x2, (%rax)
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%esi, %esi
               	movq	-0x40(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa7, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movslq	(%rax), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0xa8, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb5, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %edi
               	leaq	<rip>, %rsi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb6, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x8f, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x8e, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x8c, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x7b, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x79, %eax
               	popq	%rbx
               	leave
               	retq
