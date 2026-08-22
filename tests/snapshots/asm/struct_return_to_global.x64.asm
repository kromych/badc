
struct_return_to_global.x64:	file format elf64-x86-64

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
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rax, %rax
               	leaq	<rip>, %r9
               	movl	$0x6, %ecx
               	leaq	-0x10(%rbp), %rsi
               	movq	%rcx, (%rsi)
               	movl	$0x1, %ecx
               	movq	%rcx, 0x8(%rsi)
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%r9)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%r9)
               	popq	%rax
               	movq	%r9, %rcx
               	movq	(%r9), %rcx
               	movq	0x8(%r9), %rdx
               	addq	%rdx, %rcx
               	leaq	(%rcx), %rbx
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movq	%rcx, %rdi
               	shlq	$0x4, %rdi
               	addq	%rdx, %rdi
               	imulq	$0xa, %rcx, %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, (%rsi)
               	leaq	-0x10(%rbp), %rdx
               	movl	$0x1, %r8d
               	movq	%r8, 0x8(%rdx)
               	leaq	-0x10(%rbp), %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rdi)
               	popq	%rax
               	movq	%rdi, %rdx
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	<rip>, %rax
               	addq	$0x0, %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	leaq	(%rbx,%rax), %rcx
               	leaq	<rip>, %rax
               	addq	$0x10, %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rax
               	addq	%rdx, %rax
               	addq	%rax, %rcx
               	leaq	<rip>, %rax
               	addq	$0x20, %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rax
               	addq	%rdx, %rax
               	addq	%rax, %rcx
               	leaq	<rip>, %rax
               	addq	$0x30, %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rax
               	addq	%rdx, %rax
               	leaq	(%rcx,%rax), %rdx
               	leaq	-0x20(%rbp), %rax
               	movl	$0x3, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x4, %ecx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x10(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%r9)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%r9)
               	popq	%rax
               	movq	%r9, %rax
               	movq	(%r9), %rax
               	movq	0x8(%r9), %rcx
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	cmpq	$0x4e, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
