
file_scope_asm_local_label_branch.x64:	file format elf64-x86-64

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

<slowpath_handler>:
               	leaq	<rip>, %rax
               	movl	(%rax), %ecx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movl	$0x0, (%rdi)
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rdi
               	movl	$0x1, (%rdi)
               	callq	<addr>
               	leaq	<rip>, %rdi
               	cmpl	$0x0, (%rdi)
               	jne	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0x3, (%rdi)
               	callq	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	popq	%rbp
               	retq

<pv_unlock>:
               	pushq	%rdx
               	movl	$0x1, %eax
               	xorl	%edx, %edx
               	lock
               	cmpxchgb	%dl, (%rdi)
               	jne	<addr>
               	popq	%rdx
               	retq
               	pushq	%rsi
               	movzbl	%al, %esi
               	callq	<addr>
               	popq	%rsi
               	popq	%rdx
               	retq
