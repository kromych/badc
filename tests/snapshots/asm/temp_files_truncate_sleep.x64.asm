
temp_files_truncate_sleep.x64:	file format elf64-x86-64

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
               	subq	$0x6a0, %rsp            # imm = 0x6A0
               	pushq	%rbx
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	leaq	<rip>, %rbx
               	leaq	0x48(%rsp), %rdi
               	movl	$0x200, %esi            # imm = 0x200
               	leaq	<rip>, %rdx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	0x248(%rsp), %rdi
               	movl	$0x200, %esi            # imm = 0x200
               	leaq	<rip>, %rdx
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	0x48(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	testq	%rbx, %rbx
               	jl	<addr>
               	leaq	0x48(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	addq	$0x6a0, %rsp            # imm = 0x6A0
               	retq
               	leaq	<rip>, %rsi
               	movl	$0x6, %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	addq	$0x6a0, %rsp            # imm = 0x6A0
               	retq
               	movl	$0x2, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%esi, %esi
               	movl	$0x2, %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	addq	$0x6a0, %rsp            # imm = 0x6A0
               	retq
               	movl	$0xa, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%esi, %esi
               	movl	$0x2, %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	addq	$0x6a0, %rsp            # imm = 0x6A0
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	0x48(%rsp), %rdi
               	movl	$0x4, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x48(%rsp), %rdi
               	xorl	%esi, %esi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	testl	%ebx, %ebx
               	jge	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	addq	$0x6a0, %rsp            # imm = 0x6A0
               	retq
               	xorl	%esi, %esi
               	movl	$0x2, %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x18(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	0x18(%rsp), %rax
               	cmpq	$0x4, %rax
               	jne	<addr>
               	leaq	0x48(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	addq	$0x6a0, %rsp            # imm = 0x6A0
               	retq
               	leaq	0x248(%rsp), %rdi
               	callq	<addr>
               	leaq	0x248(%rsp), %rdi
               	cmpq	%rdi, %rax
               	jne	<addr>
               	leaq	<rip>, %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	addq	$0x6a0, %rsp            # imm = 0x6A0
               	retq
               	leaq	0x448(%rsp), %rdi
               	movl	$0x258, %esi            # imm = 0x258
               	leaq	<rip>, %rdx
               	leaq	0x248(%rsp), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	0x448(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	addq	$0x6a0, %rsp            # imm = 0x6A0
               	retq
               	callq	<addr>
               	leaq	0x448(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x248(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	addq	$0x6a0, %rsp            # imm = 0x6A0
               	retq
               	leaq	0x38(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	callq	<addr>
               	movl	$0x0, (%rax)
               	leaq	0x38(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x16, %eax
               	jne	<addr>
               	leaq	0x38(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	addq	$0x6a0, %rsp            # imm = 0x6A0
               	retq
               	callq	<addr>
               	movl	$0x0, (%rax)
               	leaq	0x38(%rsp), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x16, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	addq	$0x6a0, %rsp            # imm = 0x6A0
               	retq
               	xorl	%edi, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	addq	$0x6a0, %rsp            # imm = 0x6A0
               	retq
               	movl	$0x1, %edi
               	leaq	0x28(%rsp), %rsi
               	callq	<addr>
               	movl	$0x7d0, %edi            # imm = 0x7D0
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	addq	$0x6a0, %rsp            # imm = 0x6A0
               	retq
               	movl	$0x1, %edi
               	leaq	0x38(%rsp), %rsi
               	callq	<addr>
               	movq	0x38(%rsp), %rax
               	movq	0x28(%rsp), %rcx
               	subq	%rcx, %rax
               	imulq	$0x3b9aca00, %rax, %rax # imm = 0x3B9ACA00
               	movq	0x40(%rsp), %rcx
               	movq	0x30(%rsp), %rdx
               	subq	%rdx, %rcx
               	addq	%rcx, %rax
               	movl	$0xe, %ecx
               	xorl	%edx, %edx
               	cmpq	$0x1e8480, %rax         # imm = 0x1E8480
               	cmovgeq	%rdx, %rcx
               	movq	%rcx, %rax
               	popq	%rbx
               	addq	$0x6a0, %rsp            # imm = 0x6A0
               	retq
