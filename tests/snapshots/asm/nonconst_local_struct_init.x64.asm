
nonconst_local_struct_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movl	$0x2a, %ecx
               	movl	$0x63, %eax
               	xorq	%rdx, %rdx
               	xorq	%rdx, %rdx
               	xorq	%rdx, %rdx
               	leaq	-0x10(%rbp), %rdx
               	xorq	%rsi, %rsi
               	movq	%rsi, (%rdx)
               	movl	%esi, 0x8(%rdx)
               	leaq	-0x10(%rbp), %rdx
               	movl	%ecx, (%rdx)
               	leaq	-0x10(%rbp), %rdx
               	movl	%eax, 0x8(%rdx)
               	xorq	%rdx, %rdx
               	xorq	%rdx, %rdx
               	leaq	-0x20(%rbp), %rdx
               	xorq	%rsi, %rsi
               	movq	%rsi, (%rdx)
               	movl	%esi, 0x8(%rdx)
               	leaq	-0x20(%rbp), %rdx
               	movl	%eax, 0x8(%rdx)
               	leaq	-0x20(%rbp), %rdx
               	movl	%ecx, (%rdx)
               	xorq	%rdx, %rdx
               	xorq	%rdx, %rdx
               	leaq	-0x30(%rbp), %rdx
               	xorq	%rsi, %rsi
               	movq	%rsi, (%rdx)
               	movl	%esi, 0x8(%rdx)
               	leaq	-0x30(%rbp), %rdx
               	movl	%ecx, (%rdx)
               	leaq	-0x30(%rbp), %rcx
               	movl	%eax, 0x8(%rcx)
               	xorq	%rcx, %rcx
               	xorq	%rcx, %rcx
               	leaq	-0x40(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movzbq	0x8(%rdx), %rax
               	movb	%al, 0x8(%rcx)
               	movzbq	0x9(%rdx), %rax
               	movb	%al, 0x9(%rcx)
               	movzbq	0xa(%rdx), %rax
               	movb	%al, 0xa(%rcx)
               	movzbq	0xb(%rdx), %rax
               	movb	%al, 0xb(%rcx)
               	popq	%rax
               	leaq	-0x50(%rbp), %rcx
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rcx)
               	movl	%edx, 0x8(%rcx)
               	leaq	-0x50(%rbp), %rcx
               	movl	%eax, 0x4(%rcx)
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
