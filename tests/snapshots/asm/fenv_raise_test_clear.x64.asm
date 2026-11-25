
fenv_raise_test_clear.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	movl	$0x3d, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3d, %edi
               	nop
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax,%rbx,4), %edi
               	nopl	(%rax,%rax)
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax,%rbx,4), %edi
               	nopl	(%rax,%rax)
               	callq	<addr>
               	movslq	%eax, %rax
               	leaq	<rip>, %rcx # <addr>
               	movslq	(%rcx,%rbx,4), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	incq	%rbx
               	nop
               	cmpl	$0x5, %ebx
               	jb	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	movl	$0x5, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1d, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	retq
               	movl	$0x3d, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3d, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	retq
               	leaq	0xa(%rbx), %rax
               	popq	%rbx
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	retq
