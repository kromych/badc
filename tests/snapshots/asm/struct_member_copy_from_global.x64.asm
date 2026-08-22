
struct_member_copy_from_global.x64:	file format elf64-x86-64

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

<new_client>:
               	leaq	<rip>, %rax
               	movl	(%rax), %edx
               	movl	$0x9, %ecx
               	movl	%ecx, (%rax)
               	movl	(%rax), %ecx
               	movl	$0x1, %eax
               	movq	%rax, %rsi
               	cmpl	$-0x1, %edx
               	jl	<addr>
               	movq	%rax, %rdx
               	movslq	%edx, %rdx
               	incq	%rdx
               	cmpl	$-0x1, %ecx
               	jl	<addr>
               	movslq	%eax, %rax
               	addq	%rdx, %rax
               	cmpl	$0x9, %ecx
               	jne	<addr>
               	xorq	%rcx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq
               	movl	$0x64, %ecx
               	jmp	<addr>
               	movabsq	$-0x64, %rax
               	jmp	<addr>
               	movabsq	$-0x64, %rdx
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x20(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	leaq	<rip>, %rdx
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	movq	0x10(%rdx), %rcx
               	movq	%rcx, 0x10(%rax)
               	popq	%rcx
               	callq	<addr>
               	testq	%rax, %rax
               	jge	<addr>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	leaq	<rip>, %rdx
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	movq	0x10(%rdx), %rcx
               	movq	%rcx, 0x10(%rax)
               	popq	%rcx
               	movq	%rax, %rdx
               	movslq	(%rax), %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
