
inline_struct_return_multi_block.x64:	file format elf64-x86-64

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

<reg_slot>:
               	testl	%esi, %esi
               	jne	<addr>
               	movq	$-0x1, %rax
               	retq
               	andq	$0x3, %rsi
               	movl	(%rdi,%rsi,4), %eax
               	jmp	<addr>

<main>:
               	subq	$0x28, %rsp
               	movl	$0x20, 0x18(%rsp)
               	leaq	<rip>, %rsi # <addr>
               	movl	0x18(%rsp), %eax
               	leaq	<rip>, %rcx # <addr>
               	shrq	$0x5, %rax
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movl	$0x1, <rip> # <addr>
               	cmpl	$0x4, %eax
               	jb	<addr>
               	movl	$0x1, <rip> # <addr>
               	imulq	$0x18, %rax, %rax
               	addq	%rcx, %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movl	$0x1, <rip> # <addr>
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %edx
               	movzwq	0x8(%rax), %rdi
               	movzbq	0xa(%rax), %r8
               	movzbq	0xb(%rax), %r9
               	movq	0x10(%rax), %r10
               	movq	%r10, 0x8(%rsp)
               	testl	%ecx, %ecx
               	jne	<addr>
               	movq	$-0x1, %rax
               	testl	%eax, %eax
               	jge	<addr>
               	movl	$0x6, %eax
               	addq	$0x28, %rsp
               	retq
               	movslq	%edx, %rcx
               	addq	%rcx, %rax
               	addq	%rdi, %rax
               	movsbq	%r8b, %rcx
               	addq	%rcx, %rax
               	addq	%r9, %rax
               	movq	0x8(%rsp), %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	addq	%rcx, %rax
               	cmpq	$0x100f1, %rax          # imm = 0x100F1
               	jne	<addr>
               	movslq	<rip>, %rax # <addr>
               	movl	$0x7, %ecx
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	movq	%rdx, %rax
               	cmovneq	%rcx, %rax
               	addq	$0x28, %rsp
               	retq
               	movq	%rcx, %rax
               	andq	$0x3, %rax
               	movslq	(%rsi,%rax,4), %rax
               	jmp	<addr>
