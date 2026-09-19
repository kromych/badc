
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
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	movl	$0x10, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	xorl	%eax, %eax
               	movq	%rax, (%r12)
               	movq	%rbx, 0x8(%r12)
               	movl	$0x10, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r13
               	movl	$0x1, %eax
               	movq	%rax, (%r13)
               	movq	%r12, 0x8(%r13)
               	movl	$0x10, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x2, %eax
               	movq	%rax, (%r12)
               	movq	%r13, 0x8(%r12)
               	movl	$0x10, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r13
               	movl	$0x3, %eax
               	movq	%rax, (%r13)
               	movq	%r12, 0x8(%r13)
               	movl	$0x10, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x4, %ecx
               	movq	%rcx, (%rax)
               	movq	%r13, 0x8(%rax)
               	testq	%rax, %rax
               	je	<addr>
               	movq	(%rax), %rcx
               	addq	%rcx, %rbx
               	movq	0x8(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movslq	%ebx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
