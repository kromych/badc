
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
               	leaq	<rip>, %r8
               	movl	$0x6, %ecx
               	movl	$0x1, %esi
               	movq	%rcx, (%r8)
               	movq	%rsi, 0x8(%r8)
               	leaq	<rip>, %rdi
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	imulq	$0xa, %rax, %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	addq	$0x0, %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	leaq	0x7(%rax), %rcx
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
               	movl	$0x3, %eax
               	movl	$0x4, %ecx
               	movq	%rax, (%r8)
               	movq	%rcx, 0x8(%r8)
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	cmpq	$0x4e, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
