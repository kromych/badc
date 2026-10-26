
cleanup_handler_name_shadowed_at_exit.x64:	file format elf64-x86-64

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

<cl>:
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %ecx
               	movl	(%rdi), %edx
               	addq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	retq

<on_return>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x7, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	movl	$0xc, %eax
               	leave
               	retq

<on_break>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	pushq	%r12
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	movq	%rbx, %r12
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	incq	%rbx
               	movl	%ebx, -0x8(%rbp)
               	addq	$0x2, %r12
               	cmpl	$0x2, %ebx
               	jne	<addr>
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	movq	%r12, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<at_function_end>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movl	$0x64, -0x8(%rbp)
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movabsq	$0x4010000000000000, %rcx # imm = 0x4010000000000000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	vmulsd	%xmm15, %xmm14, %xmm0
               	cvttsd2si	%xmm0, %rbx
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	movq	%rbx, %rax
               	popq	%rbx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rcx # <addr>
               	movl	$0x0, (%rcx)
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpl	$0xc, %eax
               	movl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x7, %eax
               	setne	%al
               	movzbq	%al, %rax
               	xorl	%ecx, %ecx
               	movq	%rcx, %rbx
               	orq	%rax, %rbx
               	leaq	<rip>, %rax # <addr>
               	movl	$0x0, (%rax)
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpl	$0x6, %eax
               	movl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x3, %eax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	%rax
               	orq	%rax, %rbx
               	leaq	<rip>, %rax # <addr>
               	movl	$0x0, (%rax)
               	callq	<addr>
               	cmpl	$0x2, %eax
               	movl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x64, %eax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x2, %rax
               	orq	%rbx, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	leave
               	retq
