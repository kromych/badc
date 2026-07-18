
struct_return_to_global.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<store_global>:
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	leaq	<rip>, %rax
               	leaq	-0x10(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	xorq	%rax, %rax
               	leaq	<rip>, %rbx
               	movl	$0x6, %ecx
               	leaq	-0x60(%rbp), %rdx
               	movq	%rcx, (%rdx)
               	leaq	-0x60(%rbp), %rcx
               	movl	$0x1, %edx
               	movq	%rdx, 0x8(%rcx)
               	leaq	-0x60(%rbp), %rcx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rbx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rbx)
               	popq	%rax
               	movq	%rbx, %rcx
               	movq	(%rbx), %rcx
               	movq	0x8(%rbx), %rdx
               	addq	%rdx, %rcx
               	leaq	(%rcx), %r8
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movq	%rcx, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdx, %rsi
               	imulq	$0xa, %rcx, %rdx
               	movslq	%edx, %rdx
               	leaq	-0x70(%rbp), %rdi
               	movq	%rdx, (%rdi)
               	leaq	-0x70(%rbp), %rdx
               	movl	$0x1, %edi
               	movq	%rdi, 0x8(%rdx)
               	leaq	-0x70(%rbp), %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rdx
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	<rip>, %rax
               	addq	$0x0, %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	leaq	(%r8,%rax), %rcx
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
               	leaq	(%rcx,%rax), %r12
               	leaq	-0x48(%rbp), %rax
               	movl	$0x3, %ecx
               	movq	%rcx, (%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	$0x4, %ecx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x48(%rbp), %rdi
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	(%rbx), %rax
               	movq	0x8(%rbx), %rcx
               	addq	%rcx, %rax
               	addq	%r12, %rax
               	cmpq	$0x4e, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
