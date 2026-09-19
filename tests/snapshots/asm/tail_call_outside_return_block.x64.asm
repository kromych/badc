
tail_call_outside_return_block.x64:	file format elf64-x86-64

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

<make>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movslq	%r8d, %r8
               	leaq	<rip>, %rax
               	movslq	(%rax), %r9
               	incq	%r9
               	movl	%r9d, (%rax)
               	cmpl	$0x3e8, %r8d            # imm = 0x3E8
               	jle	<addr>
               	movl	%edi, %edi
               	movl	%esi, %esi
               	decq	%r8
               	popq	%rbp
               	jmp	<addr>
               	cmpl	$0x40001, %edi          # imm = 0x40001
               	jne	<addr>
               	cmpl	$0x2, %esi
               	jne	<addr>
               	testq	%rdx, %rdx
               	jne	<addr>
               	cmpq	$0x7, %rcx
               	jne	<addr>
               	cmpl	$0x3, %r8d
               	je	<addr>
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	popq	%rbp
               	retq

<wrap>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movslq	%r8d, %r8
               	movl	%edi, %eax
               	movq	%rax, %rdi
               	orq	$0x40000, %rdi          # imm = 0x40000
               	movl	%esi, %esi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movq	0x18(%rax), %rcx
               	testb	$0x4, %cl
               	je	<addr>
               	popq	%rbp
               	retq
               	movq	0x10(%rax), %rcx
               	testb	$0x2, %cl
               	jne	<addr>
               	movq	0x8(%rax), %rcx
               	testb	$0x1, %cl
               	jne	<addr>
               	movq	(%rax), %rcx
               	testb	$0x40, %cl
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	xorl	%edx, %edx
               	movl	$0x7, %ecx
               	movl	$0x3, %r8d
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
