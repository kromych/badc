
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
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx
               	movq	$0x6, (%rcx)
               	movq	$0x1, 0x8(%rcx)
               	leaq	<rip>, %rsi
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rsi, %rcx
               	imulq	$0xa, %rax, %rdi
               	movslq	%edi, %rdi
               	movq	%rdi, (%rcx)
               	movq	$0x1, 0x8(%rcx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	addq	%rdx, %rcx
               	leaq	0x7(%rcx), %rdx
               	leaq	0x10(%rax), %rcx
               	movq	(%rcx), %rsi
               	movq	0x8(%rcx), %rcx
               	addq	%rsi, %rcx
               	addq	%rcx, %rdx
               	leaq	0x20(%rax), %rcx
               	movq	(%rcx), %rsi
               	movq	0x8(%rcx), %rcx
               	addq	%rsi, %rcx
               	addq	%rdx, %rcx
               	addq	$0x30, %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rax
               	addq	%rdx, %rax
               	leaq	(%rcx,%rax), %rsi
               	movl	$0x3, %eax
               	movl	$0x4, %ecx
               	leaq	<rip>, %rdx
               	movq	%rax, (%rdx)
               	movq	%rcx, 0x8(%rdx)
               	addq	%rcx, %rax
               	addq	%rsi, %rax
               	cmpq	$0x4e, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
