
symbol_inner_array_size_no_leak.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	leaq	(%rax,%rax,2), %rdx
               	movw	%dx, (%rcx,%rax,2)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movswq	0xe(%rcx), %rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	cmpw	$0x0, (%rax)
               	jne	<addr>
               	movswq	0xe(%rax), %rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
