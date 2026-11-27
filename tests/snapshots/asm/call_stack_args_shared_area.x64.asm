
call_stack_args_shared_area.x64:	file format elf64-x86-64

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

<sum10>:
               	leaq	(%rdi,%rsi), %rax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	movq	0x8(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x10(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x18(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x20(%rsp), %rcx
               	addq	%rcx, %rax
               	retq

<sum11>:
               	leaq	(%rdi,%rsi), %rax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	movq	0x8(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x10(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x18(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x20(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x28(%rsp), %rcx
               	addq	%rcx, %rax
               	retq

<main>:
               	subq	$0x10, %rsp
               	pushq	%rbx
               	subq	$0x30, %rsp
               	movq	<rip>, %rax # <addr>
               	movq	$0x7, (%rsp)
               	movq	$0x8, 0x8(%rsp)
               	movq	$0x9, 0x10(%rsp)
               	movq	$0xa, 0x18(%rsp)
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movl	$0x3, %edx
               	movl	$0x4, %ecx
               	movl	$0x5, %r8d
               	movl	$0x6, %r9d
               	callq	*%rax
               	movq	%rax, %rbx
               	movq	<rip>, %rax # <addr>
               	movq	$0x4, (%rsp)
               	movq	$0x3, 0x8(%rsp)
               	movq	$0x2, 0x10(%rsp)
               	movq	$0x1, 0x18(%rsp)
               	movq	$0x0, 0x20(%rsp)
               	movl	$0xa, %edi
               	movl	$0x9, %esi
               	movl	$0x8, %edx
               	movl	$0x7, %ecx
               	movl	$0x6, %r8d
               	movl	$0x5, %r9d
               	callq	*%rax
               	addq	%rbx, %rax
               	subq	$0x6e, %rax
               	addq	$0x30, %rsp
               	popq	%rbx
               	addq	$0x10, %rsp
               	retq
