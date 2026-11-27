
struct_value_basics.x64:	file format elf64-x86-64

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

<rt>:
               	subq	$0x18, %rsp
               	movl	%edi, 0x8(%rsp)
               	movl	0x8(%rsp), %eax
               	addq	$0x18, %rsp
               	retq

<opaque>:
               	subq	$0x18, %rsp
               	movq	%rdi, 0x8(%rsp)
               	movq	0x8(%rsp), %rax
               	addq	$0x18, %rsp
               	retq

<main>:
               	subq	$0x28, %rsp
               	leaq	0x10(%rsp), %rdi
               	callq	<addr>
               	movq	%rax, 0x8(%rsp)
               	leaq	0x18(%rsp), %rdi
               	callq	<addr>
               	movq	%rax, (%rsp)
               	movl	$0x3, %edi
               	callq	<addr>
               	movl	%eax, 0x10(%rsp)
               	movl	$0x4, %edi
               	callq	<addr>
               	movl	%eax, 0x14(%rsp)
               	movl	0x10(%rsp), %ecx
               	cmpl	$0x3, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x28, %rsp
               	retq
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x1e, %edi
               	callq	<addr>
               	movl	%eax, 0x10(%rsp)
               	movl	$0x28, %edi
               	callq	<addr>
               	movl	%eax, 0x14(%rsp)
               	movl	0x10(%rsp), %ecx
               	cmpl	$0x1e, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x28, %rsp
               	retq
               	cmpl	$0x28, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x64, %edi
               	callq	<addr>
               	movl	%eax, 0x18(%rsp)
               	movl	$0xc8, %edi
               	callq	<addr>
               	movl	%eax, 0x1c(%rsp)
               	movl	0x10(%rsp), %ecx
               	cmpl	$0x1e, %ecx
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	0x18(%rsp), %edx
               	cmpl	$0x64, %edx
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	0x14(%rsp), %esi
               	addq	%rsi, %rcx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	cmpl	$0x172, %eax            # imm = 0x172
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x28, %rsp
               	retq
               	movq	0x8(%rsp), %rax
               	movl	(%rax), %ecx
               	cmpl	$0x1e, %ecx
               	jne	<addr>
               	movl	0x4(%rax), %eax
               	cmpl	$0x28, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x28, %rsp
               	retq
               	movq	(%rsp), %rax
               	movl	(%rax), %ecx
               	cmpl	$0x64, %ecx
               	jne	<addr>
               	movl	0x4(%rax), %eax
               	cmpl	$0xc8, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
