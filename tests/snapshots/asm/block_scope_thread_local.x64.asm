
block_scope_thread_local.x64:	file format elf64-x86-64

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

<counter>:
               	movq	%fs:0x0, %rax
               	addq	$-0x60, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movslq	%ecx, %rax
               	retq

<array_and_struct>:
               	movq	%fs:0x0, %rax
               	addq	$-0x58, %rax
               	movb	$0x5, 0x3(%rax)
               	movq	%fs:0x0, %rcx
               	addq	$-0x18, %rcx
               	movq	$0x9, (%rcx)
               	movq	$0xb, 0x8(%rcx)
               	movsbq	0x3(%rax), %rax
               	addq	$0x9, %rax
               	addq	$0xb, %rax
               	retq

<with_bool>:
               	movq	%fs:0x0, %rcx
               	addq	$-0x8, %rcx
               	cmpl	$0x0, (%rcx)
               	je	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x1, %eax
               	movl	%eax, (%rcx)
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x19, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
