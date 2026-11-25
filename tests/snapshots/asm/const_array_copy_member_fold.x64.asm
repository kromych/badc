
const_array_copy_member_fold.x64:	file format elf64-x86-64

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

<check_field>:
               	movslq	%esi, %rsi
               	shlq	$0x2, %rsi
               	leaq	(%rdi,%rsi), %rax
               	movzbq	(%rax), %rsi
               	movzbq	0x1(%rax), %rdi
               	movzbq	0x2(%rax), %r10
               	movzbq	0x3(%rax), %rax
               	cmpl	%edx, %esi
               	je	<addr>
               	movl	<rip>, %edx # <addr>
               	incq	%rdx
               	movl	%edx, <rip> # <addr>
               	cmpl	%ecx, %edi
               	je	<addr>
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	cmpl	%r8d, %r10d
               	je	<addr>
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	cmpl	%r9d, %eax
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	retq

<main>:
               	subq	$0x18, %rsp
               	movb	$0x8, <rip> # <addr>
               	movzbq	<rip>, %rax # <addr>
               	movzbq	<rip>, %rcx # <addr>
               	movzbq	<rip>, %rdx # <addr>
               	cmpl	$0x4, %eax
               	jne	<addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpl	$0x1, %edx
               	jne	<addr>
               	movl	$0x1, %eax
               	movl	%eax, 0x8(%rsp)
               	leaq	<rip>, %rsi # <addr>
               	movslq	0x8(%rsp), %rcx
               	shlq	$0x2, %rcx
               	addq	%rsi, %rcx
               	movzbq	(%rcx), %rdx
               	movzbq	0x2(%rcx), %rdi
               	cmpl	$0x3c, %edx
               	jne	<addr>
               	cmpl	$0x1, %edi
               	je	<addr>
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	movq	%rsi, %rdi
               	movq	%rax, %r8
               	movq	%rax, %rsi
               	movl	$0x3c, %edx
               	movl	$0x34, %ecx
               	movl	$0x2, %r9d
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%esi, %esi
               	movl	$0x7, %edx
               	movl	$0x5, %ecx
               	xorl	%r8d, %r8d
               	movl	$0x1, %r9d
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x18, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	jmp	<addr>
