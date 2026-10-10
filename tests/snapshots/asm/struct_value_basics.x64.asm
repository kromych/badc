
struct_value_basics.x64:	file format elf64-x86-64

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

<rt>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	%edi, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	leave
               	retq

<opaque>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	pushq	%r12
               	pushq	%rbx
               	leaq	-0x10(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x3, %edi
               	callq	<addr>
               	movl	%eax, -0x10(%rbp)
               	movl	$0x4, %edi
               	callq	<addr>
               	movl	%eax, -0xc(%rbp)
               	movl	-0x10(%rbp), %eax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	-0xc(%rbp), %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x1e, %edi
               	callq	<addr>
               	movl	%eax, -0x10(%rbp)
               	movl	$0x28, %edi
               	callq	<addr>
               	movl	%eax, -0xc(%rbp)
               	movl	-0x10(%rbp), %eax
               	cmpl	$0x1e, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	-0xc(%rbp), %eax
               	cmpl	$0x28, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x64, %edi
               	callq	<addr>
               	movl	%eax, -0x8(%rbp)
               	movl	$0xc8, %edi
               	callq	<addr>
               	movl	%eax, -0x4(%rbp)
               	movl	-0x10(%rbp), %eax
               	cmpl	$0x1e, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	-0x8(%rbp), %eax
               	cmpl	$0x64, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	-0x10(%rbp), %eax
               	movl	-0xc(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	-0x8(%rbp), %ecx
               	addq	%rcx, %rax
               	movl	-0x4(%rbp), %ecx
               	addq	%rcx, %rax
               	cmpl	$0x172, %eax            # imm = 0x172
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	(%rbx), %eax
               	cmpl	$0x1e, %eax
               	jne	<addr>
               	movl	0x4(%rbx), %eax
               	cmpl	$0x28, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	(%r12), %eax
               	cmpl	$0x64, %eax
               	jne	<addr>
               	movl	0x4(%r12), %eax
               	cmpl	$0xc8, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
