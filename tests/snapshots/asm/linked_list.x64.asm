
linked_list.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x10, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	movq	$0x0, (%rbx)
               	movq	$0x0, 0x8(%rbx)
               	movl	$0x10, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	movq	$0x1, (%r12)
               	movq	%rbx, 0x8(%r12)
               	movl	$0x10, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	movq	$0x2, (%rbx)
               	movq	%r12, 0x8(%rbx)
               	movl	$0x10, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	movq	$0x3, (%r12)
               	movq	%rbx, 0x8(%r12)
               	movl	$0x10, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	$0x4, (%rax)
               	movq	%r12, 0x8(%rax)
               	xorl	%ecx, %ecx
               	testq	%rax, %rax
               	je	<addr>
               	movq	(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x8(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
