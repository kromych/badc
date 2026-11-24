
cleanup_handler_name_shadowed_at_exit.x64:	file format elf64-x86-64

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

<cl>:
               	movl	<rip>, %eax # <addr>
               	movl	(%rdi), %ecx
               	addq	%rcx, %rax
               	movl	%eax, <rip> # <addr>
               	retq

<on_return>:
               	subq	$0x18, %rsp
               	movl	$0x7, 0x8(%rsp)
               	leaq	0x8(%rsp), %rdi
               	callq	<addr>
               	movl	$0xc, %eax
               	addq	$0x18, %rsp
               	retq

<on_break>:
               	subq	$0x18, %rsp
               	pushq	%r12
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	movq	%rbx, %r12
               	jmp	<addr>
               	leaq	0x18(%rsp), %rdi
               	callq	<addr>
               	incq	%rbx
               	movl	%ebx, 0x18(%rsp)
               	addq	$0x2, %r12
               	cmpl	$0x2, %ebx
               	jne	<addr>
               	leaq	0x18(%rsp), %rdi
               	callq	<addr>
               	movq	%r12, %rax
               	popq	%rbx
               	popq	%r12
               	addq	$0x18, %rsp
               	retq

<at_function_end>:
               	subq	$0x18, %rsp
               	movl	$0x64, 0x8(%rsp)
               	leaq	0x8(%rsp), %rdi
               	callq	<addr>
               	movl	$0x2, %eax
               	addq	$0x18, %rsp
               	retq

<main>:
               	subq	$0x10, %rsp
               	pushq	%rbx
               	movl	$0x0, <rip> # <addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpl	$0xc, %eax
               	movl	$0x1, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x7, %eax
               	setne	%al
               	movzbq	%al, %rax
               	xorl	%ecx, %ecx
               	movq	%rcx, %rbx
               	orq	%rax, %rbx
               	movl	$0x0, <rip> # <addr>
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpl	$0x6, %eax
               	movl	$0x1, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x3, %eax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	%rax
               	orq	%rax, %rbx
               	movl	$0x0, <rip> # <addr>
               	callq	<addr>
               	cmpl	$0x2, %eax
               	movl	$0x1, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x64, %eax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x2, %rax
               	orq	%rbx, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	addq	$0x10, %rsp
               	retq
