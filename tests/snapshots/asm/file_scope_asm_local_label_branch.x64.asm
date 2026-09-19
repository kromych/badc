
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
               	xorl	%eax, %eax
               	movl	%eax, (%rdi)
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rbx
               	movl	$0x1, %eax
               	movl	%eax, (%rbx)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movl	(%rbx), %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x3, %eax
               	movl	%eax, (%rbx)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movl	(%rbx), %eax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2a, %eax
               	popq	%rbx
               	leave
               	retq
               	addb	%al, (%rax)

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
