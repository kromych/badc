
inline_into_computed_goto.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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

<interp>:
               	subq	$0x28, %rsp
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx # <addr>
               	movq	%rcx, 0x8(%rsp)
               	leaq	<rip>, %rcx # <addr>
               	movq	%rcx, 0x10(%rsp)
               	leaq	<rip>, %rcx # <addr>
               	movq	%rcx, 0x18(%rsp)
               	movl	$0x1, %ecx
               	movslq	(%rdi), %r8
               	movq	0x8(%rsp,%r8,8), %rdx
               	jmpq	*%rdx
               	leaq	0x1(%rcx), %rdx
               	movslq	(%rdi,%rcx,4), %rcx
               	movq	(%rsi,%rcx,8), %rcx
               	andq	$-0x4, %rcx
               	addq	%rcx, %rax
               	leaq	0x1(%rdx), %rcx
               	movslq	(%rdi,%rdx,4), %rdx
               	movq	0x8(%rsp,%rdx,8), %rdx
               	jmpq	*%rdx
               	addq	%rax, %rax
               	leaq	0x1(%rcx), %r8
               	movslq	(%rdi,%rcx,4), %rcx
               	movq	0x8(%rsp,%rcx,8), %rdx
               	movq	%r8, %rcx
               	jmpq	*%rdx
               	addq	$0x28, %rsp
               	retq

<main>:
               	subq	$0x48, %rsp
               	movq	$0x67, 0x8(%rsp)
               	movq	$0xc9, 0x10(%rsp)
               	movq	$0x12c, 0x18(%rsp)      # imm = 0x12C
               	leaq	0x20(%rsp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x1, %edx
               	cmpq	$0x384, %rax            # imm = 0x384
               	cmovneq	%rdx, %rcx
               	movq	%rcx, %rax
               	addq	$0x48, %rsp
               	retq
