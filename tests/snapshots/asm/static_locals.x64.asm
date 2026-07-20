
static_locals.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movslq	%ecx, %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movslq	%ecx, %rcx
               	cmpq	$0x2, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movslq	%ecx, %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rax
               	incq	%rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rsi
               	movslq	%eax, %rax
               	addq	%rsi, %rax
               	movl	%eax, (%rdx)
               	movslq	(%rcx), %rcx
               	movslq	%eax, %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0xca, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rax
               	incq	%rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rsi
               	movslq	%eax, %rax
               	addq	%rsi, %rax
               	movl	%eax, (%rdx)
               	movslq	(%rcx), %rcx
               	movslq	%eax, %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x131, %rax            # imm = 0x131
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rax
               	movl	$0x64, %ecx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rax
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rax
               	incq	%rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rsi
               	movslq	%eax, %rax
               	addq	%rsi, %rax
               	movl	%eax, (%rdx)
               	movslq	(%rcx), %rcx
               	movslq	%eax, %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0xca, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rax
               	incq	%rax
               	movl	%eax, (%rcx)
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rax
               	incq	%rax
               	movl	%eax, (%rcx)
               	movslq	%eax, %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rax
               	incq	%rax
               	movl	%eax, (%rcx)
               	movslq	%eax, %rax
               	cmpq	$0x3e9, %rax            # imm = 0x3E9
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rax
               	incq	%rax
               	movl	%eax, (%rcx)
               	movslq	%eax, %rax
               	cmpq	$0x3ea, %rax            # imm = 0x3EA
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rax
               	incq	%rax
               	movl	%eax, (%rcx)
               	movslq	%eax, %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	xorq	%rax, %rax
               	retq
