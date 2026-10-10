
inlined_struct_return_lifetime.x64:	file format elf64-x86-64

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

<returned_twice>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx      # <addr>
               	movl	$0xa, %ecx
               	movw	%cx, (%rdx)
               	movswq	%cx, %rcx
               	testl	%ecx, %ecx
               	jg	<addr>
               	leave
               	retq
               	leaq	<rip>, %rcx      # <addr>
               	movq	%rcx, -0x8(%rbp)
               	leave
               	retq

<one_of_two>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movslq	%esi, %rsi
               	leaq	<rip>, %rax      # <addr>
               	movw	$0xa, (%rax)
               	leaq	<rip>, %rax      # <addr>
               	movswq	(%rax), %rax
               	testl	%eax, %eax
               	jg	<addr>
               	movq	-0x30(%rbp), %rax
               	movq	$0x1, (%rax)
               	movq	$0x2, 0x8(%rax)
               	movq	$0x3, 0x10(%rax)
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movq	%rax, -0x8(%rbp)
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	-0x30(%rbp), %rax
               	movq	$0x4, (%rax)
               	movq	$0x5, 0x8(%rax)
               	movq	$0x6, 0x10(%rax)
               	leave
               	retq
               	movq	-0x30(%rbp), %rax
               	movq	$0x1, (%rax)
               	movq	$0x2, 0x8(%rax)
               	movq	$0x3, 0x10(%rax)
               	leave
               	retq

<check_one>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	<rip>, %rdx      # <addr>
               	leaq	-0x10(%rbp), %rax
               	movl	$0x0, (%rax)
               	leaq	<rip>, %rsi      # <addr>
               	movl	$0xa, %ecx
               	movw	%cx, (%rsi)
               	movswq	%cx, %rcx
               	testl	%ecx, %ecx
               	jg	<addr>
               	movl	(%rax), %eax
               	movl	%eax, (%rdx)
               	leave
               	retq
               	leaq	<rip>, %rcx      # <addr>
               	movq	%rcx, -0x8(%rbp)
               	jmp	<addr>

<check_three>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%r12
               	movslq	%edi, %rdi
               	leaq	<rip>, %rsi      # <addr>
               	leaq	<rip>, %r12      # <addr>
               	movw	$0xa, (%r12)
               	leaq	<rip>, %r12      # <addr>
               	movswq	(%r12), %r12
               	testl	%r12d, %r12d
               	jg	<addr>
               	movq	$0x1, -0x18(%rbp)
               	movq	$0x2, -0x10(%rbp)
               	movq	$0x3, -0x8(%rbp)
               	leaq	-0x18(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movq	0x10(%rax), %r10
               	movq	%r10, 0x10(%rsi)
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rcx
               	imulq	$0x64, %rcx, %rcx
               	movq	0x8(%rax), %rdx
               	imulq	$0xa, %rdx, %rdx
               	addq	%rdx, %rcx
               	movq	0x10(%rax), %rax
               	addq	%rcx, %rax
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %r12      # <addr>
               	movq	%r12, -0x20(%rbp)
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	$0x4, -0x18(%rbp)
               	movq	$0x5, -0x10(%rbp)
               	movq	$0x6, -0x8(%rbp)
               	jmp	<addr>
               	movq	$0x1, -0x18(%rbp)
               	movq	$0x2, -0x10(%rbp)
               	movq	$0x3, -0x8(%rbp)
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x9, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0x9, %edi
               	callq	<addr>
               	cmpq	$0x1c8, %rax            # imm = 0x1C8
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	xorl	%edi, %edi
               	callq	<addr>
               	cmpq	$0x7b, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
