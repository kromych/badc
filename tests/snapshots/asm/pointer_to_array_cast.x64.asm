
pointer_to_array_cast.x64:	file format elf64-x86-64

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
               	subq	$0x30, %rsp
               	xorl	%eax, %eax
               	leaq	-0x30(%rbp), %rcx
               	leaq	(%rax,%rax,2), %rdx
               	movw	%dx, (%rcx,%rax,2)
               	incq	%rax
               	cmpl	$0x18, %eax
               	jl	<addr>
               	leaq	-0x30(%rbp), %rax
               	leaq	0x10(%rax), %rcx
               	subq	%rax, %rcx
               	cmpq	$0x10, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movswq	0x14(%rax), %rcx
               	cmpl	$0x1e, %ecx
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movswq	0xc(%rax), %rax
               	cmpl	$0x12, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
