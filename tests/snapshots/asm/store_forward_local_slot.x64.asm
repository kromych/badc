
store_forward_local_slot.x64:	file format elf64-x86-64

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

<forwards>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	%edi, -0x20(%rbp)
               	leaq	<rip>, %rax        # <addr>
               	movq	%rax, -0x10(%rbp)
               	movq	%rdi, %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	movl	%ecx, -0x8(%rbp)
               	addq	%rcx, %rcx
               	movl	%ecx, -0x8(%rbp)
               	jmpq	*%rax
               	movslq	-0x8(%rbp), %rax
               	leave
               	retq

<volatile_kept>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movl	%edi, -0x30(%rbp)
               	leaq	<rip>, %rax        # <addr>
               	movq	%rax, -0x8(%rbp)
               	movq	%rdi, %rcx
               	movl	%ecx, -0x10(%rbp)
               	movslq	-0x10(%rbp), %rcx
               	movl	%ecx, -0x18(%rbp)
               	jmpq	*%rax
               	movslq	-0x18(%rbp), %rax
               	leave
               	retq

<aliased_kept>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movl	%edi, -0x30(%rbp)
               	leaq	<rip>, %rax        # <addr>
               	movq	%rax, -0x18(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movq	%rcx, -0x10(%rbp)
               	movq	%rdi, %rdx
               	movl	%edx, -0x8(%rbp)
               	incq	%rdx
               	movl	%edx, (%rcx)
               	movslq	-0x8(%rbp), %rcx
               	movl	%ecx, -0x10(%rbp)
               	jmpq	*%rax
               	movslq	-0x10(%rbp), %rax
               	leave
               	retq

<cross_block>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	%edi, -0x20(%rbp)
               	leaq	<rip>, %rax         # <addr>
               	movq	%rax, -0x8(%rbp)
               	movq	%rdi, %rcx
               	shlq	%rcx
               	movl	%ecx, -0x10(%rbp)
               	jmpq	*%rax
               	movslq	-0x10(%rbp), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpq	$0x1e, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0x7, %edi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x9, %edi
               	callq	<addr>
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0x6, %edi
               	callq	<addr>
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
